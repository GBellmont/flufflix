import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flufflix/app/modules/content/presentation/widget/widgets.dart';

class ContentDetailsLoading extends StatelessWidget {
  const ContentDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 8),
              height: size.height * .25,
              width: double.infinity,
              color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Container(
                    height: 30, width: size.width * .8, color: Colors.grey),
                Container(
                    height: 14, width: double.infinity, color: Colors.grey),
                Container(
                    height: 14, width: double.infinity, color: Colors.grey),
                Container(
                    height: 14, width: double.infinity, color: Colors.grey),
                Container(
                    height: 14, width: size.width * 0.7, color: Colors.grey),
                Container(
                    height: 16, width: size.width * 0.6, color: Colors.grey),
                Container(
                    height: 16, width: size.width * 0.6, color: Colors.grey),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 16,
                    width: size.width * 0.6,
                    color: Colors.grey),
                Container(
                    height: 26, width: size.width * 0.25, color: Colors.grey),
                Row(
                  spacing: 10,
                  children: [
                    Container(
                        height: 24,
                        width: size.width * 0.15,
                        color: Colors.grey),
                    Container(
                        height: 24,
                        width: size.width * 0.15,
                        color: Colors.grey),
                    Container(
                        height: 24,
                        width: size.width * 0.15,
                        color: Colors.grey),
                    Container(
                        height: 24,
                        width: size.width * 0.15,
                        color: Colors.grey)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const ContentListLoading()
              ],
            ),
          )
        ],
      ),
    );
  }
}
