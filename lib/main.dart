import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RtspPlayerScreen(
        url: 'rtsp://admin:islam_123@192.168.1.4:554',
      ),
    );
  }
}

class RtspPlayerScreen extends StatefulWidget {
  final String url;

  const RtspPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  RtspPlayerScreenState createState() => RtspPlayerScreenState();
}

class RtspPlayerScreenState extends State<RtspPlayerScreen> {
  VideoPlayerController? _controller;

  Future<HttpServer> bindServer() async =>
      await HttpServer.bind('localhost', 8080);

  @override
  void initState() {
    super.initState();

    bindServer().then((server) {
      // Convert RTSP stream to HLS format

      server.listen((request) {
        print(request.response);
      });

      String outputUrl =
          'http://${server.address.host}:${server.port}/stream.m3u8';

      final String ffmpegCommand =
          '-i ${widget.url} -preset ultrafast -tune zerolatency -hls_time 1 -hls_list_size 10 -f hls $outputUrl';
      FFmpegKit.execute(ffmpegCommand).then((rc) {
        _controller = VideoPlayerController.network(outputUrl);
        _controller?.initialize().then((_) {
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('RTSP Player')),
        body: Center(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
