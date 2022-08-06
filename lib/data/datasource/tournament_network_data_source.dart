import 'dart:io';

import 'package:desktop_apk/data/model/tournament_model.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';

abstract class TournamentNetworkDataSource {
  Future<Tournaments> getAllTournaments();

  Future<Tournaments> getTournamentsNotFinished();

  Future<Tournament> getTournamentById(int idTournament);

  Future<TournamentModel> createTournament(TournamentModel tournament);

  Future<bool> addTeamToTournament(int idTournament, int idTeam);

  Future<bool> updateTournament(TournamentModel tournament);

  Future<dynamic> uploadImageToTournament(int idTournament, File image);

  Future<bool> deleteTournament(int idTournament);
}
