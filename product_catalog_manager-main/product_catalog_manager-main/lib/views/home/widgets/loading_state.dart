// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Container(
              height: 96.0,
              width: 96.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2A4494).withOpacity(0.1),
              ),
              child: Center(
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2A4494),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Loading products...',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B2C7C),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Synchronizing architectural datasets',
              style: TextStyle(
                color: Color(0xFF444651),
                fontSize: 16.0,
                letterSpacing: 0.35,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  _buildSkeletonCard(),
                  const SizedBox(height: 16.0),
                  _buildSkeletonRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Widget _buildSkeletonRow() {
    return Row(
      children: [
        Expanded(child: _smallBox()),
        const SizedBox(width: 12.0),
        Expanded(child: _smallBox()),
      ],
    );
  }

  Widget _smallBox() {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
      ),
    );
  }
}
