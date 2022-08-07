part of 'player_bloc.dart';

@immutable
abstract class PlayerEvent extends Equatable{
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GetPlayers extends PlayerEvent {
  const GetPlayers();
}

class AddPlayer extends PlayerEvent {
  final PlayerModel player;
  const AddPlayer(this.player);
}

class UploadImageOfPlayer extends PlayerEvent {
  final Player player;
  // ignore: prefer_typing_uninitialized_variables
  final image;
  const UploadImageOfPlayer({required this.image, required this.player});
}

class SelectPlayer extends PlayerEvent {
  final PlayerModel player;
  const SelectPlayer(this.player);
}

class UpdatePlayer extends PlayerEvent {
  final PlayerModel player;

  const UpdatePlayer({required this.player});
}
