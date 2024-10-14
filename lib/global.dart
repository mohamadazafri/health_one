import 'package:camera/camera.dart';

class GlobalValue {
  static final global = GlobalValue();

  CameraDescription? cameras;

  void setCameras(CameraDescription value) {
    global.cameras = value;
  }

  CameraDescription? getCameras() {
    return global.cameras;
  }
}
