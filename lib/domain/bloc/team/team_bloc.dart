import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/data/model/team_model.dart';

import '../../../global/service_locator.dart';
import '../../repository/team_repository.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc() : super(TeamInitial()) {
    on<AddTeam>(_onAddTeam);
    on<GetTeams>(_onGettingTeams);
    on<SelectTeam>(_onSelectTeam);
    on<UpdateTeam>(_onUpdateTeam);
    on<UploadImageOfTeam>(_onUploadImageOfTeam);
  }

  Future<void> _onAddTeam(
    AddTeam event,
    Emitter<TeamState> emit,
  ) async {
    try {
      emit(LoadingTeams());
      await locator<TeamRepository>().createTeam(event.team);
      await _onGettingTeams(const GetTeams(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onGettingTeams(
    GetTeams event,
    Emitter<TeamState> emit,
  ) async {
    try {
      final Teams teams = await locator<TeamRepository>().getAllTeams();

      if (teams.teams.isEmpty) emit(EmmptyTeams());
      emit(LoadedTeams(teams: teams));
    } catch (e) {
      _handleError(e);
    }
  }

  void _onSelectTeam(
    SelectTeam event,
    Emitter<TeamState> emit,
  ) {
    try {
      emit(SelectedTeam(team: event.team));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUploadImageOfTeam(
    UploadImageOfTeam event,
    Emitter<TeamState> emit,
  ) async {
    try {
      await await locator<TeamRepository>()
          .uploadImageToTeam(event.team.idTeam, event.image);

      await _onGettingTeams(const GetTeams(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUpdateTeam(
    UpdateTeam event,
    Emitter<TeamState> emit,
  ) async {
    try {
      await locator<TeamRepository>().updateTeam(event.team.idTeam, event.team);

      //_onSelectTeam(SelectTeam(team: team), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  TeamState _handleError(Object e) {
    if (e is ErrorTeams) return ErrorTeams(error: e.error);
    return ErrorTeams(error: "Algo anda mal");
  }
}
