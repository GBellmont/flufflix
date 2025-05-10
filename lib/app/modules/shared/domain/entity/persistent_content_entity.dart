import 'package:equatable/equatable.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PersistentContentEntity extends Equatable {
  final String id;
  final String title;
  final String posterImage;
  final List<PopMenuOptionsTypeEnum> badges;

  const PersistentContentEntity(
      {required this.id,
      required this.title,
      required this.posterImage,
      required this.badges});

  @override
  List<Object?> get props => [id, title, posterImage];
}
