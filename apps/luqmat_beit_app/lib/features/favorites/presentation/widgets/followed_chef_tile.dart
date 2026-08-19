import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/chef_list_tile.dart';

/// Wraps the shared [ChefListTile] with an "متابعة"/unfollow toggle button,
/// as shown on the followed-chefs tab of the mockup.
class FollowedChefTile extends StatelessWidget {
  const FollowedChefTile({
    super.key,
    required this.chef,
    required this.onTap,
    required this.onUnfollow,
  });

  final ChefSummaryEntity chef;
  final VoidCallback onTap;
  final VoidCallback onUnfollow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        ChefListTile(chef: chef, onTap: onTap),
        PositionedDirectional(
          end: AppSpace.l,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: scheme.primary.withValues(alpha: 0.1),
              foregroundColor: scheme.primary,
              shape: const StadiumBorder(),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpace.l,
                vertical: AppSpace.s,
              ),
            ),
            onPressed: onUnfollow,
            child: const Text('متابعة'),
          ),
        ),
      ],
    );
  }
}
