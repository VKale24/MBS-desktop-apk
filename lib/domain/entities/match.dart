import 'package:desktop_apk/data/model/tournament_model.dart';

class MatchEntity {
  int idMatch;
  String referee;
  String date;
  int round;
  TournamentModel tournamentModel;
  MatchEntity(
      {required this.idMatch,
      required this.referee,
      required this.date,
      required this.round,
      required this.tournamentModel
      });
}
