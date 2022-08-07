import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/data/repository/interface_team_match.dart';
import 'package:desktop_apk/domain/entities/match_game.dart';
import 'package:desktop_apk/network/team_match_network.dart';

class TeamMatchRepository implements ITeamMatchRepository {
  @override
  Future<List<MatchGame>> getAllMatchsByTeam(int idTeam) async {
    return await TeamMatchNetwork.instance.getAllMatchsByTeam(idTeam);
  }

  @override
  Future<ListTeamMatchs> getTeamsByMatch(int idMatch) async {
    return await TeamMatchNetwork.instance.getTeamsByMatch(idMatch);
  }
}
