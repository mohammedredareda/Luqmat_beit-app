import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/add_short_comment.dart';
import '../../domain/usecases/get_short_comments.dart';
import '../cubit/short_comments_cubit.dart';
import '../cubit/short_comments_state.dart';

/// Opened from the short's comment action — CU-27's comment flow, backed by
/// `GET`/`POST /user/customer/content/:id/comments`.
Future<void> showShortCommentsSheet(
  BuildContext context, {
  required String shortId,
  required VoidCallback onCommentPosted,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) => ShortCommentsCubit(
        shortId,
        GetShortComments(getIt()),
        AddShortComment(getIt()),
      )..load(),
      child: _ShortCommentsSheet(onCommentPosted: onCommentPosted),
    ),
  );
}

class _ShortCommentsSheet extends StatefulWidget {
  const _ShortCommentsSheet({required this.onCommentPosted});

  final VoidCallback onCommentPosted;

  @override
  State<_ShortCommentsSheet> createState() => _ShortCommentsSheetState();
}

class _ShortCommentsSheetState extends State<_ShortCommentsSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    final cubit = context.read<ShortCommentsCubit>();
    _controller.clear();
    final posted = await cubit.addComment(text);
    if (posted) widget.onCommentPosted();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.sheet)),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(top: AppSpace.s),
                child: SizedBox(
                  width: 40,
                  height: 4,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpace.m),
                child: Text('التعليقات',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Expanded(
                child: BlocBuilder<ShortCommentsCubit, ShortCommentsState>(
                  builder: (context, state) {
                    return switch (state) {
                      ShortCommentsInitial() ||
                      ShortCommentsLoading() =>
                        const Center(child: CircularProgressIndicator()),
                      ShortCommentsFailure(:final exception) => Center(
                          child: Text(exception.message),
                        ),
                      ShortCommentsLoaded(:final comments) => comments.isEmpty
                          ? const Center(child: Text('لا توجد تعليقات بعد.'))
                          : NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.pixels >=
                                    notification.metrics.maxScrollExtent -
                                        200) {
                                  context.read<ShortCommentsCubit>().loadMore();
                                }
                                return false;
                              },
                              child: ListView.builder(
                                controller: scrollController,
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: AppSpace.m,
                                ),
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                      vertical: AppSpace.s,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundImage: comment
                                                      .customerAvatarUrl !=
                                                  null
                                              ? NetworkImage(
                                                  comment.customerAvatarUrl!)
                                              : null,
                                          child:
                                              comment.customerAvatarUrl == null
                                                  ? const Icon(Icons.person,
                                                      size: 16)
                                                  : null,
                                        ),
                                        const SizedBox(width: AppSpace.s),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                comment.customerName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(comment.text),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    };
                  },
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsetsDirectional.all(AppSpace.m).add(
                    EdgeInsetsDirectional.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration:
                              const InputDecoration(hintText: 'أضف تعليقاً...'),
                          onSubmitted: (_) => _submit(context),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => _submit(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
