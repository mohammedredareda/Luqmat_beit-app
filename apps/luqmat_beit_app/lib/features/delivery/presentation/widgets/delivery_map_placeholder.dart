import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Grayscale map preview behind the acceptance dialog (mockup:
/// `.grayscale.contrast-50` map image).
class DeliveryMapPlaceholder extends StatelessWidget {
  const DeliveryMapPlaceholder({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        height: 192,
        width: double.infinity,
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0.2126, 0.7152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
