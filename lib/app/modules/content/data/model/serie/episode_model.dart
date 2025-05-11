import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/domain/contract/content_list_item_contract.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';

class EpisodeModel extends EpisodeEntity implements ContentListItemInterface {
  EpisodeModel(
      {required super.name,
      required super.description,
      required super.runtime,
      super.image});

  factory EpisodeModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return EpisodeModel(
          name: jsonResponse['name'],
          description: jsonResponse['overview'],
          runtime: jsonResponse['runtime'].toString(),
          image: jsonResponse['still_path']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  ContentListItemContract toContentListItemContract() {
    return ContentListItemContract(
        title: name,
        description: description,
        runtime: "${runtime}min",
        image: image);
  }
}
