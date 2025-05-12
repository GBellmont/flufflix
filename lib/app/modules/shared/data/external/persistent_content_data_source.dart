import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/shared/data/model/models.dart';

class PersistentContentDataSource {
  static const String persistentContentListKey = "Persistent_CONTENT_KEY";

  final SharedPreferences persistentManager;

  const PersistentContentDataSource({required this.persistentManager});

  PersistentContentModel? findById(String id) {
    try {
      final contentList = _getVerifiedPersistentContentList();

      return contentList.where((item) => item.id == id).firstOrNull;
    } catch (error, stackTrace) {
      throw PersistentError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while querying the selected content');
    }
  }

  Future<bool> add(PersistentContentModel model) async {
    try {
      final contentList = _getVerifiedPersistentContentList();

      return await _saveContentList([...contentList, model]);
    } catch (error, stackTrace) {
      throw PersistentError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while trying to add new content');
    }
  }

  Future<bool> update(PersistentContentModel model) async {
    try {
      final contentList = _getVerifiedPersistentContentList();

      final newList = contentList.map((item) {
        if (item.id != model.id) return item;

        return item.copyWith(badges: model.badges);
      }).toList();

      return await _saveContentList(newList);
    } catch (error, stackTrace) {
      throw PersistentError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while trying to update content');
    }
  }

  Future<bool> delete(String id) async {
    try {
      final contentList = _getVerifiedPersistentContentList();

      final newList = contentList.where((item) => item.id != id).toList();

      return await _saveContentList(newList);
    } catch (error, stackTrace) {
      throw PersistentError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while trying to delete content');
    }
  }

  List<PersistentContentModel> _getVerifiedPersistentContentList() {
    final contentListString =
        persistentManager.getString(persistentContentListKey) ??
            jsonEncode({'contentList': []});

    final contentJson = jsonDecode(contentListString);

    return (contentJson['contentList'] as List)
        .map((item) => PersistentContentModel.fromJson(item))
        .toList();
  }

  Future<bool> _saveContentList(
      List<PersistentContentModel> contentList) async {
    return await persistentManager.setString(
        persistentContentListKey,
        jsonEncode({
          'contentList': contentList.map((item) => item.toJson()).toList()
        }));
  }
}
