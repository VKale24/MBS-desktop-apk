import '../../domain/entities/tournament.dart';
import '../model/team_tournament_model.dart';

abstract class ITeamTournamentRepository {
  Future<Tournament> getTournamentsByTeam(int idTeam);

  Future<ListTeamTournaments> getTeamsByTournament(int idTournament);

  Future<ListTeamTournaments> getTableByTournament(int idTournament);
}
