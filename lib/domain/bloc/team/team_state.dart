part of 'team_bloc.dart';

@immutable
abstract class TeamState {}

class TeamInitial extends TeamState {
  TeamInitial();

  List<Object?> get props => [];
}

class LoadingTeams extends TeamState {
  LoadingTeams();

  List<Object?> get props => [];
}

class LoadedTeams extends TeamState {
  LoadedTeams({required Teams teams})
      // ignore: prefer_initializing_formals
      : teams = teams;

  final Teams teams;

  List<Object?> get props => [teams];
}

class LoadedTeam extends TeamState {
  LoadedTeam({required Team team})
      // ignore: prefer_initializing_formals
      : team = team;

  final Team team;
}

class EmmptyTeams extends TeamState {
  EmmptyTeams();

  List<Object?> get props => [];
}

class SelectedTeam extends TeamState {
  SelectedTeam({required Team team})
      // ignore: prefer_initializing_formals
      : team = team;

  final Team team;

  List<Object?> get props => [];
}

class ErrorTeams extends TeamState {
  ErrorTeams({required this.error});

  final String error;

  List<Object?> get props => [error];
}
