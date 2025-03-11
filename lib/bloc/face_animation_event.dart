part of 'face_animation_bloc.dart';

abstract class FaceAnimationEvent extends Equatable {
  final bool playing;
  const FaceAnimationEvent(this.playing);

  @override
  List<Object> get props => [playing];
}

class StopFaceAnimationEvent extends FaceAnimationEvent {
  const StopFaceAnimationEvent() : super(false);
}

class PlayFaceAnimationEvent extends FaceAnimationEvent {
  const PlayFaceAnimationEvent() : super(true);
}
