import 'dart:io';

import 'package:desktop_apk/data/model/player_model.dart';
import 'package:desktop_apk/domain/entities/player_stats.dart';

abstract class PlayerNetworkDatasource {
  Future<Players> getAllPlayers();

  Future<PlayerModel> getPlayerById(int idPlayer);

  Future<PlayerModel> getPlayerByCI(String ci);

  Future<dynamic> uploadImageToPlayer(int idPlayer, File image);

  Future<PlayerStats> getStatsOfPlayerByTournament(
      int idPlayer, int idTournament);

  Future<PlayerModel> createPlayer(PlayerModel player);

  Future<dynamic> updatePlayer(PlayerModel player);

  Future<bool> desactivatePlayer(int idPlayer);

  Future<bool> activatePlayer(int idPlayer);
}
