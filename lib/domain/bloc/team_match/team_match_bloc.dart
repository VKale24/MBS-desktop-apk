import 'package:bloc/bloc.dart';
import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';
import 'package:desktop_apk/domain/entities/match_game.dart';

import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/domain/repository/team_match_repository.dart';
import 'package:desktop_apk/network/match_stats_network.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../global/service_locator.dart';

part 'team_match_event.dart';
part 'team_match_state.dart';

class TeamMatchBloc extends Bloc<TeamMatchEvent, TeamMatchState> {
  TeamMatchBloc() : super(TeamMatchInitial()) {
    on<GetMatchsOfTeam>(_onGetMatchsOfTeam);
    on<GetTeamsOfMatch>(_onGetTeamsOfMatch);
    on<GetStatsOfMatch>(_onGetStatsOfMatch);
  }

  Future<void> _onGetMatchsOfTeam(
    GetMatchsOfTeam event,
    Emitter<TeamMatchState> emit,
  ) async {
    try {
      //emit(LoadingData());
      List<MatchGame> listMatchGame = await locator<TeamMatchRepository>()
          .getAllMatchsByTeam(event.team.idTeam);
      emit(LoadedMatchsOfTeam(listMatchGame: listMatchGame));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onGetTeamsOfMatch(
    GetTeamsOfMatch event,
    Emitter<TeamMatchState> emit,
  ) async {
    try {
      ListTeamMatchs listTeamMatchs = await locator<TeamMatchRepository>()
          .getTeamsByMatch(event.match.idMatch);
      emit(LoadedTeamsOfMatch(listTeamMatchs: listTeamMatchs));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onGetStatsOfMatch(
    GetStatsOfMatch event,
    Emitter<TeamMatchState> emit,
  ) async {
    try {
      // emit(LoadingData());
      ListMatchStats listMatchStats =
          await MatchStatsNetwork.instance.getStatsByMatch(event.match.idMatch);
      emit(LoadedStatsOfMatch(listMatchStats: listMatchStats));
    } catch (e) {
      _handleError(e);
    }
  }

  TeamMatchState _handleError(Object e) {
    if (e is ErrorTeamMatch) return ErrorTeamMatch(error: e.error);
    return ErrorTeamMatch(error: "Algo anda mal");
  }
}
