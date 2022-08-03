import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/domain/entities/team.dart';

class MatchGame {
  MatchModel match;
  Team team1;
  Team team2;
  String state;
  MatchGame({
    required this.match,
    required this.team1,
    required this.team2,
    required this.state,
  });
}
