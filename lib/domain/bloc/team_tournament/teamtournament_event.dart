part of 'teamtournament_bloc.dart';

@immutable
abstract class TeamTournamentEvent {
  const TeamTournamentEvent();

  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTeamsTournament extends TeamTournamentEvent {
  final int idTournament;
  final int idTeam;

  const GetTeamsTournament({required this.idTeam, required this.idTournament});
}

class GetTableOfTournament extends TeamTournamentEvent {
  final Tournament tournament;

  const GetTableOfTournament({required this.tournament});
}
