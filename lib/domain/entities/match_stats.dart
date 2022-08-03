import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_model.dart';

class MatchStats {
  int idMatchStats;
  int goal;
  int assist;
  int yellowCard;
  int redCard;
  TeamModel teamModel;
  MatchModel matchModel;

  MatchStats({
    required this.idMatchStats,
    required this.goal,
    required this.assist,
    required this.yellowCard,
    required this.redCard,
    required this.matchModel,
    required this.teamModel,
  });
}
