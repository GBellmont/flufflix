import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaginationLoadingList extends StatelessWidget {
  const PaginationLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 180,
            width: 120,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
