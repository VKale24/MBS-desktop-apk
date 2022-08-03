part of 'team_match_bloc.dart';

@immutable
abstract class TeamMatchState {}

class TeamMatchInitial extends TeamMatchState {
  TeamMatchInitial();

  List<Object?> get props => [];
}

class LoadedTeamsOfMatch extends TeamMatchState {
  LoadedTeamsOfMatch({required ListTeamMatchs listTeamMatchs})
      // ignore: prefer_initializing_formals
      : listTeamMatchs = listTeamMatchs;
  final ListTeamMatchs listTeamMatchs;

  List<Object?> get props => [listTeamMatchs];
}

class LoadedMatchsOfTeam extends TeamMatchState {
  LoadedMatchsOfTeam({required List<MatchGame> listMatchGame})
      // ignore: prefer_initializing_formals
      : listMatchGame = listMatchGame;
  final List<MatchGame> listMatchGame;

  List<Object?> get props => [listMatchGame];
}

class LoadedStatsOfMatch extends TeamMatchState {
  LoadedStatsOfMatch({required ListMatchStats listMatchStats})
      // ignore: prefer_initializing_formals
      : listMatchStats = listMatchStats;
  final ListMatchStats listMatchStats;

  List<Object?> get props => [listMatchStats];
}

class ErrorTeamMatch extends TeamMatchState {
  ErrorTeamMatch({required this.error});

  final String error;

  List<Object?> get props => [error];
}

class LoadingData extends TeamMatchState {
  LoadingData();

  List<Object?> get props => [];
}
