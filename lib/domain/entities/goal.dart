import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';

class Goal {
  int idGoal;
  int minute;
  MatchStatsModel matchStatsModel;
  PlayerModel playerModel;
  Goal({
    required this.idGoal,
    required this.minute,
    required this.matchStatsModel,
    required this.playerModel,
  });
}
