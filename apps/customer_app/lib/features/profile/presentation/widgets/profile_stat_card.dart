import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// One of the 3 stat cards from the shared `profile_with_stats` mockup
/// shell (سُمّاق-container background, icon, label, value).
class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.textDirection,
  });

  final IconData icon;
  final String label;
  final String value;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      decoration: BoxDecoration(
        color: AppColors.sumacContainer,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.sumac),
          const SizedBox(height: AppSpace.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.inkMutedLight, fontSize: 12),
          ),
          const SizedBox(height: AppSpace.xs),
          Text(
            value,
            textDirection: textDirection,
            style: const TextStyle(
              color: AppColors.sumac,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
