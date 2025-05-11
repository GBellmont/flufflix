import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/app_response.dart';

import 'package:flufflix/app/modules/shared/data/external/externals.dart';
import 'package:flufflix/app/modules/shared/data/model/persistent_content_model.dart';
import 'package:flufflix/app/modules/shared/domain/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/pop_menu_options_enum.dart';

class PersistentContentRepositoryImpl
    implements PersistentContentRepository<PersistentContentModel> {
  final PersistentContentDataSource persistentDataSource;

  const PersistentContentRepositoryImpl({required this.persistentDataSource});

  @override
  AppResponse<bool> containBadge(String id, PopMenuOptionsTypeEnum type) {
    try {
      final content = persistentDataSource.findById(id);

      return AppResponse<bool>(
          success: content != null && content.badges.contains(type));
    } on AppError catch (error, _) {
      return AppResponse<bool>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<bool>> removeBadgeOrDelete(
      String id, PopMenuOptionsTypeEnum type) async {
    try {
      final content = persistentDataSource.findById(id);

      if (content == null) {
        return AppResponse<bool>(success: true);
      }

      if (content.badges.isEmpty ||
          content.badges.length == 1 && content.badges[0] == type) {
        return AppResponse<bool>(
            success: await persistentDataSource.delete(id));
      }

      final filteredBadges =
          content.badges.where((item) => item != type).toList();
      final updatedContent = content.copyWith(badges: filteredBadges);

      return AppResponse<bool>(
          success: await persistentDataSource.update(updatedContent));
    } on AppError catch (error, _) {
      return AppResponse<bool>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<bool>> updateBadgesOrCreate(
      PersistentContentModel entity, PopMenuOptionsTypeEnum newBadge) async {
    try {
      final content = persistentDataSource.findById(entity.id);

      if (content == null) {
        return AppResponse<bool>(
            success: await persistentDataSource
                .add(entity.copyWith(badges: [newBadge])));
      }

      final newBadges = content.badges.contains(newBadge)
          ? content.badges
          : [...content.badges, newBadge];

      return AppResponse<bool>(
          success: await persistentDataSource
              .update(content.copyWith(badges: newBadges)));
    } on AppError catch (error, _) {
      return AppResponse<bool>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }
}
