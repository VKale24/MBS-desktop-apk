import '../../domain/entities/match_game.dart';
import '../model/team_match_model.dart';

abstract class ITeamMatchRepository {
  Future<List<MatchGame>> getAllMatchsByTeam(int idTeam);

  Future<ListTeamMatchs> getTeamsByMatch(int idMatch);
}
