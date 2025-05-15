import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoredContentLoading extends StatelessWidget {
  const StoredContentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => _StoredContentSkeletonCard(),
        childCount: 10,
      ),
    );
  }
}

class _StoredContentSkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: Container(
                width: 100,
                height: 140,
                color: Colors.grey[800],
              ),
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 12),
                        width: size.width * .5,
                        height: 20,
                        color: Colors.grey.shade800,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: size.width * .03,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: size.width * .18,
                    height: 16,
                    color: Colors.grey.shade800,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: size.width * .30,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
