import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/short_entity.dart';

/// The bottom-start info block from `shorts_feed_u17/code.html`: cook avatar
/// + name + follow button, caption text, and an "order this meal" chip.
class ShortCaptionBar extends StatelessWidget {
  const ShortCaptionBar({
    super.key,
    required this.short,
    required this.onOrderMeal,
  });

  final ShortEntity short;
  final VoidCallback onOrderMeal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // "sumac-red" #A83226 is AppColors.sumac (the project's
                // canonical primary, per app_theme.dart).
                border: Border.all(color: AppColors.sumac, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: short.cookAvatarUrl.isEmpty
                  ? Container(color: Colors.white24)
                  : Image.network(short.cookAvatarUrl, fit: BoxFit.cover),
            ),
            const SizedBox(width: AppSpace.m),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      short.cookName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppSpace.xs),
                    const Icon(Icons.verified, color: Color(0xFF5A7233), size: 18),
                  ],
                ),
                const SizedBox(height: AppSpace.xs),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.sumac,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'متابعة',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpace.m),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            short.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, height: 1.5),
          ),
        ),
        const SizedBox(height: AppSpace.m),
        GestureDetector(
          onTap: onOrderMeal,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpace.m,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.image),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant, color: Colors.white, size: 16),
                const SizedBox(width: AppSpace.s),
                Text(
                  short.caption.isEmpty ? 'اطلب هذه الأكلة' : 'اطلب هذه الأكلة',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
