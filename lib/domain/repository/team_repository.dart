import 'package:desktop_apk/data/model/team_model.dart';
import 'dart:io';

import 'package:desktop_apk/data/repository/interface_team_repository.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/network/team_network.dart';

class TeamRepository implements ITeamRepository {
  @override
  Future<bool> createTeam(TeamModel team) async {
    return await TeamNetwork.instance.createTeam(team);
  }

  @override
  Future<bool> deleteTeam(int idTeam) async {
    return await TeamNetwork.instance.deleteTeam(idTeam);
  }

  @override
  Future<Teams> getAllTeams() async {
    return await TeamNetwork.instance.getAllTeams();
  }

  @override
  Future<Team> getTeamById(int idTeam) async {
    return await TeamNetwork.instance.getTeamById(idTeam);
  }

  @override
  Future<TeamModel> getTeamByName(String name) async {
    return await TeamNetwork.instance.getTeamByName(name);
  }

  @override
  Future<TeamModel> updateTeam(int idTeam, TeamModel team) async {
    return await TeamNetwork.instance.updateTeam(idTeam, team);
  }

  @override
  Future uploadImageToTeam(int idTeam, File image) async {
    return await TeamNetwork.instance.uploadImageToTeam(idTeam, image);
  }
}
