import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';

abstract class MatchNetworkDataSource {
  Future<Matchs> getAllMatchs();

  Future<Matchs> getAllMatchsByTeam(int idTeam);

  Future<Matchs> getMatchsByTournament(int idTournament);

  Future<List<ListTeamMatchs>> getMatchsByTournamentAndRound(int idTournament, int round);

  Future<MatchModel> getMatchById(int idMatch);

  Future<bool> createMatch(
      MatchModel match, int idTeam1, int idTeam2, int idTournament);

  Future<bool> updateMatch(int idMatch, MatchModel match);

  Future<bool> deleteMatch(int idMatch);
}
