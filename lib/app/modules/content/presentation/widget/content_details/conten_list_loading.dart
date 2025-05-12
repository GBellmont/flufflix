import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentListLoading extends StatelessWidget {
  const ContentListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                _ContentSkeleton(),
                _ContentSkeleton(),
                _ContentSkeleton(),
                _ContentSkeleton(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ContentSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 16),
                  height: 80,
                  width: 120,
                  color: Colors.grey),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 14,
                            width: size.width * 0.2,
                            color: Colors.grey),
                        Container(
                            height: 14,
                            width: size.width * 0.1,
                            color: Colors.grey)
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 22),
                        height: 14,
                        width: size.width * 0.3,
                        color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(
                        height: 12,
                        width: size.width * 0.9,
                        color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
