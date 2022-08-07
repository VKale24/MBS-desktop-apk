import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/data/model/team_tournament_model.dart';
import 'package:desktop_apk/data/datasource/team_tournament_network_data_source.dart';

class TeamTournamentNetwork extends TeamTournamentNetworkDataSource {
  TeamTournamentNetwork._();

  static final instance = TeamTournamentNetwork._();
  @override
  Future<ListTeamTournaments> getTeamsByTournament(int idTournament) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_tournament/tournament/$idTournament",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final ListTeamTournaments teamTournaments =
          ListTeamTournaments.fromJsonList(responseString);
      return teamTournaments;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Tournament> getTournamentsByTeam(int idTeam) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_tournament/team/$idTeam",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Tournament tournament = TournamentModel.fromJson(responseString);
      return tournament;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ListTeamTournaments> getTableByTournament(int idTournament) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_tournament/$idTournament/table",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final ListTeamTournaments listTeamTournament =
          ListTeamTournaments.fromJsonList(responseString);
      return listTeamTournament;
    } else {
      throw Exception();
    }
  }
}
