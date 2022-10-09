import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:elkood1/bloc/bloc.dart';
import 'package:elkood1/model/Images_model.dart';

import '../../services/api_reposiery.dart';

class ImagesBloc extends Bloc<ImageEvent, ImagesState> {
  ImagesBloc() : super(ImagesInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetImagesList>((event, emit) async {
      try {
        emit(ImagesLoading());
        List<ImagesModel> mList = await _apiRepository.fetchImagesList();
        emit(ImagesLoaded(mList));
      } on NetworkError {
        emit(ImagesError("Failed to fetch data. is your device online?"));
      }
    });
    on<GetSearchImages>((event, emit) async {
      try {
        emit(ImagesLoading());
        List<ImagesModel> mList =
            await _apiRepository.SearchImages(event.value);
        emit(ImagesLoaded(mList));
      } on NetworkError {
        emit(ImagesError("Failed to fetch data. is your device online?"));
      }
    });
    on<FavImages>((event, emit) async {
      try {
        emit(ImagesLoading());
        List<ImagesModel> mList = await _apiRepository.FavImages();
        emit(ImagesLoaded(mList));
      } on NetworkError {
        emit(ImagesError("Failed to fetch data. is your device online?"));
      }
    });
    on<DownloadedImages>((event, emit) async {
      try {
        emit(ImagesLoading());
        List<ImagesModel> mList = await _apiRepository.DownloadedImages();
        emit(ImagesLoaded(mList));
      } on NetworkError {
        emit(ImagesError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
