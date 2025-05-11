import 'package:flufflix/app/modules/shared/domain/entity/entities.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PersistentContentModel extends PersistentContentEntity {
  const PersistentContentModel(
      {required super.id,
      required super.title,
      required super.posterImage,
      required super.badges});

  PersistentContentModel copyWith(
      {required List<PopMenuOptionsTypeEnum> badges}) {
    return PersistentContentModel(
        id: id, title: title, posterImage: posterImage, badges: badges);
  }

  factory PersistentContentModel.fromJson(Map<String, dynamic> jsonResponse) {
    return PersistentContentModel(
        id: jsonResponse['id'],
        title: jsonResponse['title'],
        posterImage: jsonResponse['posterImage'],
        badges: (jsonResponse['badges'] as List)
            .map((string) => PopMenuOptionsTypeEnum.fromString[string])
            .whereType<PopMenuOptionsTypeEnum>()
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterImage': posterImage,
        'badges': badges.map((item) => item.name).toList()
      };
}
