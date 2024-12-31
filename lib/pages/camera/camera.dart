import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import './lib/ultralytics_yolo.dart';
// import './lib/yolo_model.dart';

import './yolomodel.dart';
//yolo框架
// final model = LocalYoloModel(
//   id: "",
//   task: Task.detect /* or Task.classify */,
//   format: Format.tflite /* or Format.coreml*/,
//   modelPath: 'assets/yolov8n-cls.mlmodel',
//   metadataPath: 'assets/metadata.yaml',
// );

// Future<String> _copy(String assetPath) async {
//   final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
//   await io.Directory(dirname(path)).create(recursive: true);
//   final file = io.File(path);
//   if (!await file.exists()) {
//     final byteData = await rootBundle.load(assetPath);
//     await file.writeAsBytes(
//       byteData.buffer.asUint8List(
//         byteData.offsetInBytes,
//         byteData.lengthInBytes,
//       ),
//     );
//   }
//   return file.path;
// }

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Timer? _timer;
  bool _isTakingPictures = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 第一个按钮
          FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _controller.takePicture();
                // 自定义保存路径
                final String customPath = '/storage/emulated/0/DCIM/QuickCheck';
                print(getApplicationSupportDirectory());
                // 确保目标目录存在
                final directoryPath = Directory(customPath);
                if (!await directoryPath.exists()) {
                  await directoryPath.create(recursive: true);
                }

                // 设置文件的最终路径
                final String filePath =
                    '$customPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
                // final String filePath = '$customPath/a.jpg';
                // 将拍照的图片保存到自定义路径
                await File(image.path).copy(filePath);
                // 删除缓存文件
                await File(image.path).delete();
                // print('Picture saved to $filePath');

                if (!context.mounted) return;
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
          SizedBox(width: 10),
          // 第二个按钮
          FloatingActionButton(
            onPressed: () {
              //每秒拍一次
              // 切换状态
              _isTakingPictures = !_isTakingPictures;

              if (_isTakingPictures) {
                // 停止拍照
                _timer?.cancel();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Stopped taking pictures.'),
                    duration: Duration(seconds: 2), // 显示2秒
                  ),
                );
              } else {
                // 开始拍照
                _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
                  final XFile picture = await _controller.takePicture();

                  // 设置保存路径
                  final String customPath =
                      '/storage/emulated/0/DCIM/QuickCheck';
                  final directoryPath = Directory(customPath);
                  if (!await directoryPath.exists()) {
                    await directoryPath.create(recursive: true);
                  }

                  final String filePath =
                      '$customPath/picture_${DateTime.now().millisecondsSinceEpoch}.jpg';
                  await File(picture.path).copy(filePath);
                });
              }
            },
            child: Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}


// /data/user/0/com.example.quickcheck/cache/CAP4949030281044214642.jpg