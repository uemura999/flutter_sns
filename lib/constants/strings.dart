//packages
import 'package:uuid/uuid.dart';

//titles
const String appTitle = 'SNS';
const String editProfilePageTitle = 'Edit profile page';
const String signupTitle = 'signup';
const String loginTitle = 'login';
const String cropperTitle = 'Cropper';
const String accountTitle = "Account";
const String themeTitle = 'Theme';
const String profileTitle = 'Profile';
const String createPostTitle = 'Create Post';
const String adminTitle = 'Admin';
const String commentTitle = 'Comment';
const String replyTitle = 'Reply';
const String muteUsersPageTitle = 'Mute Users';
const String mutePostsPageTitle = 'Mute Posts';
const String muteCommentPageTitle = 'Mute Comments';
const String muteReplyPageTitle = 'Mute Replies';
const String selectTitle = 'Select an option';

//bottomNavigationBar
const String homeText = 'home';
const String searchText = 'search';
const String profileText = 'profile';

//id
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

//jpg
String returnJpgFileName() => "${returnUuidV4()}.jpg";

//texts
const String editProfileText = 'edit profile';
const String reloadText = 'reload';
const String createCommentText = 'Create Comment';
const String createReplyText = 'Create Reply';
const String mailAddressText = 'mail address';
const String passwordText = 'password';
const String signupText = 'Do signup';
const String loginText = 'Do login';
const String logoutText = 'Do logout';
const String loadingText = 'loading...';
const String uploadText = 'Upload';
const String updateText = 'Update';
const String showMuteUsersText = 'Show Mute Users';
const String showMutePostsText = 'Show Mute Posts';
const String showMuteCommentsText = 'Show Mute Comments';
const String showMuteRepliesText = 'Show Mute Replies';
const String yesText = 'Yes';
const String noText = 'No';
const String muteUserText = 'Mute this user';
const String unMuteUserText = 'Unmute this user';
const String mutePostText = 'Mute this post';
const String unMutePostText = 'Unmute this post';
const String muteCommentText = 'Mute this comment';
const String unMuteCommentText = 'Unmute this comment';
const String muteReplyText = 'Mute this reply';
const String unMuteReplyText = 'Unmute this reply';
const String backText = 'Back';

//alert messages
const String muteUserAlertMsg = 'Do you want to mute this user?';
const String unMuteUserAlertMsg = 'Do you want to unmute this user?';
const String mutePostAlertMsg = 'Do you want to mute this post?';
const String unMutePostAlertMsg = 'Do you want to unmute this post?';
const String muteCommentAlertMsg = 'Do you want to mute this comment?';
const String unMuteCommentAlertMsg = 'Do you want to unmute this comment?';
const String muteReplyAlertMsg = 'Do you want to mute this reply?';
const String unMuteReplyAlertMsg = 'Do you want to unmute this reply?';

//name
const String aliceName = 'Alice';

//fieldKey
const String usersFieldKey = 'users';

//messages
const String userCreatedMsg = 'ユーザーが作成されました';
const String noAccountMsg = 'アカウントをお持ちでない場合';
const String emailAlredyInUseMsg = 'このメールアドレスは既に登録されています';
const String firebaseAuthEmailOperationNotAllowedMsg =
    'Firebaseでemail/passwordが許可されていません';
const String weakPasswordMsg = 'パスワードが弱すぎます';
const String invalidEmailMsg = 'メールアドレスが無効です';
const String loginErrorMsg = 'メールアドレスまたはパスワードが間違っています';

//pref key
const String isDarkThemePrefsKey = 'isDarkTheme';
