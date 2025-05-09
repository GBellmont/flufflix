import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/domain/contract/content_list_item_contract.dart';

import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';

class TrailerModel extends TrailerEntity implements ContentListItemInterface {
  const TrailerModel({required super.type, required super.name});

  factory TrailerModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return TrailerModel(
          type: jsonResponse['type'], name: jsonResponse['name']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  ContentListItemContract toContentListItemContract() {
    return ContentListItemContract(
        title: type, description: name, runtime: 'no runtime');
  }
}
