import 'package:flufflix/app/core/config/configs.dart';
import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/presentation/page/pages.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoredContentCard extends StatelessWidget {
  final StoredContentCardContract item;
  final void Function() updateList;

  const StoredContentCard(
      {super.key, required this.item, required this.updateList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        context.push(ContentDetailsPage.buildRoute(item.id.toString()), extra: {
          'title': item.title,
          'posterImage': item.imagePath,
          'releaseYear': item.releaseYear,
          'type': item.type.name
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.network(
                '${AppConfig.instance.baseImagesUrl}/w300${item.imagePath}',
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  height: size.height * .25,
                ),
                fit: BoxFit.cover,
                height: 150,
                width: size.width * 0.25,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: size.width * .5,
                        child: Text(item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            )),
                      ),
                      PopMenuButton(
                          id: item.id,
                          title: item.title,
                          posterImage: item.imagePath,
                          releaseYear: item.releaseYear,
                          type: item.type,
                          onActionCompleted: updateList,
                          options: const [
                            PopMenuOptionsTypeEnum.download,
                            PopMenuOptionsTypeEnum.favorite
                          ])
                    ],
                  ),
                  SizedBox(
                    width: size.width * .18,
                    child: Text(item.releaseYear,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                  ),
                  if (item.badges.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 45, right: 30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8FDE8),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF86C38F)),
                          ),
                          child: Text(
                            item.badges.map((item) => item.tagText).join(' / '),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF86C38F),
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
