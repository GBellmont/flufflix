import 'dart:convert';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';
import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';

class MovieDetailsModel extends MovieDetailsEntity<CreditItemModel>
    implements ContentDetailsInterface {
  const MovieDetailsModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.posterImage,
      required super.bannerImage,
      super.releaseDate,
      required super.forAdult,
      required super.runtime,
      required super.collectionName,
      required super.average,
      required super.starringActors,
      required super.directors,
      required super.genres});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      final castList = jsonResponse['credits']?['cast'] as List? ?? [];
      castList.sort((itemA, itemB) {
        final popularityA = itemA['popularity'] as double;
        final popularityB = itemB['popularity'] as double;

        return popularityB.compareTo(popularityA);
      });

      final crewList = jsonResponse['credits']?['crew'] as List? ?? [];
      crewList.sort((itemA, itemB) {
        final popularityA = itemA['popularity'] as double;
        final popularityB = itemB['popularity'] as double;

        return popularityB.compareTo(popularityA);
      });

      final starringList = castList
          .where((item) => item['known_for_department'] == "Acting")
          .map((filteredItem) => CreditItemModel.fromJson(filteredItem))
          .toSet()
          .take(6)
          .toList();

      final directorsList = crewList
          .where((item) => item['known_for_department'] == "Directing")
          .map((filteredItem) => CreditItemModel.fromJson(filteredItem))
          .toSet()
          .take(6)
          .toList();

      return MovieDetailsModel(
          id: jsonResponse['id'],
          title: jsonResponse['title'],
          description: jsonResponse['overview'],
          posterImage: jsonResponse['poster_path'],
          bannerImage: jsonResponse['backdrop_path'],
          releaseDate: jsonResponse['release_date'],
          forAdult: jsonResponse['adult'],
          runtime: jsonResponse['runtime'].toString(),
          collectionName:
              jsonResponse['belongs_to_collection']?['name'] ?? "No collection",
          average: jsonResponse['vote_average'],
          starringActors: starringList,
          directors: directorsList,
          genres: (jsonResponse['genres'] as List? ?? [])
              .map((item) => item['name'].toString())
              .toList());
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  String get toJson => jsonEncode({
        'id': id,
        'title': title,
        'overview': description,
        'poster_path': posterImage,
        'backdrop_path': bannerImage,
        'release_date': releaseDate,
        'adult': forAdult,
        'runtime': runtime,
        'belongs_to_collection': {'name': collectionName},
        'vote_average': average,
        'credits': {
          'cast': starringActors.map((item) => item.toJson).toList(),
          'crew': directors.map((item) => item.toJson).toList()
        },
        'genres': genres.map((item) => {'name': item}).toList()
      });

  @override
  ContentDetailsContract toContentDetailsContract() {
    final releaseYear = releaseDate?.substring(0, 4) ?? 'Coming soon';
    final isAdultFilm = forAdult ? '+18' : '-18';
    final runtimeMovie = "${runtime}min";
    final imdb = "Imdb: ${average.toStringAsFixed(1)}/10";

    return ContentDetailsContract(
        id: id,
        title: title,
        description: description,
        runtime: runtime,
        posterImage: posterImage,
        bannerImage: bannerImage,
        tags:
            "$releaseYear | $isAdultFilm | $runtimeMovie | $collectionName | $imdb",
        starring: starringActors.map((item) => item.name).join(','),
        creators: directors.map((item) => item.name).join(','),
        genres: genres.join(','));
  }
}
