import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'face_animation_event.dart';
part 'face_animation_state.dart';


class FaceAnimationBloc extends Bloc<FaceAnimationEvent, FaceAnimationState> {
  FaceAnimationBloc() : super(const FaceAnimationInitial()) {
    on<FaceAnimationEvent>((event, emit) {});

    on<PlayFaceAnimationEvent>((event, emit) {
      emit(const PlayFaceAnimationState());
    });
    on<StopFaceAnimationEvent>((event, emit) {
      emit(const StopFaceAnimationState());
    });
  }
}
