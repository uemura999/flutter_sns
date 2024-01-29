// packages
import 'package:uuid/uuid.dart';

const String selectTitle = "選択";

// titles
const String appTitle = "SNS";
const String signupTitle = "新規登録";
const String loginTitle = "ログイン";
const String accountTitle = "アカウント";
const String themeTitle = "テーマ";
const String profileTitle = "プロフィール";
const String adminTitle = "管理者";
const String createPostTitle = "投稿を作成";
const String commentTitle = "コメント";
const String replyTitle = "リプライ";
const String editProfilePageTitle = "プロフィール編集ページ";
const String muteUsersPageTitle = "ミュートしているユーザー";
const String muteCommentsPageTitle = "ミュートしているコメント";
const String mutePostsPageTitle = "ミュートしている投稿";
const String muteRepliesPageTitle = "ミュートしているリプライ";
const String reauthenticationPageTitle = "再認証";
const String updatePasswordPageTitle = "新しいパスワード";
const String updateEmailPageTitle = "新しいメールアドレス";
const String forgetPasswordPageTitle = "パスワードを忘れた場合";
// texts
const String mailAddressText = "メールアドレス";
const String passwordText = "パスワード";
const String signupText = "新規登録を行う";
const String cropperTitle = "Cropper";
const String loginText = "ログインする";
const String logoutText = "ログアウトを行う";
const String loadingText = "Loading";
const String uploadText = "アップロードする";
const String reloadText = "再読み込みを行う";
const String createCommentText = "コメントを作成";
const String createReplyText = "リプライを作成";
const String editProfileText = "プロフィールを編集する";
const String updateText = "更新する";
const String showMuteUsersText = "ミュートしているユーザーを表示する";
const String showMuteCommentsText = "ミュートしているコメントを表示する";
const String showMutePostsText = "ミュートしている投稿を表示する";
const String showMuteRepliesText = "ミュートしているリプライを表示する";
const String yesText = "Yes";
const String noText = "No";
const String backText = "戻る";
const String muteUserText = "ユーザーをミュート";
const String muteCommentText = "コメントをミュート";
const String mutePostText = "投稿をミュート";
const String muteReplyText = "リプライをミュート";
const String unMuteUserText = "ユーザーのミュートを解除";
const String unMuteCommentText = "コメントのミュートを解除";
const String unMutePostText = "投稿のミュートを解除";
const String unMuteReplyText = "リプライのミュートを解除";
const String reauthenticateText = "再認証をする";
const String updatePasswordText = "パスワードをアップデートする";
const String updateEmailText = "メールアドレスをアップデートする";
const String forgetPasswordText = "パスワードを忘れた場合";
const String sendResetEmailText = "パスワードリセット用のメールを送信する";
const String loginMailAddressText = 'ログインするメールアドレス';
const String followText = "フォローする";
const String unFollowText = "フォローを解除する";

// alert message
const String muteUserAlertMsg = 'ユーザーをミュートしますが本当によろしいですか？';
const String muteCommentAlertMsg = "コメントをミュートしますが本当によろしいですか？";
const String mutePostAlertMsg = "投稿をミュートしますが本当によろしいですか？";
const String muteReplyAlertMsg = "リプライをミュートしますが本当によろしいですか？";
const String unMuteUserAlertMsg = 'ユーザーのミュートを解除しますが本当によろしいですか？';
const String unMuteCommentAlertMsg = "コメントのミュートを解除しますが本当によろしいですか？";
const String unMutePostAlertMsg = "投稿のミュートを解除しますが本当によろしいですか？";
const String unMuteReplyAlertMsg = "リプライのミュートを解除しますが本当によろしいですか?";
const String updatedPasswordMsg = "パスワードのアップデートが完了しました";
const String requiresRecentLoginMsg = "再認証を行ってください";

// message
const String userCreatedMsg = "ユーザーが作成できました";
const String noAccountMsg = "アカウントをお持ちでない場合";
const String emailAlreadyInUseMsg = "そのemailはもう使われています";
const String firebaseAuthEmailOperationNotAllowed =
    "Firebaseでemail/passwordが許可されていません";
const String weakPasswordMsg = "パスワードが弱すぎます";
const String invalidEmailMsg = "そのメールアドレスはふさわしくありません";
const String wrongPasswordMsg = "パスワードが違います";
const String userNotFoundMsg = "そのメールアドレスに対応するユーザーが見つかりません";
const String userDisabledMsg = "そのユーザーは無効化されています";
const String reauthenticatedMsg = "再認証が完了しました";
const String userMismatchMsg = "与えられたクレデンシャルがユーザーに対応していません";
const String invalidCredentialMsg = "プロバイダのクレデンシャルが有効ではありません";
const String emailSendedMsg = "メールが送信されました";
const String somethingWentWrongMsg = "何かがおかしいです";
const String passwordResetEmailSentMsg = "パスワードリセット用のメールが送信されました";
const String missingAndroidPkgNameMsg = "Androidパッケージ名が見つかりません";
const String missingIosBundleIdMsg = "iOSバンドルIDが見つかりません";
const String sendEmailVerificationMsg = "メールアドレスの確認用のメールを送信しました";
const String createdPostMsg = "投稿が作成されました(表示するには時間がかかります。)";
// prefs key
const String isDarkThemePrefsKey = "isDarkTheme";
// bottom navigation bar
const String homeText = "Home";
const String searchText = "Search";
const String profileText = "Profile";
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";

String updateEmailLagMsg({required String email}) =>
    "$email('更新が反映されるまで時間がかかる可能性がございます')";
