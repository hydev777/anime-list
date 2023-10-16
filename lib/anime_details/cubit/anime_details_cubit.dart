import 'dart:developer';

import 'package:anime_repository/anime_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_details_state.dart';

class AnimeDetailsCubit extends Cubit<AnimeDetailsState> {
  AnimeDetailsCubit({
    required AnimeRepository animeRepository,
  })  : _animeRepository = animeRepository,
        super(const AnimeDetailsState());

  final AnimeRepository _animeRepository;

  Future<void> fetchAnimeDetails(String id) async {
    emit(
      state.copyWith(
        animeDetailsStatus: AnimeDetailsStatus.loading,
      ),
    );

    try {
      final animeDetails = await _animeRepository.getAnimeCharacters(id);

      emit(
        state.copyWith(
          animeDetailsStatus: AnimeDetailsStatus.success,
          animeDetails: animeDetails,
        ),
      );
    } catch (err, stack) {
      log(err.toString());
      log(stack.toString());

      emit(
        state.copyWith(
          animeDetailsStatus: AnimeDetailsStatus.error,
        ),
      );
    }
  }
}
