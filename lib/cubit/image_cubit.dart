import 'dart:developer';

import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  String? imagePath;
  XFile? imageFile;

  void setImageFile(XFile? value) {
    imageFile = value;
    emit(ImageLoadedSuccess());
  }

  void setImagePath(String? value) {
    imagePath = value;
    emit(ImageInitial());
  }

  void resetImage() {
    imagePath = null;
    imageFile = null;
  }

  Future<void> uploadImage(
      List<int> bytes, String fileName, String description, Map<String, double> location) async {
    emit(ImageUploadInitial());
    try {
      ApiReturnValue result =
          await StoryServices.postImage(bytes, fileName, description, location);

      bool? error = result.error;

      if (error!) {
        emit(ImageUploadFailed(result.message!));
      } else {
        if (result.message != null) {
          emit(ImageUploadSuccess());
        } else {
          emit(ImageUploadFailed(result.message!));
        }
      }
    } catch (e) {
      log("[${DateTime.now()}] Error : $e");
      emit(ImageUploadFailed(e.toString()));
    }
  }
}
