part of 'tournament_bloc.dart';

@immutable
abstract class TournamentEvent {
  const TournamentEvent();

  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTournaments extends TournamentEvent {
  const GetTournaments();
}

class AddTournament extends TournamentEvent {
  final TournamentModel tournament;
  const AddTournament(this.tournament);
}

class UpdateTournament extends TournamentEvent {
  final TournamentModel tournament;

  const UpdateTournament(this.tournament);
}

class UploadImageOfTournament extends TournamentEvent {
  final TournamentModel tournamentModel;
  // ignore: prefer_typing_uninitialized_variables
  final image;
  final String nextEmit;
  const UploadImageOfTournament(
      {required this.image,
      required this.nextEmit,
      required this.tournamentModel});
}

class SelectTournament extends TournamentEvent {
  final Tournament tournament;
  const SelectTournament(this.tournament);
}
