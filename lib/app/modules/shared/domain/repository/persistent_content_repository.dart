import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/shared/domain/entity/entities.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

abstract class PersistentContentRepository<T extends PersistentContentEntity> {
  AppResponse<bool> containBadge(String id, PopMenuOptionsTypeEnum type);
  Future<AppResponse<bool>> updateBadgesOrCreate(
      T entity, PopMenuOptionsTypeEnum newBadge);
  Future<AppResponse<bool>> removeBadgeOrDelete(
      String id, PopMenuOptionsTypeEnum type);
}
