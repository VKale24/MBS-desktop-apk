import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';

abstract class TeamTournamentNetworkDataSource {
  Future<Tournament> getTournamentsByTeam(int idTeam);

  Future<ListTeamTournaments> getTeamsByTournament(int idTournament);

  Future<ListTeamTournaments> getTableByTournament(int idTournament);
}
