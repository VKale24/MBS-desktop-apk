part of 'match_bloc.dart';

@immutable
abstract class MatchEvent {
  const MatchEvent();

  List<Object> get props => [];
}

class GetMatchsByTournament extends MatchEvent {
  final int idTournament;
  const GetMatchsByTournament({required this.idTournament});
}

class GetMatchsByTournamentAndRound extends MatchEvent {
  final int idTournament;
  final int round;
  const GetMatchsByTournamentAndRound(
      {required this.idTournament, required this.round});
}
