import 'package:equatable/equatable.dart';
import 'package:elkood1/model/Images_model.dart';
import 'package:elkood1/model/Images_model.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class GetImagesList extends ImageEvent {}

class FavImages extends ImageEvent {}

class DownloadedImages extends ImageEvent {}

class GetSearchImages extends ImageEvent {
  final String value;

  GetSearchImages({required this.value});
}

class GetdownloadedImages extends ImageEvent {}

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object?> get props => [];
}

class ImagesInitial extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<ImagesModel> imagesModel;
  const ImagesLoaded(this.imagesModel);
}

class ImagesError extends ImagesState {
  final String? message;
  const ImagesError(this.message);
}
