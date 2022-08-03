part of 'team_bloc.dart';

@immutable
abstract class TeamEvent {
  const TeamEvent();

  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetTeams extends TeamEvent {
  const GetTeams();
}

class AddTeam extends TeamEvent {
  final TeamModel team;
  const AddTeam(this.team);
}

class UpdateTeam extends TeamEvent {
  final TeamModel team;

  const UpdateTeam(this.team);
}

class UploadImageOfTeam extends TeamEvent {
  final Team team;
  // ignore: prefer_typing_uninitialized_variables
  final image;
  final String nextEmit;
   const UploadImageOfTeam({required this.image, required this.nextEmit, required this.team});
}

class SelectTeam extends TeamEvent {
  final Team team;
  const SelectTeam({required this.team});
}
