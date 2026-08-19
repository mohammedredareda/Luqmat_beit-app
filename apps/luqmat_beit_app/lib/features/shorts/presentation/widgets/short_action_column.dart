import 'package:flutter/material.dart';

import '../../domain/entities/short_entity.dart';

/// The left-side (in RTL, "start"-anchored per the mockup) vertical column
/// of social actions: like, comment. Matches `shorts_feed_u17/code.html`'s
/// `w-12 h-12 rounded-full bg-white/10` icon buttons with a count label
/// beneath each (the mockup's third "share" button was dropped — not part
/// of this app).
class ShortActionColumn extends StatelessWidget {
  const ShortActionColumn({
    super.key,
    required this.short,
    required this.onLike,
    required this.onComment,
  });

  final ShortEntity short;
  final VoidCallback onLike;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionButton(
          icon: Icons.favorite,
          isActive: short.isLiked,
          activeColor: const Color(0xFFA83226),
          label: _formatCount(short.likeCount),
          onTap: onLike,
        ),
        const SizedBox(height: 24),
        _ActionButton(
          icon: Icons.chat_bubble,
          label: _formatCount(short.commentCount),
          onTap: onComment,
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return '$count';
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.activeColor = Colors.white,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Icon(
              icon,
              color: isActive ? activeColor : Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 4, color: Colors.black45)],
            ),
          ),
        ],
      ),
    );
  }
}
