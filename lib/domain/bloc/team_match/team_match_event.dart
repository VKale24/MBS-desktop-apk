part of 'team_match_bloc.dart';

@immutable
abstract class TeamMatchEvent {
  const TeamMatchEvent();

  List<Object> get props => [];
}

class GetTeamsOfMatch extends TeamMatchEvent {
  const GetTeamsOfMatch({required this.match});

  final MatchModel match;
}

class GetMatchsOfTeam extends TeamMatchEvent {
  const GetMatchsOfTeam({required this.team});

  final Team team;
}

class GetStatsOfMatch extends TeamMatchEvent {
  const GetStatsOfMatch({required this.match});

  final MatchModel match;
}
