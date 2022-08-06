// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/data/datasource/match_network_data_source.dart';
import 'package:desktop_apk/data/model/match_model.dart';
import 'package:desktop_apk/data/model/team_match_model.dart';
import 'package:http/http.dart' as http;

import '../domain/repository/team_match_repository.dart';
import '../global/service_locator.dart';

class MatchNetwork extends MatchNetworkDataSource {
  MatchNetwork._();

  static final instance = MatchNetwork._();
  @override
  Future<Matchs> getAllMatchs() async {
    Matchs matchs = Matchs();
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      matchs = Matchs.fromJsonList(responseString);
      return matchs;
    }
    return matchs;
  }

  @override
  Future<MatchModel> getMatchById(int idMatch) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match/$idMatch",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final MatchModel match = MatchModel.fromJson(responseString);
      return match;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Matchs> getAllMatchsByTeam(int idTeam) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team_match/team/$idTeam",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Matchs matchs = Matchs.fromJsonList(responseString);
      return matchs;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ListTeamMatchs>> getMatchsByTournamentAndRound(
      int idTournament, int round) async {
    List<ListTeamMatchs> listTeamMatchs = [];

    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match/tournament/$idTournament/round/$round",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Matchs listMatchs = Matchs.fromJsonList(responseString);

      for (MatchModel matchModel in listMatchs.matchs) {
        listTeamMatchs.add(await locator<TeamMatchRepository>()
            .getTeamsByMatch(matchModel.idMatch));
      }

      return listTeamMatchs;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> createMatch(
      MatchModel match, int idTeam1, int idTeam2, int idTournament) async {
    Map body = {
      "referee": match.referee,
      "date": match.date,
      "idTeam1": idTeam1,
      "idTeam2": idTeam2,
      "idTournament": idTournament,
      "round": match.round
    };

    final http.Response response = await http.post(
        Uri.parse(
          "${Network.url}/match",
        ),
        headers: {"content-type": "application/json"},
        body: json.encode(body));
    if (response.statusCode == 201) return true;
    return false;
  }

  @override
  Future<bool> updateMatch(int idMatch, MatchModel match) async {
    final http.Response response = await http.patch(
        Uri.parse(
          "${Network.url}/match/$idMatch",
        ),
        headers: {"content-type": "application/json"},
        body: matchModelToJson(match));
    if (response.statusCode == 201) return true;
    return false;
  }

  @override
  Future<bool> deleteMatch(int idMatch) async {
    final http.Response response = await http.delete(
      Uri.parse(
        "${Network.url}/match/$idMatch",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  @override
  Future<Matchs> getMatchsByTournament(int idTournament) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/match/tournament/$idTournament",
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Matchs matchs = Matchs.fromJsonList(responseString);
      return matchs;
    } else {
      throw Exception();
    }
  }
}
