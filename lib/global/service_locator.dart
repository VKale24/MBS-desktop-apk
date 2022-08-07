import 'package:desktop_apk/domain/repository/match_repository.dart';
import 'package:desktop_apk/domain/repository/match_stats_repository.dart';
import 'package:desktop_apk/domain/repository/player_repository.dart';
import 'package:desktop_apk/domain/repository/roster_repository.dart';
import 'package:desktop_apk/domain/repository/team_match_repository.dart';
import 'package:desktop_apk/domain/repository/team_repository.dart';
import 'package:desktop_apk/domain/repository/team_tournament_repository.dart';
import 'package:desktop_apk/domain/repository/tournament_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<TeamRepository>(TeamRepository());
  locator.registerSingleton<MatchRepository>(MatchRepository());
  locator.registerSingleton<PlayerRepository>(PlayerRepository());
  locator.registerSingleton<RosterRepository>(RosterRepository());
  locator.registerSingleton<TeamMatchRepository>(TeamMatchRepository());
  locator.registerSingleton<TournamentRepository>(TournamentRepository());
  locator.registerSingleton<MatchStatsRepository>(MatchStatsRepository());
  locator
      .registerSingleton<TeamTournamentRepository>(TeamTournamentRepository());
}
