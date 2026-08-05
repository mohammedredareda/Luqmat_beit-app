import 'package:flutter/material.dart';

import '../constants/pagination_constants.dart';
import '../theme/sumac_theme.dart';
import '../widgets/loading_skeleton.dart';

/// Shared infinite-scroll list — fires [onLoadMore] once the user scrolls
/// past [PaginationConstants.prefetchThreshold] of the scrollable extent,
/// and renders a shimmer footer (R-29: skeleton, not spinner) while the
/// next page loads. Every unbounded list in either app renders through
/// this one widget rather than reimplementing the scroll-threshold logic.
class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.padding,
    this.separatorBuilder,
    this.endOfListBuilder,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Shown once as a trailing row when [hasMore] is false — regardless of
  /// whether [items] is empty, so it also works for a persistent trailing
  /// affordance (e.g. offers' "Add new" tile) as well as a decorative
  /// "no more items" caption. Omit for lists that shouldn't show one.
  final WidgetBuilder? endOfListBuilder;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!widget.hasMore || widget.isLoadingMore) return;
    if (!_controller.position.hasContentDimensions) return;
    final maxExtent = _controller.position.maxScrollExtent;
    if (maxExtent <= 0) return;
    final scrolled = _controller.position.pixels / maxExtent;
    if (scrolled >= PaginationConstants.prefetchThreshold) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showEndMarker = !widget.hasMore && widget.endOfListBuilder != null;
    final itemCount =
        widget.items.length + (widget.hasMore ? 1 : 0) + (showEndMarker ? 1 : 0);

    Widget footerOrItem(BuildContext context, int index) {
      if (index < widget.items.length) {
        return widget.itemBuilder(context, widget.items[index], index);
      }
      if (widget.hasMore) {
        return const _LoadMoreFooter();
      }
      return widget.endOfListBuilder!(context);
    }

    final separatorBuilder = widget.separatorBuilder;
    if (separatorBuilder != null) {
      return ListView.separated(
        controller: _controller,
        padding: widget.padding,
        itemCount: itemCount,
        separatorBuilder: separatorBuilder,
        itemBuilder: footerOrItem,
      );
    }

    return ListView.builder(
      controller: _controller,
      padding: widget.padding,
      itemCount: itemCount,
      itemBuilder: footerOrItem,
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpace.l),
      child: Center(
        child: ShimmerBox(width: 120, height: 16, borderRadius: 8),
      ),
    );
  }
}
