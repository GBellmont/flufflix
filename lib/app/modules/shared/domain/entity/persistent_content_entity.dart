import 'package:equatable/equatable.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PersistentContentEntity extends Equatable {
  final String id;
  final String title;
  final String posterImage;
  final String releaseYear;
  final List<PopMenuOptionsTypeEnum> badges;
  final ContentTypeEnum type;

  const PersistentContentEntity(
      {required this.id,
      required this.title,
      required this.posterImage,
      required this.releaseYear,
      required this.badges,
      required this.type});

  @override
  List<Object?> get props => [id, title, posterImage, type];
}
