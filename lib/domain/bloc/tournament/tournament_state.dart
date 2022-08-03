part of 'tournament_bloc.dart';

@immutable
abstract class TournamentState {}

class TournamentInitial extends TournamentState {
  TournamentInitial();
  List<Object?> get props => [];
}

class LoadingTournaments extends TournamentState {
  LoadingTournaments();

  List<Object?> get props => [];
}

class LoadedTournaments extends TournamentState {
  LoadedTournaments({required Tournaments tournaments})
      // ignore: prefer_initializing_formals
      : tournaments = tournaments;
  final Tournaments tournaments;

  List<Object?> get props => [tournaments];
}

class EmmptyTournaments extends TournamentState {
  EmmptyTournaments();

  List<Object?> get props => [];
}

class SelectedTournament extends TournamentState {
  SelectedTournament({required Tournament tournament})
      // ignore: prefer_initializing_formals
      : tournament = tournament;

  final Tournament tournament;

  List<Object?> get props => [];
}

class ErrorTournaments extends TournamentState {
  ErrorTournaments({required this.error});

  final String error;

  List<Object?> get props => [error];
}
