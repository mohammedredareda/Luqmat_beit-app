import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_home_feed.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeFeed) : super(const HomeState.initial());

  final GetHomeFeed _getHomeFeed;

  Future<void> loadFeed() async {
    emit(const HomeState.loading());
    final result = await _getHomeFeed();
    // The page can be popped (e.g. an auth redirect firing) while this
    // request is still in flight — emitting on a closed cubit throws.
    if (isClosed) return;
    result.fold(
      (feed) => emit(HomeState.loaded(feed)),
      (exception) => emit(HomeState.failure(exception)),
    );
  }
}
