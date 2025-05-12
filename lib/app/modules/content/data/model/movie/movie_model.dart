import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

class MovieModel extends MovieEntity implements PaginationCardInterface {
  const MovieModel(
      {required super.id,
      required super.title,
      required super.imagePath,
      required super.releaseDate});

  factory MovieModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return MovieModel(
          id: jsonItem['id'],
          title: jsonItem['title'],
          imagePath: jsonItem['poster_path'],
          releaseDate: jsonItem['release_date']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  PaginationCardContract toPaginationCardContract() {
    return PaginationCardContract(
        id: id,
        title: title,
        imagePath: imagePath,
        releaseYear: releaseDate.substring(0, 4),
        type: ContentTypeEnum.movie);
  }
}
