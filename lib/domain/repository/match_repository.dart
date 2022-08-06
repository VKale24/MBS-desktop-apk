import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/repository/interface_match_repository.dart';
import 'package:desktop_apk/network/match_network.dart';

class MatchRepository implements IMatchRepository {
  @override
  Future<bool> createMatch(
      MatchModel match, int idTeam1, int idTeam2, int idTournament) async {
    return await MatchNetwork.instance
        .createMatch(match, idTeam1, idTeam2, idTournament);
  }

  @override
  Future<bool> deleteMatch(int idMatch) async {
    return await MatchNetwork.instance.deleteMatch(idMatch);
  }

  @override
  Future<Matchs> getAllMatchs() async {
    return await MatchNetwork.instance.getAllMatchs();
  }

  @override
  Future<Matchs> getAllMatchsByTeam(int idTeam) async {
    return await MatchNetwork.instance.getAllMatchsByTeam(idTeam);
  }

  @override
  Future<MatchModel> getMatchById(int idMatch) async {
    return await MatchNetwork.instance.getMatchById(idMatch);
  }

  @override
  Future<Matchs> getMatchsByTournament(int idTournament) async {
    return await MatchNetwork.instance.getMatchsByTournament(idTournament);
  }

  @override
  Future<List<ListTeamMatchs>> getMatchsByTournamentAndRound(
      int idTournament, int round) async {

    return await MatchNetwork.instance
        .getMatchsByTournamentAndRound(idTournament, round);
  }

  @override
  Future<bool> updateMatch(int idMatch, MatchModel match) async {
    return await MatchNetwork.instance.updateMatch(idMatch, match);
  }
}
