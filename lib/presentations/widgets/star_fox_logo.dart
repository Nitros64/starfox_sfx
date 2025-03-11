import 'package:flutter/material.dart';

class StarFoxLogo extends StatelessWidget {
  final double screenWidth;
  static const String logoPath = "assets/images/starfox_logo.png";
  const StarFoxLogo({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      width: screenWidth,
      child: ClipRRect(
        child: Image.asset(
          logoPath, // Ruta de la imagen en assets
          fit: BoxFit.fill, // Ajuste para cubrir el contenedor
        ),
      ),
    );
  }
}
