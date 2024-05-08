import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

//import '../../providers/options_provider.dart';

// class VideoConferencePage extends ConsumerStatefulWidget {
//   const VideoConferencePage({super.key});

//   @override
//   ConsumerState<VideoConferencePage> createState() {
//     return _VideoConferencePageState();
//   }
// }

// class _VideoConferencePageState extends ConsumerState<VideoConferencePage> {
//   @override
//   Widget build(BuildContext context) {
//     final conferenceID = ref.read(conferenceIdProvider);
//     final user = ref.read(userProvider);
//     return SafeArea(
//       child: ZegoUIKitPrebuiltVideoConference(
//         appID: 1218285936, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//         appSign: 'd7ccb736feee2d538cfe1baad0aed116a49a6d7a03a013c9977f38048d0d9849', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//         userID: user.id.toString(),
//         userName: user.fullname!,
//         conferenceID: '123456',
//         config: ZegoUIKitPrebuiltVideoConferenceConfig(),
//       ),
//     );
//   }
// }

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userId;
  final String fullname;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
    required this.userId,
    required this.fullname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1218285936, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: 'd7ccb736feee2d538cfe1baad0aed116a49a6d7a03a013c9977f38048d0d9849', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userId,
        userName: fullname,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
