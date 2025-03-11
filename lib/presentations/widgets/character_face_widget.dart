import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfox_sfx/bloc/face_animation_bloc.dart';
import 'package:starfox_sfx/core/util/game_assets.dart';
import 'package:starfox_sfx/features/domain/entities/character.dart';
import 'package:starfox_sfx/features/domain/mapper/mouth_mapper.dart';
import 'face_animation_painter.dart';

class CharacterFaceWidget extends StatefulWidget {
  final Character charData;
  const CharacterFaceWidget({super.key, required this.charData});

  @override
  State<CharacterFaceWidget> createState() => CharacterFaceWidgetState();
}

class CharacterFaceWidgetState extends State<CharacterFaceWidget>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> isMouthOpen = ValueNotifier(false);
  static const Rect _renderFaceSize = Rect.fromLTWH(0, 0, 300, 300);

  late final Ticker _ticker;
  final Duration _tickDuration = Duration(milliseconds: 50);
  late Duration _lastTick;

  @override
  void initState() {
    super.initState();
    _lastTick = Duration.zero;
    _ticker = createTicker((elapsed) {
      if (elapsed - _lastTick >= _tickDuration) {
        _lastTick = elapsed;
        if (context.read<FaceAnimationBloc>().state.playing) {
          isMouthOpen.value = !isMouthOpen.value;
        }
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GameAssets.spriteSheet == null
        ? const CircularProgressIndicator()
        : BlocListener<FaceAnimationBloc, FaceAnimationState>(
          listener: (context, state) {
            if (state is PlayFaceAnimationState) {
              _ticker.start();
            } else if (state is StopFaceAnimationState) {
              _ticker.stop();
              _lastTick = Duration.zero;
              isMouthOpen.value = false;
            }
          },
          child: createRepaint(),
        );
  }

  RepaintBoundary createRepaint() => RepaintBoundary(
    child: Container(
      color: Color.fromARGB(20, 0, 0, 0),
      child: FittedBox(
        child: SizedBox(
          width: 300,
          height: 300,
          child: ValueListenableBuilder<bool>(
            valueListenable: isMouthOpen,
            builder: (context, value, child) {
              return CustomPaint(painter: _faceAnimationPainterWidget());
            },
          ),
        ),
      ),
    ),
  );

  FaceAnimationPainter _faceAnimationPainterWidget() => FaceAnimationPainter(
    //spritesheet: null,
    renderFace: _calculateRenderFacePosition(),
    renderFaceSize: _renderFaceSize,
  );

  Rect _calculateRenderFacePosition() =>
      isMouthOpen.value
          ? MouthMapper.toRect(widget.charData.mountOpen)
          : MouthMapper.toRect(widget.charData.mountClosed);
}
