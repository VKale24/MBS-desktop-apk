import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:desktop_apk/network/team_network.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/data/model/team_model.dart';

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
      await TeamNetwork.instance.createTeam(event.team);
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
      final Teams teams = await TeamNetwork.instance.getAllTeams();
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
      TeamModel team = await TeamNetwork.instance
          .uploadImageToTeam(event.team.idTeam, event.image);
      if (event.nextEmit == "selectedTeam") {
        _onSelectTeam(SelectTeam(team: team), emit);
      } else {
        await _onGettingTeams(const GetTeams(), emit);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUpdateTeam(
    UpdateTeam event,
    Emitter<TeamState> emit,
  ) async {
    try {
      TeamModel team =
          await TeamNetwork.instance.updateTeam(event.team.idTeam, event.team);

      _onSelectTeam(SelectTeam(team: team), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  TeamState _handleError(Object e) {
    if (e is ErrorTeams) return ErrorTeams(error: e.error);
    return ErrorTeams(error: "Algo anda mal");
  }
}
