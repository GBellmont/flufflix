import 'package:flufflix/app/core/error/app_error.dart';

import 'package:flufflix/app/modules/content/data/model/models.dart';
import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

class SerieDetailsModel extends SerieDetailsEntity
    implements ContentDetailsInterface {
  SerieDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.posterImage,
    required super.bannerImage,
    required super.forAdult,
    super.greatherRuntime,
    required super.average,
    required super.starringActors,
    required super.creators,
    required super.genres,
    required super.seasonsNumber,
    super.firstAirDate,
  });

  factory SerieDetailsModel.fromJson(Map<String, dynamic> jsonResponse) {
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

      final creatorsList = crewList
          .where((item) =>
              item['known_for_department'] == "Directing" ||
              item['known_for_department'] == "Creator")
          .map((filteredItem) => CreditItemModel.fromJson(filteredItem))
          .toSet()
          .take(6)
          .toList();

      return SerieDetailsModel(
          id: jsonResponse['id'],
          title: jsonResponse['name'],
          description: jsonResponse['overview'],
          posterImage: jsonResponse['poster_path'],
          bannerImage: jsonResponse['backdrop_path'],
          firstAirDate: jsonResponse['first_air_date'],
          forAdult: jsonResponse['adult'],
          greatherRuntime: (jsonResponse['episode_run_time'] as List? ?? [])
              .firstOrNull
              ?.toString(),
          average: jsonResponse['vote_average'],
          starringActors: starringList,
          creators: creatorsList,
          genres: (jsonResponse['genres'] as List? ?? [])
              .map((item) => item['name'].toString())
              .toList(),
          seasonsNumber: (jsonResponse['seasons'] as List? ?? [])
              .where((item) => item['season_number'] != 0)
              .toList()
              .length);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  ContentDetailsContract toContentDetailsContract() {
    final releaseYear = firstAirDate?.substring(0, 4) ?? 'Coming soon';
    final isAdultFilm = forAdult ? '+18' : '-18';
    final runtimeMovie =
        greatherRuntime != null ? "${greatherRuntime}min" : "no runtime";
    final imdb = "Imdb: ${average.toStringAsFixed(1)}/10";

    final seasonOptions = List.generate(
        seasonsNumber,
        (index) => ContentListOptionContract(
            id: id.toString(),
            title: 'Season ${index + 1}',
            seasonNumber: (index + 1).toString(),
            typeToFetch: ContentListFetchTypeEnum.serieSeason));

    return ContentDetailsContract(
        id: id,
        title: title,
        description: description,
        runtime: greatherRuntime ?? "0",
        posterImage: posterImage,
        bannerImage: bannerImage,
        tags:
            "$releaseYear | $isAdultFilm | $runtimeMovie | No collection | $imdb",
        starring: starringActors.map((item) => item.name).join(','),
        creators: creators.map((item) => item.name).join(','),
        genres: genres.join(','),
        contentList: [
          ContentListOptionContract(
              id: id.toString(),
              title: 'Additionals',
              typeToFetch: ContentListFetchTypeEnum.serieTrailers),
          ...seasonOptions
        ]);
  }
}
