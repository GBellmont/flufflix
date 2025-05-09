import 'package:flufflix/pages/index.dart';
import 'package:flutter/material.dart';

import 'package:flufflix/components/pagination/contract/index.dart';
import 'package:flufflix/core/constants/index.dart';
import 'package:go_router/go_router.dart';

class PaginationCard<E extends PaginationCardContract> extends StatelessWidget {
  final E item;

  const PaginationCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final path = '${EnvConstants.instance.baseImagesUrl}/w300${item.imagePath}';

    return InkWell(
      onTap: () {
        context.push(ContentDetailsPage.buildRoute(item.id.toString()),
            extra: {'title': item.title, 'posterImage': item.imagePath});
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
