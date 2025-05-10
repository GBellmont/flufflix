import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';

class MovieModel extends MovieEntity implements PaginationCardInterface {
  const MovieModel(
      {required super.id, required super.title, required super.imagePath});

  factory MovieModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return MovieModel(
          id: jsonItem['id'],
          title: jsonItem['title'],
          imagePath: jsonItem['poster_path']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  PaginationCardContract toPaginationCardContract() {
    return PaginationCardContract(id: id, title: title, imagePath: imagePath);
  }
}
