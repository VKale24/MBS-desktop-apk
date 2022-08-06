import '../model/roster_model.dart';

abstract class IRosterRepository {
  Future<dynamic> addPlayerToRoster(int idPlayer, int idTeam, int idTournament);

  Future<Rosters> getActiveRosterByTeam(int idTeam);

  Future<Rosters> getHistoryRosterByTeam(int idTeam);

  Future<Rosters> getTeamsByPlayer(int idPlayer);

  Future<bool> removePlayerOfRoster(int idTeam, int idTournament, int idPlayer);
}
