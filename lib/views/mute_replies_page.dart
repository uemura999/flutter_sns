//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:udemy_flutter_sns/constants/strings.dart';
import 'package:udemy_flutter_sns/constants/voids.dart' as voids;
//domain
import 'package:udemy_flutter_sns/domain/reply/reply.dart';
//models
import 'package:udemy_flutter_sns/models/main_model.dart';
import 'package:udemy_flutter_sns/models/mute_replies_model.dart';
//components
import 'package:udemy_flutter_sns/details/user_image.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
import 'package:udemy_flutter_sns/views/refresh_screen.dart';

class MuteRepliesPage extends ConsumerWidget {
  const MuteRepliesPage({Key? key, required this.mainModel}) : super(key: key);
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MuteRepliesModel muteRepliesModel = ref.watch(muteRepliesProvider);
    final muteReplyDocs = muteRepliesModel.muteReplyDocs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(muteReplyPageTitle),
      ),
      body: muteRepliesModel.showMuteReplies
          ? RefreshScreen(
              onRefresh: () async => await muteRepliesModel.onRefresh(),
              onLoading: () async => await muteRepliesModel.onLoading(),
              refreshController: muteRepliesModel.refreshController,
              child: ListView.builder(
                  itemCount: muteReplyDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final mutereplyDoc = muteReplyDocs[index];
                    final Reply muteReply =
                        Reply.fromJson(mutereplyDoc.data()!);
                    return ListTile(
                      leading: UserImage(
                          length: 60, userImageURL: muteReply.userImageURL),
                      title: Text(muteReply.replyString),
                      onTap: () => voids.showPopUp(
                        context: context,
                        builder: (BuildContext innerContext) =>
                            CupertinoActionSheet(
                          title: const Text(selectTitle),
                          actions: [
                            CupertinoActionSheetAction(
                              // This parameter indicates the action would perform
                              // a destructive action such as delete or exit and turns
                              // the action's text color to red.
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(innerContext);
                                muteRepliesModel.showUnMuteReplyDialog(
                                  context: context,
                                  mainModel: mainModel,
                                  replyDoc: mutereplyDoc,
                                );
                              },
                              child: const Text(unMuteReplyText),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () => Navigator.pop(innerContext),
                              child: const Text(backText),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: RoundedButton(
                    onPressed: () async => await muteRepliesModel
                        .getMuteReplies(mainModel: mainModel),
                    widthRate: 0.85,
                    color: Colors.blue,
                    text: showMuteRepliesText),
              )
            ]),
    );
  }
}
