import 'package:flutter/material.dart';
import 'package:starfox_sfx/core/util/character_data_provider.dart';
import 'package:starfox_sfx/core/util/character_utility.dart';
import 'package:starfox_sfx/presentations/pages/character_page.dart';
import 'package:starfox_sfx/presentations/widgets/back_ground_screen.dart';
import 'package:starfox_sfx/presentations/widgets/character_grid_item.dart';

class CharacterGridScreen extends StatefulWidget {
  const CharacterGridScreen({super.key});

  @override
  State<StatefulWidget> createState() => CharacterGridScreenState();
}

class CharacterGridScreenState extends State<CharacterGridScreen> {
  static const int rows = 6;
  static const int columns = 4;
  static const double radius = 10;
  static const String _title = "Select Character";

  @override
  Widget build(BuildContext context) {
    final characters = CharacterDataProvider.characters;
    final int itemCount = (rows * columns).clamp(0, characters.length);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.orangeAccent,
        backgroundColor: Colors.black12,
        title: Text(
          _title,
          style: TextStyle(fontFamily: 'Arwing', fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final character = characters[index];

              return LayoutBuilder(
                builder: (context, constraints) {
                  return CharacterGridItem(
                    characterMouthIcon: character.mountClosed,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    radius: radius,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CharacterPage(characterName: character.name),
                        ),
                      );
                    },
                    onDoubleTap: () {                      
                      if (checkCharacterSecret(character.name)) {
                        setState(() {
                          swapCharacters(
                            character,
                            getCharacterSecretElement(character.name),
                          );
                        });
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
