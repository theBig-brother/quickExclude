import 'package:pytorch_lite/pytorch_lite.dart';

void shibie() async {
  ClassificationModel classificationModel =
      await PytorchLite.loadClassificationModel(
        "assets/models/model_classification.pt",
        224,
        224,
        1000,
        labelPath: "assets/labels/label_classification_imageNet.txt",
      );
}
