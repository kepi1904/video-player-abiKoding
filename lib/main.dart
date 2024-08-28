import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/dropdown.mp4', // Path ke file video di assets
    )..initialize().then((_) {
        setState(() {}); // Refresh UI setelah video diinisialisasi
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'AbiKoding Player',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
      body: Stack(
        children: [
          const Positioned(
              top: 250,
              left: 10,
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("AbiKoding"),
                  SizedBox(
                    width: 10,
                  ),
                  Card(
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Subscribe",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up),
                          SizedBox(
                            width: 10,
                          ),
                          Text("1M")
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Icon(Icons.share), Text("Share")],
                      ),
                    ),
                  )
                ],
              )),
          const Positioned(
              top: 220,
              left: 10,
              child: Text(
                "Flutter Beginner",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )),
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: _controller.value.isInitialized
                ? SizedBox(height: 200, child: VideoPlayer(_controller))
                : const CircularProgressIndicator(),
          ), // Tampilkan loading saat video belum siap

          Positioned(
            right: 180,
            top: 105,
            child: Container(
              color:
                  _controller.value.isPlaying ? Colors.transparent : Colors.red,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
