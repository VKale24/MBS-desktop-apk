import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/data/datasource/team_match_network_data_source.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:desktop_apk/domain/entities/match_game.dart';
import 'package:desktop_apk/domain/entities/team_match.dart';

class TeamMatchNetwork extends TeamMatchNetworkDataSource {
  TeamMatchNetwork._();

  static final instance = TeamMatchNetwork._();

  @override
  Future<List<MatchGame>> getAllMatchsByTeam(int idTeam) async {
    List<MatchGame> listMatchGame = [];
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_match/team/$idTeam",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      //Lista de Partidos del equipo
      final ListTeamMatchs teamMatchs =
          ListTeamMatchs.fromJsonList(responseString);
      //Sacando el partido y obteniendo los 2 equipos de cada partido
      for (TeamMatch teamMatch in teamMatchs.listTeamMatchs) {
        ListTeamMatchs listTeamMatch =
            await getTeamsByMatch(teamMatch.matchModel.idMatch);

        //Validamos los equipos para que se guarde en el team1 el equipo en cuestion y el el team2 el rival
        MatchGame matchGame = MatchGame(
            match: listTeamMatch.listTeamMatchs[0].matchModel,
            team1: listTeamMatch.listTeamMatchs[0].teamModel.name ==
                    teamMatchs.listTeamMatchs[0].teamModel.name
                ? listTeamMatch.listTeamMatchs[0].teamModel
                : listTeamMatch.listTeamMatchs[1].teamModel,
            team2: listTeamMatch.listTeamMatchs[0].teamModel.name ==
                    teamMatchs.listTeamMatchs[0].teamModel.name
                ? listTeamMatch.listTeamMatchs[1].teamModel
                : listTeamMatch.listTeamMatchs[0].teamModel,
            state: listTeamMatch.listTeamMatchs[0].state);
        listMatchGame.add(matchGame);
      }

      return listMatchGame;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ListTeamMatchs> getTeamsByMatch(int idMatch) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_match/match/$idMatch",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final ListTeamMatchs listTeamMatchs =
          ListTeamMatchs.fromJsonList(responseString);
      return listTeamMatchs;
    } else {
      throw Exception();
    }
  }
}
