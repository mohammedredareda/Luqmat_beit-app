import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The top row of the Search & Filters screen (`code.html` "Search and
/// Filter Row"): a `tune` icon button that opens the broader filter sheet,
/// plus a pill-shaped search field with a clear button.
class SearchQueryBar extends StatefulWidget {
  const SearchQueryBar({
    super.key,
    required this.initialQuery,
    required this.onSubmitted,
    required this.onTuneTap,
  });

  final String initialQuery;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTuneTap;

  @override
  State<SearchQueryBar> createState() => _SearchQueryBarState();
}

class _SearchQueryBarState extends State<SearchQueryBar> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialQuery);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Material(
          color: scheme.surface,
          shape: CircleBorder(side: BorderSide(color: scheme.outline, width: 1.5)),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: widget.onTuneTap,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(AppSpace.m),
              child: Icon(Icons.tune, color: scheme.onSurfaceVariant),
            ),
          ),
        ),
        const SizedBox(width: AppSpace.m),
        Expanded(
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              hintText: 'ابحث عن أكلة أو شيف...',
              filled: true,
              fillColor: scheme.surface,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _controller,
                builder: (context, value, _) {
                  if (value.text.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _controller.clear();
                      widget.onSubmitted('');
                    },
                  );
                },
              ),
              contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                borderSide: BorderSide(color: scheme.outline, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                borderSide: BorderSide(color: scheme.outline, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                borderSide: BorderSide(color: scheme.primary, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
