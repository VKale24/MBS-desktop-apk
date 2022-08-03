// ignore_for_file: prefer_initializing_formals

part of 'match_bloc.dart';

@immutable
abstract class MatchState {}

class MatchInitial extends MatchState {
  MatchInitial();

  List<Object?> get props => [];
}

class EmptyMatchs extends MatchState {
  EmptyMatchs();

  List<Object?> get props => [];
}

class LoadedMatchsByTournament extends MatchState {
  LoadedMatchsByTournament({required Matchs matchs}) : matchs = matchs;

  final Matchs matchs;
  List<Object?> get props => [matchs];
}

class LoadedMatchsByTournamentAndRound extends MatchState {
  LoadedMatchsByTournamentAndRound({required List<ListTeamMatchs> listMatchs}) : listMatchs = listMatchs;

  final List<ListTeamMatchs> listMatchs;
  List<Object?> get props => [listMatchs];
}

class ErrorMatchs extends MatchState {
  ErrorMatchs({required this.error});

  final String error;

  List<Object?> get props => [error];
}