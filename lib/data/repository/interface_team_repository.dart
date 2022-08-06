import 'dart:io';

import '../model/team_model.dart';
import '../../domain/entities/team.dart';

abstract class ITeamRepository {
  Future<Teams> getAllTeams();

  Future<Team> getTeamById(int idTeam);

  Future<TeamModel> getTeamByName(String name);

  Future<bool> createTeam(TeamModel team);

  Future<TeamModel> updateTeam(int idTeam, TeamModel team);

  Future<dynamic> uploadImageToTeam(int idTeam, File image);

  Future<bool> deleteTeam(int idTeam);
}