import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';

class TournamentMatch {
  int idTournamentMatch;
  MatchModel matchModel;
  TournamentModel tournamentModel;

  TournamentMatch({
    required this.idTournamentMatch,
    required this.matchModel,
    required this.tournamentModel,
  });
}
