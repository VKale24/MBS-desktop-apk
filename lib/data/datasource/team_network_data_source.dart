import 'dart:io';

import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/domain/entities/team.dart';

abstract class TeamNetworkDatasource {
  Future<Teams> getAllTeams();

  Future<Team> getTeamById(int idTeam);

  Future<TeamModel> getTeamByName(String name);

  Future<bool> createTeam(TeamModel team);

  Future<TeamModel> updateTeam(int idTeam, TeamModel team);

  Future<dynamic> uploadImageToTeam(int idTeam, File image);

  Future<bool> deleteTeam(int idTeam);
}
