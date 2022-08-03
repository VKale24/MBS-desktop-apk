part of 'match_stats_bloc.dart';

abstract class MatchStatsState {
  const MatchStatsState();

}

class MatchStatsInitial extends MatchStatsState {
  const MatchStatsInitial();

}

class LoadedMatchStatsByTeam extends MatchStatsState {
  const LoadedMatchStatsByTeam({required ListMatchStats listMatchStats})
      // ignore: prefer_initializing_formals
      : listMatchStats = listMatchStats;

  final ListMatchStats listMatchStats;
}

class EmptyMatchStatsByTeam extends MatchStatsState {
  const EmptyMatchStatsByTeam();
}

class ErrorMatchStats extends MatchStatsState {
  const ErrorMatchStats({required this.error});

  final String error;
}
