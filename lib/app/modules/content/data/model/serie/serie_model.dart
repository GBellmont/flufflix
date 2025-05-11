import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/domain/contract/pagination_card_contract.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

class SerieModel extends SerieEntity implements PaginationCardInterface {
  SerieModel(
      {required super.id, required super.name, required super.imagePath});

  factory SerieModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return SerieModel(
          id: jsonResponse['id'],
          name: jsonResponse['name'],
          imagePath: jsonResponse['poster_path']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  PaginationCardContract toPaginationCardContract() {
    return PaginationCardContract(
        id: id, title: name, imagePath: imagePath, type: ContentTypeEnum.serie);
  }
}
