import 'package:flutter/material.dart';
import "pages/camera/camera.dart";
import './pages/my.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import "./pages/picture.dart";

late var firstCamera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //   // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  //   // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '快排',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Tabs(),
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({super.key});
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    TakePictureScreen(
      // Pass the appropriate camera to the TakePictureScreen widget.
      camera: firstCamera,
    ),
    Yolo(),
    MyPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("快排")),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (v) {
          setState(() {
            _currentIndex = v;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.perm_media), label: "图库"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
