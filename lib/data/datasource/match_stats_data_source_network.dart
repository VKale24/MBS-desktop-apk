import 'package:desktop_apk/domain/entities/match_stats.dart';

abstract class MatchStatsNetworkDataSource {
  Future<dynamic> getStatsByMatch(int idMatch);
  Future<dynamic> getGoalsByMatchStats(int idMatchStats);
  Future<MatchStats> getStatsByMatchAndTeam(int idMatch, int idTeam);
  Future<bool> addGoal(int idMatchStats, int idPlayer);
  Future<bool> addAssist(int idMatchStats, int idPlayer);
  Future<bool> addYellowCard(int idMatchStats, int idPlayer);
  Future<bool> addRedCard(int idMatchStats, int idPlayer);
}
