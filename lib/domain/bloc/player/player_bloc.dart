import 'package:meta/meta.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import 'package:desktop_apk/domain/entities/player.dart';
import 'package:desktop_apk/network/player_network.dart';
import 'package:desktop_apk/data/model/player_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  // ignore: prefer_initializing_formals
  PlayerBloc()
      // ignore: prefer_initializing_formals
      : super(PlayerInitial()) {
    on<AddPlayer>(_onAddPlayer);
    on<GetPlayers>(_onGettingPlayers);
    on<SelectPlayer>(_onSelectPlayer);
    on<UpdatePlayer>(_onUpdatePlayer);
    on<UploadImageOfPlayer>(_onUploadImageOfPlayer);
  }

  Future<void> _onGettingPlayers(
    GetPlayers event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      final Players players = await PlayerNetwork.instance.getAllPlayers();
      if (players.players.isEmpty) emit(EmmptyPlayers());

      emit(LoadedPlayers(players: players));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onAddPlayer(
    AddPlayer event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      emit(LoadingPlayers());
      await PlayerNetwork.instance.createPlayer(event.player);
      await _onGettingPlayers(const GetPlayers(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  void _onSelectPlayer(
    SelectPlayer event,
    Emitter<PlayerState> emit,
  ) {
    try {
      emit(SelectedPlayer(player: event.player));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUpdatePlayer(
    UpdatePlayer event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await PlayerNetwork.instance.updatePlayer(event.player);

      //Emitir un nuevo estado con el jugador actualizado
      //await _onGettingPlayers(const GetPlayers(), emit);
      //_onGettingPlayers(const GetPlayers(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUploadImageOfPlayer(
    UploadImageOfPlayer event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      await PlayerNetwork.instance
          .uploadImageToPlayer(event.player.idPlayer, event.image);
      await _onGettingPlayers(const GetPlayers(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  PlayerState _handleError(Object e) {
    if (e is ErrorPlayers) return ErrorPlayers(error: e.error);
    return ErrorPlayers(error: "Algo anda mal");
  }
}
