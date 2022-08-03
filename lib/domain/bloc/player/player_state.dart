part of 'player_bloc.dart';

@immutable
abstract class PlayerState {}

class PlayerInitial extends PlayerState {
  PlayerInitial();

  List<Object?> get props => [];
}

class LoadingPlayers extends PlayerState {
  LoadingPlayers();

  List<Object?> get props => [];
}

class LoadedPlayers extends PlayerState {
  LoadedPlayers({required Players players})
      // ignore: prefer_initializing_formals
      : players = players,
        playersExist = players.players.isEmpty ? false : true;

  final bool playersExist;
  final Players players;

  List<Object?> get props => [players, playersExist];
}

class EmmptyPlayers extends PlayerState {
  EmmptyPlayers();

  List<Object?> get props => [];
}

class SelectedPlayer extends PlayerState {
  SelectedPlayer({required PlayerModel player})
      // ignore: prefer_initializing_formals
      : player = player;

  final PlayerModel player;

  List<Object?> get props => [];
}

class LoadedPlayer extends PlayerState {
  LoadedPlayer({required Player player})
      // ignore: prefer_initializing_formals
      : player = player,
        playerExist = true;

  final bool playerExist;
  final Player player;
}

class ErrorPlayers extends PlayerState {
  ErrorPlayers({required this.error});

  final String error;

  List<Object?> get props => [error];
}
