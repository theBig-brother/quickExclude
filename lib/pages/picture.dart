// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // 导入这个包以使用 File 类

// import './camera/yolomodel.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class Yolo extends StatefulWidget {
  const Yolo({super.key});

  @override
  State<Yolo> createState() => _YoloState();
}

class _YoloState extends State<Yolo> {
  var label = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 40)),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                label = "!";
              });
              ClassificationModel classificationModel =
                  await PytorchLite.loadClassificationModel(
                    "assets/models/model_classification.pt",
                    224,
                    224,
                    1000,
                    labelPath:
                        "assets/labels/label_classification_imageNet.txt",
                  );
              final String customPath =
                  '/storage/emulated/0/DCIM/QuickCheck/b.jpg';
              String imagePrediction = await classificationModel
                  .getImagePrediction(await File(customPath).readAsBytes());
              print("啊" + imagePrediction);
            },
            child: Text("pic", style: TextStyle(fontSize: 40)),
          ),
        ],
      ),
    );
  }
}
