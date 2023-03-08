// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';

// void main() async {
//   // Replace these URLs with your actual RTSP and RTMP stream URLs
//   String rtspUrl = 'rtsp://your.rtsp.stream.url';
//   String rtmpUrl = 'rtmp://your.rtmp.stream.url';

//   // Initialize FFmpegKit
//   await FFmpegKitConfig.init();

//   // Build the FFmpeg command to convert the RTSP stream to RTMP stream
//   String command =
//       '-rtsp_transport tcp -i $rtspUrl -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac -f flv $rtmpUrl';

//   // Execute the FFmpeg command
//   final session = FFmpegKit.executeAsync(command);

//   // Register a listener to handle the session events
//   session.then((session) async {
//     print('Session complete with state ${session.getState()}');

//     if ((await session.getReturnCode())?.getValue() == 0) {
//       print('Conversion successful');
//     } else {
//       print('Conversion failed');
//     }

//     // Cleanup FFmpegKit
//     FFmpegKitConfig.clearSessions();
//     FFmpegKit.cancel(session.getSessionId());
//   });
// }
