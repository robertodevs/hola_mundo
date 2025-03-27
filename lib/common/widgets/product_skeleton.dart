import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 skeleton items while loading
        itemBuilder: (context, index) {
          return _buildProductCardSkeleton();
        },
      ),
    );
  }

  Widget _buildProductCardSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: 100,
              height: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            // Title and star placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 12,
                  color: Colors.white,
                ),
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Description placeholder
            Container(
              width: 90,
              height: 10,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            // Button placeholder
            Container(
              width: 60,
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
