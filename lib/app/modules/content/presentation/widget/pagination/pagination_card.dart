import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flufflix/app/core/config/configs.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/presentation/page/pages.dart';

class PaginationCard extends StatelessWidget {
  final PaginationCardContract item;

  const PaginationCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final path = '${AppConfig.instance.baseImagesUrl}/w300${item.imagePath}';

    return InkWell(
      onTap: () {
        context.push(ContentDetailsPage.buildRoute(item.id.toString()), extra: {
          'title': item.title,
          'posterImage': item.imagePath,
          'releaseYear': item.releaseYear,
          'type': item.type.name
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          path,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey,
          ),
          fit: BoxFit.cover,
          height: 180,
          width: 120,
        ),
      ),
    );
  }
}
