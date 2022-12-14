import 'package:bloc/bloc.dart';
import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/domain/repository/match_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../global/service_locator.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc()
      // ignore: prefer_initializing_formals
      : super(MatchInitial()) {
    on<GetMatchsByTournament>(_onGettingMatchsByTournament);
    on<GetMatchsByTournamentAndRound>(_onGettingMatchsByTournamentAndRound);
  }

  Future<void> _onGettingMatchsByTournament(
    GetMatchsByTournament event,
    Emitter<MatchState> emit,
  ) async {
    try {
      final Matchs matchs = await locator<MatchRepository>()
          .getMatchsByTournament(event.idTournament);
      if (matchs.matchs.isEmpty) emit(EmptyMatchs());

      emit(LoadedMatchsByTournament(matchs: matchs));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onGettingMatchsByTournamentAndRound(
    GetMatchsByTournamentAndRound event,
    Emitter<MatchState> emit,
  ) async {
    try {

      final List<ListTeamMatchs> listMatchs = await locator<MatchRepository>()
          .getMatchsByTournamentAndRound(event.idTournament, event.round);
      if (listMatchs.isEmpty) emit(EmptyMatchs());

      emit(LoadedMatchsByTournamentAndRound(listMatchs: listMatchs));
    } catch (e) {
      _handleError(e);
    }
  }
}

MatchState _handleError(Object e) {
  if (e is ErrorMatchs) return ErrorMatchs(error: e.error);
  return ErrorMatchs(error: "Algo anda mal");
}
