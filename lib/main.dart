import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfox_sfx/bloc/face_animation_bloc.dart';
import 'package:starfox_sfx/core/util/character_data_provider.dart';
import 'package:starfox_sfx/core/util/game_assets.dart';
import 'package:starfox_sfx/presentations/pages/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CharacterDataProvider.loadCharacters();
  await CharacterDataProvider.loadCharacterSecrets();
  await GameAssets.init();
  //debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => 
  MultiBlocProvider(
    providers: [
      BlocProvider<FaceAnimationBloc>(create: (context) => FaceAnimationBloc()),
    ],
    child: 
    MaterialApp(
      title: 'Sta Fox 64 SFX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainMenu()
    )
  );
}
