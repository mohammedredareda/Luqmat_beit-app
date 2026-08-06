import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityState { online, offline }

/// Minimal connectivity signal shared by both apps — feature Blocs listen
/// to this instead of each wiring its own connectivity_plus subscription.
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityState.online);

  void setOnline() => emit(ConnectivityState.online);
  void setOffline() => emit(ConnectivityState.offline);
}
