import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;
  static const _backGroundImage = "assets/images/starfox_background1.png";
  const BackgroundScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [_buildBackGroundImage(), child],
      ),
    );
  }

  Widget _buildBackGroundImage() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(_backGroundImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
