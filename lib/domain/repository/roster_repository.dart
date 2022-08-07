import 'package:desktop_apk/data/model/roster_model.dart';
import 'package:desktop_apk/data/repository/interface_roster.dart';
import 'package:desktop_apk/network/roster_network.dart';

class RosterRepository implements IRosterRepository {
  @override
  Future addPlayerToRoster(int idPlayer, int idTeam, int idTournament) async {
    return await RosterNetwork.instance
        .addPlayerToRoster(idPlayer, idTeam, idTournament);
  }

  @override
  Future<Rosters> getActiveRosterByTeam(int idTeam) async {
    return await RosterNetwork.instance.getActiveRosterByTeam(idTeam);
  }

  @override
  Future<Rosters> getHistoryRosterByTeam(int idTeam) async {
    return await RosterNetwork.instance.getHistoryRosterByTeam(idTeam);
  }

  @override
  Future<Rosters> getTeamsByPlayer(int idPlayer) async {
    return await RosterNetwork.instance.getTeamsByPlayer(idPlayer);
  }

  @override
  Future<bool> removePlayerOfRoster(
      int idTeam, int idTournament, int idPlayer) async {
    return await RosterNetwork.instance
        .removePlayerOfRoster(idTeam, idTournament, idPlayer);
  }
}
