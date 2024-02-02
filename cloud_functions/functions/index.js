const admin = require("firebase-admin");
const functions = require('firebase-functions');
const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const plusOne = 1;
const minusOne = -1;
const config = functions.config();
admin.initializeApp(config.firebase);

//algolia
const algoliasearch = require('algoliasearch');
const algoliaConfig = config.algolia;
const ALGOLIA_APP_ID = algoliaConfig.app_id;
const ALGOLIA_ADMIN_KEY = algoliaConfig.admin_key;
const ALGOLIA_POSTS_INDEX_NAME = 'Posts';
const client = algoliasearch(ALGOLIA_APP_ID, ALGOLIA_ADMIN_KEY);

//AWS
const AWS = require('aws-sdk');
const aws_config = config.aws;
const AWS_ACCESS_KEY_ID = aws_config.access_key_id; //AWS_ACCESS_KEY_IDで設定した方が良い　環境変数に設定する
const AWS_SECRET_ACCESS_KEY = aws_config.secret_access_key;
const AWS_REGION = 'ap-southeast-1';
//IAM設定
AWS.config.update({
    accessKeyId: AWS_ACCESS_KEY_ID, 
    secretAccessKey: AWS_SECRET_ACCESS_KEY,
    region: AWS_REGION
});
//comprehendに渡す値を準備
const comprehend = new AWS.Comprehend({apiVersion: '2017-11-27'});

const fireStore = admin.firestore();
const batchLimit = 500;
function mal100AndRoundingDown(num) {
    const mal100 = num * 100; //ex) 0.9988のデータを99.88にする
    const result = Math.floor(mal100); //ex) 99.88を99にする
    return result;
}

exports.onUserCreate = functions.firestore.document('users/{uid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        const ref = snap.ref;
        const text = newValue.userName; //解析したい値
        const dDParams = {
            Text: text,
        };
        //主要な言語のcodeを取得する
        //'ja', 'en' ....
        let lCode = '';
        comprehend.detectDominantLanguage(
            dDParams, 
            async (dDErr, dDData) => {
                //dDErrにはdetectDominantLanguageで発生したエラーコードが入る
                //dDDataにはdetectDominantLanguageで取得したデータが入る
                if (dDErr) {
                    //もしエラーが発生した場合はエラーをログに出力する
                    console.log(dDErr);
                } else {
                    //dDDataは複数のLanguageCodeを返す
                    // 例: ja 90%, en 10%
                    lCode = dDData.Languages[0]['LanguageCode'];//いちばん確率の高い言語を取得する
                    if (lCode) {
                        //lCodeが空欄でなければdetectSentimentを実行する
                        const dSParams = {
                            LanguageCode: lCode,
                            Text: text,
                        };
                        comprehend.detectSentiment(
                            dSParams, 
                            async (dSErr, dSData) => {
                                if (dSErr) {
                                    console.log(dSErr);
                                } else {
                                    await ref.update({
                                        'userNameLanguageCode': lCode,
                                        'userNameNegativeScore': mal100AndRoundingDown(dSData.SentimentScore.Negative),
                                        'userNamePositiveScore': mal100AndRoundingDown(dSData.SentimentScore.Positive),
                                        'userNameSentiment': dSData.Sentiment,
                                    });
                                }
                            }
                            );
                    }
                }
            }
        );
    }
);

exports.onDeleteUserCreate = functions.firestore.document('deleteUsers/{uid}').onCreate(
    async (snap, _) => {
        const uid = snap.id;
        const myRef = fireStore.collection('users').doc(uid);
        //末端ほど先に削除する
        //まず、自分が作成したリプライを削除
        const replies = await fireStore.collectionGroup('postCommentReplies').where('uid', '==', uid).get();
        let replyCount = 0;
        let replyBatch = fireStore.batch();
        for (const reply of replies.docs) {
            replyBatch.delete(reply.ref);
            replyCount++;
            if (replyCount == batchLimit) {
                await replyBatch.commit();
                replyBatch = fireStore.batch();
                replyCount = 0;
            }
        }
        if (replyCount > 0) {
            await replyBatch.commit();
        }

        //次に、自分が作成したコメントを削除
        const comments = await fireStore.collectionGroup('postComments').where('uid', '==', uid).get();
        let commentCount = 0;
        let commentBatch = fireStore.batch();
        for (const comment of comments.docs) {
            commentBatch.delete(comment.ref);
            commentCount++;
            if (commentCount == batchLimit) {
                await commentBatch.commit();
                commentBatch = fireStore.batch();
                commentCount = 0;
            }
        }
        if (commentCount > 0) {
            await commentBatch.commit();
        }

        //自分の投稿を削除
        const posts = await myRef.collection('posts').get();
        let postCount = 0;
        let postBatch = fireStore.batch();
        for (const post of posts.docs) {
            postBatch.delete(post.ref);
            postCount++;
            if (postCount == batchLimit) {
                await postBatch.commit();
                postBatch = fireStore.batch();
                postCount = 0;
            }
        }
        if (postCount > 0) {
            await postBatch.commit();
        }

        //自分のタイムラインを削除
        const timelines = await myRef.collection('timelines').get();
        let timelineCount = 0;
        let timelineBatch = fireStore.batch();
        for (const timeline of timelines.docs) {
            timelineBatch.delete(timeline.ref);
            timelineCount++;
            if (timelineCount == batchLimit) {
                await timelineBatch.commit();
                timelineBatch = fireStore.batch();
                timelineCount = 0;
            }
        }
        if (timelineCount > 0) {
            await timelineBatch.commit();
        }

        //自分のtokenを削除
        const tokens = await myRef.collection('tokens').get();
        let tokenCount = 0;
        let tokenBatch = fireStore.batch();
        for (const token of tokens.docs) {
            tokenBatch.delete(token.ref);
            tokenCount++;
            if (tokenCount == batchLimit) {
                await tokenBatch.commit();
                tokenBatch = fireStore.batch();
                tokenCount = 0;
            }
        }
        if (tokenCount > 0) {
            await tokenBatch.commit();
        }

        await myRef.delete(); //一番最後に行う
    }
);

//cloud functionはsecurity rulesを無視することができる。
exports.onFollowerCreate = functions.firestore.document('users/{uid}/followers/{followerUid}').onCreate(
    async (snap,_) => {
        const newValue = snap.data();
        await fireStore.collection('users').doc(newValue.followedUid).update(
            {'followerCount': admin.firestore.FieldValue.increment(plusOne),
        }
        );
        await fireStore.collection('users').doc(newValue.followerUid).update(
            {'followingCount': admin.firestore.FieldValue.increment(plusOne),
        }
        );
    }
);

exports.onFollowerDelete = functions.firestore.document('users/{uid}/followers/{followerUid}').onDelete(
    async (snap,_) => {
        const newValue = snap.data();
        await fireStore.collection('users').doc(newValue.followedUid).update(
        {'followerCount': admin.firestore.FieldValue.increment(minusOne)}
        );
        await fireStore.collection('users').doc(newValue.followerUid).update(
            {'followingCount': admin.firestore.FieldValue.increment(minusOne)}
        );
    }
);

exports.onUserMutesCreate = functions.firestore.document('users/{uid}/userMutes/{activeUid}').onCreate(
    async (snap,_) => {
        const newValue = snap.data();
        await newValue.passiveUserRef.update(
            {'muteCount': admin.firestore.FieldValue.increment(plusOne),
        }
        );
    }
);

exports.onUserMutesDelete = functions.firestore.document('users/{uid}/userMutes/{activeUid}').onDelete(
    async (snap,_) => {
        const newValue = snap.data();
        await newValue.passiveUserRef.update(
            {'muteCount': admin.firestore.FieldValue.increment(minusOne),
        }
        );
    }
);

exports.onPostLikeCreate = functions.firestore.document('users/{uid}/posts/{postId}/postLikes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postRef.update({'likeCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);


exports.onPostLikeDelete = functions.firestore.document('users/{uid}/posts/{postId}/postLikes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postRef.update({'likeCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onPostMuteCreate = functions.firestore.document('users/{uid}/posts/{postId}/postMutes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postRef.update({'muteCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostMuteDelete = functions.firestore.document('users/{uid}/posts/{postId}/postMutes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postRef.update({'muteCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);


exports.onPostCommentCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}').onCreate(
    async (snap, _) => {
        
        const newValue = snap.data();
        const ref = snap.ref;
        const text = newValue.commentString; //解析したい値
        const dDParams = {
            Text: text,
        };
        //主要な言語のcodeを取得する
        //'ja', 'en' ....
        let lCode = '';
        comprehend.detectDominantLanguage(
            dDParams, 
            async (dDErr, dDData) => {
                //dDErrにはdetectDominantLanguageで発生したエラーコードが入る
                //dDDataにはdetectDominantLanguageで取得したデータが入る
                if (dDErr) {
                    //もしエラーが発生した場合はエラーをログに出力する
                    console.log(dDErr);
                } else {
                    //dDDataは複数のLanguageCodeを返す
                    // 例: ja 90%, en 10%
                    lCode = dDData.Languages[0]['LanguageCode'];//いちばん確率の高い言語を取得する
                    if (lCode) {
                        //lCodeが空欄でなければdetectSentimentを実行する
                        const dSParams = {
                            LanguageCode: lCode,
                            Text: text,
                        };
                        comprehend.detectSentiment(
                            dSParams, 
                            async (dSErr, dSData) => {
                                if (dSErr) {
                                    console.log(dSErr);
                                } else {
                                    await ref.update({
                                        'commentLanguageCode': lCode,
                                        'commentNegativeScore': mal100AndRoundingDown(dSData.SentimentScore.Negative),
                                        'commentPositiveScore': mal100AndRoundingDown(dSData.SentimentScore.Positive),
                                        'commentSentiment': dSData.Sentiment,
                                    });
                                }
                            }
                            );
                    }
                }
            }
        );

        await newValue.postRef.update({'commentCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);
    
exports.onPostCommentDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postRef.update({'commentCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);
        
exports.onPostCommentLikeCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentLikes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentRef.update({'likeCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostCommentLikeDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentLikes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentRef.update({'likeCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onPostCommentMuteCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentMutes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentRef.update({'muteCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostCommentMuteDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentMutes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentRef.update({'muteCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onPostCommentReplyCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}').onCreate(
    async (snap, _) => {
        
        const newValue = snap.data();
        const ref = snap.ref;
        const text = newValue.replyString; //解析したい値
        const dDParams = {
            Text: text,
        };
        //主要な言語のcodeを取得する
        //'ja', 'en' ....
        let lCode = '';
        comprehend.detectDominantLanguage(
            dDParams, 
            async (dDErr, dDData) => {
                //dDErrにはdetectDominantLanguageで発生したエラーコードが入る
                //dDDataにはdetectDominantLanguageで取得したデータが入る
                if (dDErr) {
                    //もしエラーが発生した場合はエラーをログに出力する
                    console.log(dDErr);
                } else {
                    //dDDataは複数のLanguageCodeを返す
                    // 例: ja 90%, en 10%
                    lCode = dDData.Languages[0]['LanguageCode'];//いちばん確率の高い言語を取得する
                    if (lCode) {
                        //lCodeが空欄でなければdetectSentimentを実行する
                        const dSParams = {
                            LanguageCode: lCode,
                            Text: text,
                        };
                        comprehend.detectSentiment(
                            dSParams, 
                            async (dSErr, dSData) => {
                                if (dSErr) {
                                    console.log(dSErr);
                                } else {
                                    await ref.update({
                                        'replyLanguageCode': lCode,
                                        'replyNegativeScore': mal100AndRoundingDown(dSData.SentimentScore.Negative),
                                        'replyPositiveScore': mal100AndRoundingDown(dSData.SentimentScore.Positive),
                                        'replySentiment': dSData.Sentiment,
                                    });
                                }
                            }
                            );
                    }
                }
            }
        );

        await newValue.postCommentRef.update({'postCommentReplyCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostCommentReplyDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentRef.update({'postCommentReplyCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onPostCommentReplyLikeCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}/postCommentReplyLikes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentReplyRef.update({'likeCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostCommentReplyLikeDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}/postCommentReplyLikes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentReplyRef.update({'likeCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onPostCommentReplyMuteCreate = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}/postCommentReplyMutes/{activeUid}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentReplyRef.update({'muteCount': admin.firestore.FieldValue.increment(plusOne)});
    }
);

exports.onPostCommentReplyMuteDelete = functions.firestore.document('users/{uid}/posts/{postId}/postComments/{postCommentId}/postCommentReplies/{postCommentReplyId}/postCommentReplyMutes/{activeUid}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        await newValue.postCommentReplyRef.update({'muteCount': admin.firestore.FieldValue.increment(minusOne)});
    }
);

exports.onUserUpdateLogCreate = functions.firestore.document('users/{uid}/userUpdateLogs/{userUpdateLogId}').onCreate(
    async (snap, _) => {
        //newValueにはUserUpdateLogの情報が入っている
        const newValue = snap.data();
        const userRef = newValue.userRef;
        const uid = newValue.uid;
        const userName = newValue.userName;
        const userImageURL = newValue.userImageURL;
        const searchToken = newValue.searchToken;
        const now = admin.firestore.Timestamp.now();

        const text = userName; //解析したい値
        const dDParams = {
            Text: text,
        };
        //主要な言語のcodeを取得する
        //'ja', 'en' ....
        let lCode = '';
        comprehend.detectDominantLanguage(
            dDParams, 
            async (dDErr, dDData) => {
                //dDErrにはdetectDominantLanguageで発生したエラーコードが入る
                //dDDataにはdetectDominantLanguageで取得したデータが入る
                if (dDErr) {
                    //もしエラーが発生した場合はエラーをログに出力する
                    console.log(dDErr);
                } else {
                    //dDDataは複数のLanguageCodeを返す
                    // 例: ja 90%, en 10%
                    lCode = dDData.Languages[0]['LanguageCode'];//いちばん確率の高い言語を取得する
                    if (lCode) {
                        //lCodeが空欄でなければdetectSentimentを実行する
                        const dSParams = {
                            LanguageCode: lCode,
                            Text: text,
                        };
                        comprehend.detectSentiment(
                            dSParams, 
                            async (dSErr, dSData) => {
                                if (dSErr) {
                                    console.log(dSErr);
                                } else {

        await userRef.update({
            //textの解析とLog経由のupdateを兼ねている
            'searchToken': searchToken,
            'userName': userName,
            'userImageURL': userImageURL,
            'userNameLanguageCode': lCode,
            'userNameNegativeScore': mal100AndRoundingDown(dSData.SentimentScore.Negative),  
            'userNamePositiveScore': mal100AndRoundingDown(dSData.SentimentScore.Positive),
            'userNameSentiment': dSData.Sentiment,
            //updatedAtは改竄されないようにcloud functionsで制限する
            'updatedAt': now,
        });
                                }
                            }
                            );
                    }
                }
            }
        );
        //複数の投稿をupdateするのでbatchが必要
        const postQshot = await fireStore.collection('users').doc(uid).collection('posts').get();
        let postCount = 0;
        let postBatch = fireStore.batch();
        for (const post of postQshot.docs) {
            postBatch.update(post.ref, {
                'userName': userName,
                'userImageURL': userImageURL,
                'updatedAt': now,
            });
            postCount++;
            if(postCount == batchLimit) {
                //500件ごとにcommitする
                await postBatch.commit();
                //batchを初期化
                postBatch = fireStore.batch();
                postCount = 0;
            }        
        }
        if(postCount > 0) {
            await postBatch.commit();
        }
        //commentの処理
        //collectionGroupを使用し、fieldで制限する(uidとか)場合は除外が必要になる なぜなら、collectionGroupは全てのコレクションを対象にするためuidによる制限が必要だから
        const commentQshot = await fireStore.collectionGroup('postComments').where('uid', '==', uid).get();
        let commentCount = 0;
        let commentBatch = fireStore.batch();
        for (const comment of commentQshot.docs) {
            commentBatch.update(comment.ref, {
                'userName': userName,
                'userImageURL': userImageURL,
                'updatedAt': now,
            });
            commentCount++;
            if(commentCount == batchLimit) {
                //500件ごとにcommitする
                await commentBatch.commit();
                //batchを初期化
                commentBatch = fireStore.batch();
                commentCount = 0;
            }        
        }
        if(commentCount > 0) {
            await commentBatch.commit();
        }

        //replyの処理
        const replyQshot = await fireStore.collectionGroup('postCommentReplies').where('uid', '==', uid).get();
        let replyCount = 0;
        let replyBatch = fireStore.batch();
        for (const reply of replyQshot.docs) {
            replyBatch.update(reply.ref, {
                'userName': userName,
                'userImageURL': userImageURL,
                'updatedAt': now,
            });
            replyCount++;
            if(replyCount == batchLimit) {
                //500件ごとにcommitする
                await replyBatch.commit();
                //batchを初期化
                replyBatch = fireStore.batch();
                replyCount = 0;
            }        
        }
        if(replyCount > 0) {
            await replyBatch.commit();
        }
    }
);

exports.onPostCreate = functions.firestore.document('users/{uid}/posts/{postId}').onCreate(
    async (snap, _) => {
        const newValue = snap.data();
        const ref = snap.ref;

        //detectSentiment
        const text = newValue.text; //解析したい値
        const dDParams = {
            Text: text,
        };
        //主要な言語のcodeを取得する
        //'ja', 'en' ....
        let lCode = '';
        comprehend.detectDominantLanguage(
            dDParams, 
            async (dDErr, dDData) => {
                //dDErrにはdetectDominantLanguageで発生したエラーコードが入る
                //dDDataにはdetectDominantLanguageで取得したデータが入る
                if (dDErr) {
                    //もしエラーが発生した場合はエラーをログに出力する
                    console.log(dDErr);
                } else {
                    //dDDataは複数のLanguageCodeを返す
                    // 例: ja 90%, en 10%
                    lCode = dDData.Languages[0]['LanguageCode'];//いちばん確率の高い言語を取得する
                    if (lCode) {
                        //lCodeが空欄でなければdetectSentimentを実行する
                        const dSParams = {
                            LanguageCode: lCode,
                            Text: text,
                        };
                        comprehend.detectSentiment(
                            dSParams, 
                            async (dSErr, dSData) => {
                                if (dSErr) {
                                    console.log(dSErr);
                                } else {
                                    await ref.update({
                                        'textLanguageCode': lCode,
                                        'textNegativeScore': mal100AndRoundingDown(dSData.SentimentScore.Negative),
                                        'textPositiveScore': mal100AndRoundingDown(dSData.SentimentScore.Positive),
                                        'textSentiment': dSData.Sentiment,
                                    });
                                }
                            }
                            );
                    }
                }
            }
        );

        //algolia
        newValue.objectID = snap.id; //objectIDはalgolia専用のid
        const index = client.initIndex(ALGOLIA_POSTS_INDEX_NAME);//Postsに保存
        index.saveObject(newValue);
        //myBatchは2回しか使用されない

        //postCountのupdateとtimelineのset
        const myBatch = fireStore.batch();
        const myRef = fireStore.collection('users').doc(newValue.uid);
        myBatch.update(myRef, {
            'postCount': admin.firestore.FieldValue.increment(plusOne),
        });

        // timelineを作成
        const timeline = {
            'createdAt': newValue.createdAt,
            'isRead': false,
            'postCreatorUid': newValue.uid,
            'postId': newValue.postId,
        }
        //自分のタイムラインに自分の投稿をセットする
        myBatch.set(myRef.collection('timelines').doc(newValue.postId), timeline);
        await myBatch.commit();

        // //コメントアウトする　フォロワーのタイムラインに自分の投稿をセットする
        // //followersを取得
        // const followers = await fireStore.collection('users').doc(newValue.uid).collection('followers').get();
        // let count = 0;
        // let batch = fireStore.batch();
        // for (const follower of followers.docs) {
        //     const data = follower.data();
        //     const ref = fireStore.collection('users').doc(data.followerUid).collection('timelines').doc(newValue.postId);
        //     batch.set(ref, timeline);
        //     count++;
        //     if (count == batchLimit) {
        //         await batch.commit();
        //         batch = fireStore.batch();
        //         count = 0;
        //     }
        // }
        // if (count > 0) {
        //     await batch.commit();
        // }

    }
);

exports.onPostDelete = functions.firestore.document('users/{uid}/posts/{postId}').onDelete(
    async (snap, _) => {
        const newValue = snap.data();
        const objectID = snap.id; //objectIDはalgolia専用のid
        const index = client.initIndex(ALGOLIA_POSTS_INDEX_NAME);
        index.deleteObject(objectID);

        const myRef = fireStore.collection('users').doc(newValue.uid);
        const myBatch = fireStore.batch();
        myBatch.update(myRef, {
            'postCount': admin.firestore.FieldValue.increment(minusOne),
        });
        await myBatch.commit();
    }
);


