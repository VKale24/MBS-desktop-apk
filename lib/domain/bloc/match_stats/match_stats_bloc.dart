import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/network/match_stats_network.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';

part 'match_stats_event.dart';
part 'match_stats_state.dart';

class MatchStatsBloc extends Bloc<MatchStatsEvent, MatchStatsState> {
  MatchStatsBloc() : super(const MatchStatsInitial()) {
    on<GetStatsByMatch>(_onGettingStatsByMatch);
    on<InitMatchStats>(_initMatchStats);
    //on<GetStatsByMatch>(_onGettingStatsByMatch);
  }

  Future<void> _onGettingStatsByMatch(
    GetStatsByMatch event,
    Emitter<MatchStatsState> emit,
  ) async {
    try {
      dynamic listMatchStats = await MatchStatsNetwork.instance
          .getStatsByMatch(event.matchModel.idMatch);
      if (listMatchStats == 204) {
        emit(const EmptyMatchStatsByTeam());
      } else {
        emit(LoadedMatchStatsByTeam(listMatchStats: listMatchStats));
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _initMatchStats(
    InitMatchStats event,
    Emitter<MatchStatsState> emit,
  ) async {
    try {
      emit(const MatchStatsInitial());
    } catch (e) {
      _handleError(e);
    }
  }

  MatchStatsState _handleError(Object e) {
    if (e is ErrorMatchStats) return ErrorMatchStats(error: e.error);
    return const ErrorMatchStats(error: "Algo anda mal");
  }
}
