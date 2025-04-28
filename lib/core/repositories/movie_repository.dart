import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/core/constants/index.dart';
import 'package:flufflix/core/repositories/response/index.dart';

class MovieRepository {
  static const String baseStorageKey = 'MovieRepository';

  final Dio client =
      Dio(BaseOptions(baseUrl: EnvConstants.instance.baseUrl, headers: {
    'Authorization': 'Bearer ${EnvConstants.instance.apiKey}'
  }, queryParameters: {
    'language': MoviesConstants.defaultPtBrLanguage,
  }));

  SharedPreferences? _preferences;
  FutureOr<SharedPreferences> get db async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<GetPopularMoviesResponse> getPopularMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    final storageKey = "${baseStorageKey}_getPopularMovies_$page";

    final storedJson = await _getStoredJson(storageKey);
    if (storedJson != null) {
      return GetPopularMoviesResponse.fromJson(storedJson);
    }

    final response = await client.get('/movie/popular', queryParameters: {
      'page': page,
    });

    final formatedMovies = GetPopularMoviesResponse.fromJson(response.data);
    await _setStorageJson(storageKey, formatedMovies.toJson);

    return formatedMovies;
  }

  Future<GetTopRatedMoviesResponse> getTopRatedMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    final storageKey = "${baseStorageKey}_getTopRatedMovies_$page";

    final storedJson = await _getStoredJson(storageKey);
    if (storedJson != null) {
      return GetTopRatedMoviesResponse.fromJson(storedJson);
    }

    final response = await client.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    final formatedMovies = GetTopRatedMoviesResponse.fromJson(response.data);
    await _setStorageJson(storageKey, formatedMovies.toJson);

    return formatedMovies;
  }

  Future<Map<String, dynamic>?> _getStoredJson(String key) async {
    final storage = await db;
    final objectString = storage.getString(key);

    if (objectString == null) return null;

    return jsonDecode(objectString);
  }

  Future<void> _setStorageJson(String key, String value) async {
    final storage = await db;
    await storage.setString(key, value);
  }
}
