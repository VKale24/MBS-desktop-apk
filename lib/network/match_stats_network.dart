import 'dart:convert';

import 'package:desktop_apk/data/model/goal_model.dart';
import 'package:http/http.dart' as http;

import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/data/model/match_stats_model.dart';
import 'package:desktop_apk/data/datasource/match_stats_data_source_network.dart';

class MatchStatsNetwork extends MatchStatsNetworkDataSource {
  MatchStatsNetwork._();

  static final instance = MatchStatsNetwork._();
  @override
  Future<dynamic> getStatsByMatch(int idMatch) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match_stats/match/$idMatch",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final ListMatchStats listMatchStats =
          ListMatchStats.fromJsonList(responseString);

      return listMatchStats;
    } else if (response.statusCode == 204) {
      return response.statusCode;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MatchStatsModel> getStatsByMatchAndTeam(
      int idMatch, int idTeam) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match_stats/match/$idMatch/team/$idTeam",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final MatchStatsModel matchStats =
          MatchStatsModel.fromJson(responseString);
      return matchStats;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> addGoal(int idMatchStats, int idPlayer) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/match_stats/$idMatchStats/goal/$idPlayer",
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> addAssist(int idMatchStats, int idPlayer) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/match_stats/$idMatchStats/assist/$idPlayer",
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> addRedCard(int idMatchStats, int idPlayer) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/match_stats/$idMatchStats/yellow_card/$idPlayer",
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> addYellowCard(int idMatchStats, int idPlayer) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/match_stats/$idMatchStats/red_card/$idPlayer",
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future getGoalsByMatchStats(int idMatchStats) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match_stats/$idMatchStats/goals",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Goals goals = Goals.fromJsonList(responseString);
      return goals;
    } else {
      throw Exception();
    }
  }
}
