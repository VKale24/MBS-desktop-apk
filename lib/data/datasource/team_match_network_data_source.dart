import 'package:desktop_apk/domain/entities/match_game.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';

abstract class TeamMatchNetworkDataSource {
  Future<List<MatchGame>> getAllMatchsByTeam(int idTeam);

  Future<ListTeamMatchs> getTeamsByMatch(int idMatch);
}
