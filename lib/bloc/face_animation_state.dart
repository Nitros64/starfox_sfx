part of 'face_animation_bloc.dart';

abstract class FaceAnimationState extends Equatable {
  final bool playing;
  const FaceAnimationState(this.playing);

  @override
  List<Object> get props => [playing];
}

class FaceAnimationInitial extends FaceAnimationState {
  const FaceAnimationInitial() : super(false);
}

class StopFaceAnimationState extends FaceAnimationState {
  const StopFaceAnimationState() : super(false);
}

class PlayFaceAnimationState extends FaceAnimationState {
  const PlayFaceAnimationState() : super(true);
}