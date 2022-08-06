import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_lib;
import 'package:desktop_apk/global/network.dart';
import 'package:desktop_apk/data/datasource/player_network_data_source.dart';
import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/model/player_stats_model.dart';
import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';

class PlayerNetwork extends PlayerNetworkDatasource {
  PlayerNetwork._();

  static final instance = PlayerNetwork._();
  var dio = dio_lib.Dio();

  @override
  Future<Players> getAllPlayers() async {
    Response response = await dio.get("${Network.url}/player");

    if (response.statusCode == 200) {
      Players players = Players.fromJsonList(response.data);
      return players;
    }
    throw Exception();
  }

  @override
  Future<PlayerModel> getPlayerById(int idPlayer) async {
    final Response response = await dio.get("${Network.url}/player/$idPlayer");

    if (response.statusCode == 200) {
      final PlayerModel player = PlayerModel.fromJson(response.data);
      return player;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerModel> getPlayerByCI(String ci) async {
    final Response response = await dio.get("${Network.url}/player/ci/$ci");
    if (response.statusCode == 200) {
      final PlayerModel player = PlayerModel.fromJson(response.data);
      return player;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerStats> getStatsOfPlayerByTournament(
      int idPlayer, int idTournament) async {
    final Response response = await dio.get(
      "${Network.url}/player/$idPlayer/stats_tournament/$idTournament",
    );
    if (response.statusCode == 200) {
      final PlayerStats playerStats = PlayerStatsModel.fromJson(response.data);
      return playerStats;
    } else {
      throw Exception();
    }
  }

  @override
  Future<PlayerModel> createPlayer(PlayerModel player) async {
    final Response response = await dio.post("${Network.url}/player",
        options: Options(headers: {"content-type": "application/json"}),
        data: playerModelToJson(player));
    if (response.statusCode == 201) {
      final PlayerModel player = PlayerModel.fromJson(response.data);
      return player;
    }
    throw Exception();
  }

  @override
  Future<dynamic> uploadImageToPlayer(int idPlayer, File image) async {
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
    final Response response = await dio.patch(
        "${Network.url}/player/${player.idPlayer}",
        options: Options(headers: {"content-type": "application/json"}),
        data: playerModelToJson(player));
    if (response.statusCode == 200) {
      final Player player = PlayerModel.fromJson(response.data);
      return player;
    }
    return false;
  }

  @override
  Future<bool> desactivatePlayer(int idPlayer) async {
    final Response response = await dio.delete(
      "${Network.url}/player/$idPlayer",
      options: Options(headers: {"content-type": "application/json"}),
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  @override
  Future<bool> activatePlayer(int idPlayer) async {
    final Response response = await dio.post(
      "${Network.url}/player/$idPlayer/activate_player",
      options: Options(headers: {"content-type": "application/json"}),
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
