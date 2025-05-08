import 'dart:convert';

import 'package:flufflix/components/content/contract/index.dart';

class CreditItem {
  final String name;
  final String knowForDepartment;
  final double popularity;

  const CreditItem(
      {required this.name,
      required this.knowForDepartment,
      required this.popularity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CreditItem && name == other.name;

  @override
  int get hashCode => name.hashCode;

  factory CreditItem.fromJson(Map<String, dynamic> jsonResponse) {
    return CreditItem(
        name: jsonResponse['name'],
        knowForDepartment: jsonResponse['known_for_department'],
        popularity: jsonResponse['popularity']);
  }

  Map<String, dynamic> get toJson => {
        'name': name,
        'known_for_department': knowForDepartment,
        'popularity': popularity
      };
}

class GetMovieDetailsResponse implements ContentContractInterface {
  final int id;
  final String title;
  final String description;
  final String posterImage;
  final String bannerImage;
  final String? releaseDate;
  final bool forAdult;
  final String runtime;
  final String collectionName;
  final double average;
  final List<CreditItem> starringActors;
  final List<CreditItem> directors;
  final List<String> genres;

  const GetMovieDetailsResponse(
      {required this.id,
      required this.title,
      required this.description,
      required this.posterImage,
      required this.bannerImage,
      this.releaseDate,
      required this.forAdult,
      required this.runtime,
      required this.collectionName,
      required this.average,
      required this.starringActors,
      required this.directors,
      required this.genres});

  factory GetMovieDetailsResponse.fromJson(Map<String, dynamic> jsonResponse) {
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
        .map((filteredItem) => CreditItem.fromJson(filteredItem))
        .toSet()
        .take(6)
        .toList();

    final directorsList = crewList
        .where((item) => item['known_for_department'] == "Directing")
        .map((filteredItem) => CreditItem.fromJson(filteredItem))
        .toSet()
        .take(6)
        .toList();

    return GetMovieDetailsResponse(
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
  ContentContract toContentContract() {
    final releaseYear = releaseDate?.substring(0, 4) ?? 'Coming soon';
    final isAdultFilm = forAdult ? '+18' : '-18';
    final runtimeMovie = "${runtime}min";
    final imdb = "Imdb: ${average.toStringAsFixed(1)}/10";

    return ContentContract(
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
