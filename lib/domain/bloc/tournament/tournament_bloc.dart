import 'package:desktop_apk/domain/entities/tournament.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:desktop_apk/network/tournament_network.dart';
import 'package:desktop_apk/data/model/tournament_model.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(TournamentInitial()) {
    on<AddTournament>(_onAddTournament);
    on<GetTournaments>(_onGettingTournaments);
    on<SelectTournament>(_onSelectTournament);
    on<UpdateTournament>(_onUpdateTournament);
    on<UploadImageOfTournament>(_onUploadImageOfTournament);
  }

  Future<void> _onGettingTournaments(
    GetTournaments event,
    Emitter<TournamentState> emit,
  ) async {
    try {
      emit(LoadingTournaments());
      final Tournaments tournaments =
          await TournamentNetwork.instance.getAllTournaments();
      if (tournaments.tournaments.isEmpty) emit(EmmptyTournaments());

      emit(LoadedTournaments(tournaments: tournaments));
    } catch (e) {
      _handleError(e);
    }
  }

  void _onSelectTournament(
    SelectTournament event,
    Emitter<TournamentState> emit,
  ) {
    try {
      emit(SelectedTournament(tournament: event.tournament));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onAddTournament(
    AddTournament event,
    Emitter<TournamentState> emit,
  ) async {
    try {
      emit(LoadingTournaments());
      await TournamentNetwork.instance.createTournament(event.tournament);

      await _onGettingTournaments(const GetTournaments(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUpdateTournament(
    UpdateTournament event,
    Emitter<TournamentState> emit,
  ) async {
    try {
      await TournamentNetwork.instance
          .updateTournament(event.tournament.idTournament, event.tournament);

      //Emitir un nuevo estado con el jugador actualizado
      await _onGettingTournaments(const GetTournaments(), emit);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _onUploadImageOfTournament(
    UploadImageOfTournament event,
    Emitter<TournamentState> emit,
  ) async {
    try {
      TournamentModel tournamentModel = await TournamentNetwork.instance
          .uploadImageToTournament(
              event.tournamentModel.idTournament, event.image);
      if (event.nextEmit == "selectedTournament") {
        _onSelectTournament(SelectTournament(tournamentModel), emit);
      } else {
        await _onGettingTournaments(const GetTournaments(), emit);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  TournamentState _handleError(Object e) {
    if (e is ErrorTournaments) return ErrorTournaments(error: e.error);
    return ErrorTournaments(error: "Algo anda mal");
  }
}
