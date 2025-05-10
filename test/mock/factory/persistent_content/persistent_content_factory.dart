import 'dart:convert';

import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PersistentContentFactory {
  static String getEmptyContentList() => jsonEncode({'contentList': []});
  static String getPopuledContentList(List<PersistentContentModel> list) =>
      jsonEncode({'contentList': list.map((item) => item.toJson()).toList()});

  static PersistentContentModel getPersistentContentModel(
          String id, List<PopMenuOptionsTypeEnum> badges) =>
      PersistentContentModel(
          id: id,
          title: 'Teste Content',
          posterImage: 'Poster Image',
          badges: badges);
}
