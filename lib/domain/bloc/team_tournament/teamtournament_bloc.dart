import 'package:bloc/bloc.dart';
import 'package:desktop_apk/domain/repository/team_tournament_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:desktop_apk/network/team_tournament_network.dart';
import 'package:desktop_apk/data/model/team_tournament_model.dart';

import '../../../global/service_locator.dart';

part 'teamtournament_event.dart';
part 'teamtournament_state.dart';

class TeamTournamentBloc
    extends Bloc<TeamTournamentEvent, TeamTournamentsState> {
  TeamTournamentBloc() : super(TeamTournamentsInitial()) {
    on<GetTableOfTournament>(_onGettingTable);
  }

  Future<void> _onGettingTable(
      GetTableOfTournament event, Emitter<TeamTournamentsState> emit) async {
    try {
      final ListTeamTournaments teamTournaments =
          await locator<TeamTournamentRepository>()
              .getTableByTournament(event.tournament.idTournament);
      if (teamTournaments.listTeamTournament.isEmpty) {
        emit(EmmptyTeamTournaments());
      }
      emit(LoadedTableOfTournament(teamTournaments: teamTournaments));
    } catch (e) {
      _handleError(e);
    }
  }

  TeamTournamentsState _handleError(Object e) {
    if (e is ErrorTeamTournaments) return ErrorTeamTournaments(error: e.error);
    return ErrorTeamTournaments(error: "Algo anda mal");
  }
}
