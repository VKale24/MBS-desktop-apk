import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:dio/dio.dart' as dio_lib;
import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/data/datasource/player_network_data_source.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/player_stats_model.dart';
import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';

class PlayerNetwork extends PlayerNetworkDatasource {
  PlayerNetwork._();

  static final instance = PlayerNetwork._();
  @override
  Future<Players> getAllPlayers() async {
    Players players = Players();
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/player",
      ),
    );
    if (response.statusCode == 200) {
      var responseString = json.decode(response.body);
      players = Players.fromJsonList(responseString);
      return players;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerModel> getPlayerById(int idPlayer) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/player/$idPlayer",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final PlayerModel player = PlayerModel.fromJson(responseString);
      return player;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerModel> getPlayerByCI(String ci) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/player/ci/$ci",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final PlayerModel player = PlayerModel.fromJson(responseString);
      return player;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerStats> getStatsOfPlayerByTournament(
      int idPlayer, int idTournament) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/player/$idPlayer/stats_tournament/$idTournament",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final PlayerStats playerStats = PlayerStatsModel.fromJson(responseString);
      return playerStats;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerModel> createPlayer(PlayerModel player) async {
    final http.Response response = await http.post(
        Uri.parse(
          "${Network.url}/player",
        ),
        headers: {"content-type": "application/json"},
        body: playerModelToJson(player));
    if (response.statusCode == 201) {
      final responseString = json.decode(response.body);
      final PlayerModel player = PlayerModel.fromJson(responseString);
      return player;
    }
    throw Exception();
  }

  @override
  Future<dynamic> uploadImageToPlayer(int idPlayer, File image) async {
    var dio = dio_lib.Dio();

    var formData =
        FormData.fromMap({'image': await MultipartFile.fromFile(image.path)});

    final dio_lib.Response response = await dio.post(
      "${Network.url}/player/$idPlayer/upload-image",
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 201) {
      final Player player = PlayerModel.fromJson(response.data);
      return player;
    }
    return false;
  }

  @override
  Future<dynamic> updatePlayer(PlayerModel player) async {
    final http.Response response = await http.patch(
        Uri.parse(
          "${Network.url}/player/${player.idPlayer}",
        ),
        headers: {"content-type": "application/json"},
        body: playerModelToJson(player));
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Player player = PlayerModel.fromJson(responseString);
      return player;
    }
    return false;
  }

  @override
  Future<bool> desactivatePlayer(int idPlayer) async {
    final http.Response response = await http.delete(
      Uri.parse(
        "${Network.url}/player/$idPlayer",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  @override
  Future<bool> activatePlayer(int idPlayer) async {
    final http.Response response = await http.post(
      Uri.parse(
        "${Network.url}/player/$idPlayer/activate_player",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
