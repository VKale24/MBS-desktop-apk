import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio_lib;

import 'package:desktop_apk/common/network.dart';
import 'package:desktop_apk/domain/entities/team.dart';
import 'package:desktop_apk/data/model/team_model.dart';
import 'package:desktop_apk/data/datasource/team_network_data_source.dart';

class TeamNetwork extends TeamNetworkDatasource {
  TeamNetwork._();

  static final instance = TeamNetwork._();
  @override
  Future<Teams> getAllTeams() async {
    Teams teams = Teams();
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      teams = Teams.fromJsonList(responseString);
      return teams;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Team> getTeamById(int idTeam) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team/$idTeam",
      ),
    );

    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final Team team = TeamModel.fromJson(responseString);
      return team;
    } else {
      throw Exception();
    }
  }

  @override
  Future<TeamModel> getTeamByName(String name) async {
    final http.Response response = await http.get(
      Uri.parse(
        "${Network.url}/team/name/$name",
      ),
    );
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final TeamModel team = TeamModel.fromJson(responseString);
      return team;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> createTeam(TeamModel team) async {
    final http.Response response = await http.post(
        Uri.parse(
          "${Network.url}/team",
        ),
        headers: {"content-type": "application/json"},
        body: teamModelToJson(team));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  @override
  Future<TeamModel> updateTeam(int idTeam, TeamModel team) async {
    final http.Response response = await http.patch(
        Uri.parse(
          "${Network.url}/team/$idTeam",
        ),
        headers: {"content-type": "application/json"},
        body: teamModelToJson(team));
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      final TeamModel team = TeamModel.fromJson(responseString);
      return team;
    } else {
      throw Exception();
    }
  }

  @override
  Future<dynamic> uploadImageToTeam(int idTeam, File image) async {
    var dio = dio_lib.Dio();

    var formData =
        FormData.fromMap({'image': await MultipartFile.fromFile(image.path)});

    final dio_lib.Response response = await dio.post(
      "${Network.url}/team/$idTeam/upload-image",
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 201) {
      final Team team = TeamModel.fromJson(response.data);
      return team;
    }
    return false;
  }

  @override
  Future<bool> deleteTeam(int idTeam) async {
    final http.Response response = await http.delete(
      Uri.parse(
        "${Network.url}/team/$idTeam",
      ),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  /*Future<dynamic> uploadImageToUser(
      File image, UserProvider userProvider) async {
    var dio = dioLib.Dio();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    dioLib.FormData formData = dioLib.FormData.fromMap(
        {"image": await dioLib.MultipartFile.fromFile(image.path)});

    final response = await dio.post("${Constants.url}/user/image/",
        data: formData,
        options: dioLib.Options(headers: {
          "Authorization": "Bearer ${sharedPreferences.getString("token")}"
        }));
    if (response.statusCode == 201) {
      UserModel userModel = UserModel.fromJson(response.data);
      userProvider.setUserModel(userModel);

      return userModel;
    }
    return null;
  }*/
}
