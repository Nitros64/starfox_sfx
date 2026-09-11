import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Model3DRotating extends StatefulWidget {
  const Model3DRotating({super.key});

  @override
  Model3DRotatingState createState() => Model3DRotatingState();
}

class Model3DRotatingState extends State<Model3DRotating> {
  static const assets3D = 'assets/3d/arwing.glb';
  late ModelViewer _modelViewer;

  @override
  void initState() {
    super.initState();
    _modelViewer = ModelViewer(
      src: assets3D,
      loading: Loading.eager,
      autoRotate: true,
      autoRotateDelay: 0,
      rotationPerSecond: '30deg',
      cameraControls: false,
      disableTap: true,
      disablePan: true,
      disableZoom: true,
      arPlacement: ArPlacement.wall,
      orientation: '0deg -10deg -90deg',
      maxFieldOfView: '28deg',
    );
  }

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height, child: _modelViewer);
}
