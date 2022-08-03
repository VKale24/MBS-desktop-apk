part of 'match_stats_bloc.dart';

@immutable
abstract class MatchStatsEvent {
  const MatchStatsEvent();

}

class InitMatchStats extends MatchStatsEvent {
  const InitMatchStats();
}

class GetStatsByMatch extends MatchStatsEvent {
  final MatchModel matchModel;
  const GetStatsByMatch({required this.matchModel});
}

class GetStatsByMatchAndTeam extends MatchStatsEvent {
  const GetStatsByMatchAndTeam();
}
