import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';

class PlayerStats {
  int idPlayerStats;
  int goal;
  int assist;
  int yellowCard;
  int redCard;
  TournamentModel tournamentModelE;
  PlayerModel playerModelE;

  PlayerStats({
    required this.idPlayerStats,
    required this.goal,
    required this.assist,
    required this.yellowCard,
    required this.redCard,
    required this.tournamentModelE,
    required this.playerModelE,
  });
}
