import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// R-29 — a skeleton grid mirroring [ShortGalleryCard]'s 9:16 shape, never
/// a bare spinner, for the gallery's initial load.
class MyShortsGallerySkeleton extends StatelessWidget {
  const MyShortsGallerySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpace.m,
        crossAxisSpacing: AppSpace.m,
        childAspectRatio: 9 / 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const LoadingSkeleton(
        width: double.infinity,
        height: double.infinity,
        borderRadius: AppRadius.card,
      ),
    );
  }
}
