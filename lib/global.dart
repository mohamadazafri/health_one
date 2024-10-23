import 'package:camera/camera.dart';

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

  // void setCameraLensDirection(CameraDescription value) {
  //   global.cameras!.lensDirection = CameraLensDirection.front;
  // }
}
