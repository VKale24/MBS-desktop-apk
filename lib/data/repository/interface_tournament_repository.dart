import 'dart:io';

import '../model/tournament_model.dart';
import '../../domain/entities/tournament.dart';

abstract class ITournamentRepository{
  Future<Tournaments> getAllTournaments();

  Future<Tournaments> getTournamentsNotFinished();

  Future<Tournament> getTournamentById(int idTournament);

  Future<TournamentModel> createTournament(TournamentModel tournament);

  Future<bool> addTeamToTournament(int idTournament, int idTeam);

  Future<bool> updateTournament(TournamentModel tournament);

  Future<dynamic> uploadImageToTournament(int idTournament, File image);

  Future<bool> deleteTournament(int idTournament);
}