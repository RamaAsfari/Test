import '../bloc/bloc.dart';
import '../model/Images_model.dart';
import 'api_service.dart';

class ApiRepository {
  final _provider = ApiProvider();

  fetchImagesList() {
    return _provider.fetchImagesList();
  }

  SearchImages(qury) {
    return _provider.SearchImages(qury);
  }

  FavImages() {
    return _provider.FavImages();
  }

  DownloadedImages() {
    return _provider.DownloaddedImages();
  }
}

class NetworkError extends Error {}
