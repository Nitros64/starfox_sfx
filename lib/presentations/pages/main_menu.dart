import 'package:flutter/material.dart';
import 'package:starfox_sfx/presentations/pages/character_grid.dart';
import 'package:starfox_sfx/presentations/widgets/back_ground_screen.dart';
import 'package:starfox_sfx/presentations/widgets/model3d_rotating.dart';
import 'package:starfox_sfx/presentations/widgets/star_fox_logo.dart';

class MainMenu extends StatelessWidget {
  static const double _fontSize = 24;
  const MainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: LayoutBuilder(
      builder: (context, constraints){
        double screenWidth = constraints.maxWidth;
        double screenHeght = constraints.maxHeight;
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
                  Model3DRotating(),
                  Positioned(
                    top: screenHeght * 0.2,
                    child: StarFoxLogo(screenWidth: screenWidth,),
                  ),
                  pressStartButton(context,screenHeght)
                ],
          ));
      }),
    ); 
  }

  Widget pressStartButton(BuildContext context,double screenHeght)  {
    return Positioned(
      top: screenHeght * 0.65, // Ajusta la posición de la portada para que quede arriba
      child: TextButton(
          onPressed: () {            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CharacterGridScreen()),
            );
          },
          child: const Text(
            "PRESS START",
            style: TextStyle(fontSize: _fontSize),
            ),
          )
    ); 
  }
}