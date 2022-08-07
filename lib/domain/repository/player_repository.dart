import 'dart:io';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/data/repository/interface_player_repository.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';
import 'package:desktop_apk/network/player_network.dart';

class PlayerRepository implements IPlayerRepository {
  @override
  Future<Players> getAllPlayers() async {
    return await PlayerNetwork.instance.getAllPlayers();
  }

  @override
  Future<bool> activatePlayer(int idPlayer) async {
    return await PlayerNetwork.instance.activatePlayer(idPlayer);
  }

  @override
  Future<PlayerModel> createPlayer(PlayerModel player) async {
    return await PlayerNetwork.instance.createPlayer(player);
  }

  @override
  Future<bool> desactivatePlayer(int idPlayer) async {
    return await PlayerNetwork.instance.desactivatePlayer(idPlayer);
  }

  @override
  Future<PlayerModel> getPlayerByCI(String ci) async {
    return await PlayerNetwork.instance.getPlayerByCI(ci);
  }

  @override
  Future<PlayerModel> getPlayerById(int idPlayer) async {
    return await PlayerNetwork.instance.getPlayerById(idPlayer);
  }

  @override
  Future<PlayerStats> getStatsOfPlayerByTournament(
      int idPlayer, int idTournament) async {
    return await PlayerNetwork.instance
        .getStatsOfPlayerByTournament(idPlayer, idTournament);
  }

  @override
  Future updatePlayer(PlayerModel player) async {
    return await PlayerNetwork.instance.updatePlayer(player);
  }

  @override
  Future uploadImageToPlayer(int idPlayer, File image) async {
    return await PlayerNetwork.instance.uploadImageToPlayer(idPlayer, image);
  }
}
