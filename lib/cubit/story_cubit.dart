import 'dart:developer';

import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());
  int? page = 1;
  int size = 10;
  List<Story> stories = [];

  Future<void> getStories() async {
    // emit(StoryInitial());
    try {
      if (page != null) {
        ApiReturnValue<List<Story>> result =
            await StoryServices.getAllStories(page, size, true);

        bool? error = result.error;

        if (error!) {
          emit(StoryLoadedFailed(result.message!));
        } else {
          if (result.value != null) {
            stories.addAll(result.value!);
            if (result.value!.length < size) {
              page = null;
            } else {
              page = page! + 1;
            }
            emit(StoryLoadedSuccess(List.from(stories)));
          } else {
            emit(StoryLoadedFailed(result.message!));
          }
        }
      }
    } catch (e) {
      log("[${DateTime.now()}] Error : $e");
      emit(StoryLoadedFailed(e.toString()));
    }
  }

  void resetStories() {
    emit(StoryInitial());
    stories = [];
    page = 0;
  }
}
