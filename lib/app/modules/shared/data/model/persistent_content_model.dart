import 'package:flufflix/app/modules/content/domain/contract/stored_content_card_contract.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/domain/entity/entities.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PersistentContentModel extends PersistentContentEntity
    implements StoredContentCardInterface {
  const PersistentContentModel(
      {required super.id,
      required super.title,
      required super.posterImage,
      required super.releaseYear,
      required super.badges,
      required super.type});

  PersistentContentModel copyWith(
      {required List<PopMenuOptionsTypeEnum> badges}) {
    return PersistentContentModel(
        id: id,
        title: title,
        posterImage: posterImage,
        releaseYear: releaseYear,
        type: type,
        badges: badges);
  }

  factory PersistentContentModel.fromJson(Map<String, dynamic> jsonResponse) {
    return PersistentContentModel(
        id: jsonResponse['id'],
        title: jsonResponse['title'],
        posterImage: jsonResponse['posterImage'],
        releaseYear: jsonResponse['releaseYear'],
        type: ContentTypeEnum.fromString[jsonResponse['type']]!,
        badges: (jsonResponse['badges'] as List)
            .map((string) => PopMenuOptionsTypeEnum.fromString[string])
            .whereType<PopMenuOptionsTypeEnum>()
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterImage': posterImage,
        'releaseYear': releaseYear,
        'type': type.name,
        'badges': badges.map((item) => item.name).toList()
      };

  @override
  StoredContentCardContract toStoredContentCardContract() {
    return StoredContentCardContract(
        id: id,
        title: title,
        imagePath: posterImage,
        type: type,
        badges: badges,
        releaseYear: releaseYear);
  }
}
