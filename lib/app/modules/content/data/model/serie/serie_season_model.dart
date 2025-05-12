import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/data/model/models.dart';
import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';

class SerieSeasonModel extends SerieSeasonEntity<EpisodeModel>
    implements ListContentListItemInterface {
  SerieSeasonModel({required super.episodes});

  factory SerieSeasonModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return SerieSeasonModel(
          episodes: (jsonResponse['episodes'] as List? ?? [])
              .map((item) => EpisodeModel.fromJson(item))
              .toList());
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  List<ContentListItemContract> toListContentListItemContract() {
    return episodes.map((item) => item.toContentListItemContract()).toList();
  }
}
