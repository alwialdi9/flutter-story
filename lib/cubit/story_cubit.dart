import 'dart:developer';

import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  Future<void> getStories(
      {int page = 0, int size = 10, bool location = false}) async {
    List<Object> existingData = state.props;
    if(page == 0){
      emit(StoryInitial());
    }
    try {
      ApiReturnValue<List<Story>> stories =
          await StoryServices.getAllStories(page, size, location);

      bool? error = stories.error;

      if (error!) {
        emit(StoryLoadedFailed(stories.message!));
      }

      if (stories.value != null) {
        if (page > 0) {
          List<Object> updatedStories = existingData..addAll(stories.value!);
          emit(StoryLoadedSuccess(updatedStories));
        } else {
          emit(StoryLoadedSuccess(stories.value!));
        }
      } else {
        emit(StoryLoadedFailed(stories.message!));
      }
    } catch (e) {
      log("[${DateTime.now()}] Error : $e");
      emit(StoryLoadedFailed(e.toString()));
    }
  }
}
