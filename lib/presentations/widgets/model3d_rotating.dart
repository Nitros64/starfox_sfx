import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Model3DRotating extends StatefulWidget {
  const Model3DRotating({super.key});

  @override
  Model3DRotatingState createState() => Model3DRotatingState();
}

class Model3DRotatingState extends State<Model3DRotating> {
  static const assets3D = 'assets/3d/arwing.glb';
  double xAngle = -10.0;
  double yAngle = -90.0;
  double zAngle = 0;

  double xVar = -0.135555555555;
  double zVar = 1;

  Timer? _rotationTimer;
  late ModelViewer _modelViewer;

  @override
  void initState() {
    super.initState();
    _modelViewer = ModelViewer(
      src: assets3D,
      autoRotate: false, // 🔥 Desactivar auto-rotación estándar
      cameraControls: false,
      disableTap: true,
      disablePan: true,
      disableZoom: true,
      arPlacement: ArPlacement.wall,
      orientation: "0deg -10deg -90.0deg", // z, x, y
      maxFieldOfView: "28deg",
      onWebViewCreated: (controller) {
        _startRotation(controller); // Iniciar la rotación en los 3 ejes
      },
    );
  }

  void _startRotation(WebViewController controller) {
    _rotationTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        zAngle -= zVar; // 🔄 Rota en Z
        xAngle += xVar; // 🔄 Rota en X
        //yAngle += yVar; // 🔄 Rota en Y

        if (zAngle <= -360) zAngle = 0;
        if (xAngle <= -34 || xAngle >= -10) xVar *= -1;

        controller.runJavaScript(
          "document.querySelector('model-viewer').setAttribute('orientation', '${zAngle}deg ${xAngle}deg ${yAngle}deg');",
        );
      });
    });
  }

  @override
  void dispose() {
    _rotationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height, child: _modelViewer);
}
