import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';

class Roster {
  int idRoster;
  TeamModel teamModel;
  TournamentModel tournamentModel;
  PlayerModel playerModel;
  bool playerActive;

  Roster(
      {required this.idRoster,
      required this.teamModel,
      required this.tournamentModel,
      required this.playerModel,
      required this.playerActive});
}
