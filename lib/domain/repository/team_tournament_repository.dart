import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:desktop_apk/data/repository/interface_team_tournament_repository.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:desktop_apk/network/team_tournament_network.dart';

class TeamTournamentRepository implements ITeamTournamentRepository {
  @override
  Future<ListTeamTournaments> getTableByTournament(int idTournament) async {
    return await TeamTournamentNetwork.instance
        .getTableByTournament(idTournament);
  }

  @override
  Future<ListTeamTournaments> getTeamsByTournament(int idTournament) async {
    return await TeamTournamentNetwork.instance
        .getTeamsByTournament(idTournament);
  }

  @override
  Future<Tournament> getTournamentsByTeam(int idTeam) async {
   return await TeamTournamentNetwork.instance
        .getTournamentsByTeam(idTeam);
  }
}
