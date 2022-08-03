import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio_lib;

import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/data/datasource/tournament_network_data_source.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';

class TournamentNetwork extends TournamentNetworkDataSource {
  TournamentNetwork._();

  static final instance = TournamentNetwork._();
  @override
  Future<Tournaments> getAllTournaments() async {
    Tournaments tournaments = Tournaments();
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/tournament/all",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      tournaments = Tournaments.fromJsonList(responseString);
      return tournaments;
    }
    return tournaments;
  }

  @override
  Future<Tournaments> getTournamentsNotFinished() async {
    Tournaments tournaments = Tournaments();
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/tournament/",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      tournaments = Tournaments.fromJsonList(responseString);
      return tournaments;
    }
    return tournaments;
  }

  @override
  Future<Tournament> getTournamentById(int idTournament) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/tournament/$idTournament",
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
  Future<TournamentModel> createTournament(TournamentModel tournament) async {
    final http.Response response = await http.post(
        Uri.parse(
          "${Network.url}/tournament",
        ),
        headers: {"content-type": "application/json"},
        body: tournamentModelToJson(tournament));

    if (response.statusCode == 201) {
      final responseString = json.decode(response.body);
      final TournamentModel tournament =
          TournamentModel.fromJson(responseString);
      return tournament;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> addTeamToTournament(int idTournament, int idTeam) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/tournament/$idTournament/add_team/$idTeam",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> updateTournament(
      int idTournament, TournamentModel tournament) async {
    final http.Response response = await http.patch(
        Uri.parse(
          "${Network.url}/tournament/$idTournament",
        ),
        headers: {"content-type": "application/json"},
        body: tournamentModelToJson(tournament));
    if (response.statusCode == 201) return true;
    return false;
  }

  @override
  Future<dynamic> uploadImageToTournament(int idTournament, File image) async {
    var dio = dio_lib.Dio();

    var formData = dio_lib.FormData.fromMap(
        {'image': await dio_lib.MultipartFile.fromFile(image.path)});

    final dio_lib.Response response = await dio.post(
      "${Network.url}/tournament/$idTournament/upload-image",
      data: formData,
      options: dio_lib.Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 201) {
      final TournamentModel tournament =
          TournamentModel.fromJson(response.data);
      return tournament;
    }
    return false;
  }

  @override
  Future<bool> deleteTournament(int idTournament) async {
    final http.Response response = await http.delete(
      Uri.parse(
        "${Network.url}/player/$idTournament",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
