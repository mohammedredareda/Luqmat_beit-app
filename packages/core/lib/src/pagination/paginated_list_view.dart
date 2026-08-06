import 'package:flutter/material.dart';

import '../constants/pagination_constants.dart';

/// One shared ListView.builder + ScrollController that fires [onLoadMore]
/// once scroll position passes [PaginationConstants.prefetchThreshold].
/// Reused by every unbounded list (search, browse meals, browse chefs)
/// instead of three ad hoc implementations.
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
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.hasMore || widget.isLoadingMore) return;
    final position = _scrollController.position;
    if (position.pixels >=
        position.maxScrollExtent * PaginationConstants.prefetchThreshold) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length + (widget.hasMore ? 1 : 0);
    final builder = widget.separatorBuilder;

    Widget buildAt(BuildContext context, int index) {
      if (index >= widget.items.length) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      return widget.itemBuilder(context, widget.items[index], index);
    }

    if (builder == null) {
      return ListView.builder(
        controller: _scrollController,
        padding: widget.padding,
        itemCount: itemCount,
        itemBuilder: buildAt,
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: itemCount,
      itemBuilder: buildAt,
      separatorBuilder: builder,
    );
  }
}
