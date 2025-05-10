import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';

class CreditItemModel extends CreditItemEntity {
  const CreditItemModel(
      {required super.name,
      required super.knowForDepartment,
      required super.popularity});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CreditItemModel && name == other.name;

  @override
  int get hashCode => name.hashCode;

  factory CreditItemModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      return CreditItemModel(
          name: jsonResponse['name'],
          knowForDepartment: jsonResponse['known_for_department'],
          popularity: jsonResponse['popularity']);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }
}
