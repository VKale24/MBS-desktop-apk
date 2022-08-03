//import 'package:dio/dio.dart' as dio_lib;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:desktop_apk/common/network.dart';

import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/data/datasource/roster_data_source.dart';

class RosterNetwork extends RosterDataSource {
  RosterNetwork._();

  static final instance = RosterNetwork._();
  @override
  Future<bool> addPlayerToRoster(
      int idPlayer, int idTeam, int idTournament) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/roster/tournament/$idTournament/team/$idTeam/add-player/$idPlayer",
      ),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Rosters> getActiveRosterByTeam(int idTeam) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/roster/active-players/team/$idTeam/",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Rosters playersRoster = Rosters.fromJsonList(responseString);
      return playersRoster;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Rosters> getTeamsByPlayer(int idPlayer) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/roster/player/$idPlayer/",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      Rosters playersRoster = Rosters.fromJsonList(responseString);

      return playersRoster;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Rosters> getHistoryRosterByTeam(int idTeam) {
    throw UnimplementedError();
  }

  @override
  Future<bool> removePlayerOfRoster(
      int idTeam, int idTournament, int idPlayer) async {
    final http.Response response = await http.delete(
      Uri.parse(
        "${Network.url}/roster/tournament/$idTournament/team/$idTeam/remove_player/$idPlayer",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
