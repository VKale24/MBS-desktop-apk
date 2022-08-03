import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';

class TeamMatch {
  int idTeamMatch;
  String state;
  TeamModel teamModel;
  MatchModel matchModel;

  TeamMatch({
    required this.idTeamMatch,
    required this.state,
    required this.teamModel,
    required this.matchModel,
  });
}
