import 'package:desktop_apk/data/repository/interface_match_stats_repository.dart';
import 'package:desktop_apk/domain/entities/match_stats.dart';
import 'package:desktop_apk/network/match_stats_network.dart';

class MatchStatsRepository implements IMatchStatsRepository {
  @override
  Future<bool> addAssist(int idMatchStats, int idPlayer) async {
    return await MatchStatsNetwork.instance.addAssist(idMatchStats, idPlayer);
  }

  @override
  Future<bool> addGoal(int idMatchStats, int idPlayer) async {
    return await MatchStatsNetwork.instance.addGoal(idMatchStats, idPlayer);
  }

  @override
  Future<bool> addRedCard(int idMatchStats, int idPlayer) async {
    return await MatchStatsNetwork.instance.addRedCard(idMatchStats, idPlayer);
  }

  @override
  Future<bool> addYellowCard(int idMatchStats, int idPlayer) async {
    return await MatchStatsNetwork.instance
        .addYellowCard(idMatchStats, idPlayer);
  }

  @override
  Future getGoalsByMatchStats(int idMatchStats) async {
    return await MatchStatsNetwork.instance.getGoalsByMatchStats(idMatchStats);
  }

  @override
  Future getStatsByMatch(int idMatch) async {
    return await MatchStatsNetwork.instance.getStatsByMatch(idMatch);
  }

  @override
  Future<MatchStats> getStatsByMatchAndTeam(int idMatch, int idTeam) async {
    return await MatchStatsNetwork.instance
        .getStatsByMatchAndTeam(idMatch, idTeam);
  }
}
