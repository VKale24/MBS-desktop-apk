part of 'teamtournament_bloc.dart';

@immutable
abstract class TeamTournamentsState {}

class TeamTournamentsInitial extends TeamTournamentsState {
  TeamTournamentsInitial();

  List<Object?> get props => [];
}

class LoadingTeamTournaments extends TeamTournamentsState {
  LoadingTeamTournaments();

  List<Object?> get props => [];
}

class LoadedTeamTournaments extends TeamTournamentsState {
  LoadedTeamTournaments({required ListTeamTournaments teamTournaments})
      // ignore: prefer_initializing_formals
      : teamTournaments = teamTournaments;

  final ListTeamTournaments teamTournaments;

  List<Object?> get props => [teamTournaments];
}

class LoadedTableOfTournament extends TeamTournamentsState {
  LoadedTableOfTournament({required ListTeamTournaments teamTournaments})
      // ignore: prefer_initializing_formals
      : teamTournaments = teamTournaments;

  final ListTeamTournaments teamTournaments;

  List<Object?> get props => [teamTournaments];
}

class EmmptyTeamTournaments extends TeamTournamentsState {
  EmmptyTeamTournaments();

  List<Object?> get props => [];
}

class ErrorTeamTournaments extends TeamTournamentsState {
  ErrorTeamTournaments({required this.error});

  final String error;

  List<Object?> get props => [error];
}
