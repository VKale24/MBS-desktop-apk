import 'package:desktop_apk/data/model/tournament_model.dart';
import 'dart:io';

import 'package:desktop_apk/data/repository/interface_tournament_repository.dart';
import 'package:desktop_apk/domain/entities/tournament.dart';

import '../../network/tournament_network.dart';

class TournamentRepository implements ITournamentRepository {
  @override
  Future<Tournaments> getAllTournaments() async {
    return await TournamentNetwork.instance.getAllTournaments();
  }

  @override
  Future<Tournament> getTournamentById(int idTournament) async {
    return await TournamentNetwork.instance.getTournamentById(idTournament);
  }

  @override
  Future<Tournaments> getTournamentsNotFinished() async {
    return await TournamentNetwork.instance.getTournamentsNotFinished();
  }

  @override
  Future<TournamentModel> createTournament(TournamentModel tournament) async {
    return await TournamentNetwork.instance.createTournament(tournament);
  }

  @override
  Future<bool> addTeamToTournament(int idTournament, int idTeam) async {
    return await TournamentNetwork.instance
        .addTeamToTournament(idTournament, idTeam);
  }

  @override
  Future<bool> deleteTournament(int idTournament) async {
    return await TournamentNetwork.instance.deleteTournament(idTournament);
  }

  @override
  Future<bool> updateTournament(TournamentModel tournament) async {
    return await TournamentNetwork.instance.updateTournament(tournament);
  }

  @override
  Future uploadImageToTournament(int idTournament, File image) async {
    return await TournamentNetwork.instance
        .uploadImageToTournament(idTournament, image);
  }
}
