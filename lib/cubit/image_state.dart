part of 'image_cubit.dart';

sealed class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

class ImageLoadedSuccess extends ImageState {}

class ImageUploadInitial extends ImageState {}

class ImageUploadSuccess extends ImageState {}

class ImageUploadFailed extends ImageState {
  final String message;

  const ImageUploadFailed(this.message);

  @override
  List<Object> get props => [message];
}
