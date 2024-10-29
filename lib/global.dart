import 'package:camera/camera.dart';

// This class work as a center to store all global value that can be used across all file in this project
class GlobalValue {
  static final global = GlobalValue();

  List<CameraDescription>? cameraList;
  CameraDescription? cameras;

  void setListCamera(List<CameraDescription> value) {
    global.cameraList = value;
  }

  List<CameraDescription> getListCamera() {
    return global.cameraList!;
  }

  void setCameras(CameraDescription value) {
    global.cameras = value;
  }

  CameraDescription? getCameras() {
    return global.cameras;
  }
}
