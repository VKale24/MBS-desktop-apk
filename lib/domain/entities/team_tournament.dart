import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/data/model/team_stats_model.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/stats_table.dart';

class TeamTournament {
  int idTeamTournament;
  TeamModel teamModel;
  TournamentModel tournamentModel;
  TeamStatsModel teamStatsModel;
  StatsTable statsTableModel;

  TeamTournament(
      {required this.idTeamTournament,
      required this.teamModel,
      required this.tournamentModel,
      required this.teamStatsModel,
      required this.statsTableModel,
      });
}
