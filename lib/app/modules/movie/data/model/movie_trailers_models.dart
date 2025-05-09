import 'dart:convert';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';
import 'package:flufflix/app/modules/movie/domain/contract/content_list_item_contract.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';

class MovieTrailersModel extends MovieTrailersEntity<TrailerModel>
    implements ListContentListItemInterface {
  const MovieTrailersModel({required super.trailers});

  factory MovieTrailersModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return MovieTrailersModel(
          trailers: (jsonResponse['results'] as List? ?? [])
              .map((item) => TrailerModel.fromJson(item))
              .toList());
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  String get toJson =>
      jsonEncode({'results': trailers.map((item) => item.toJson).toList()});

  @override
  List<ContentListItemContract> toListContentListItemContract() {
    return trailers.map((item) => item.toContentListItemContract()).toList();
  }
}
