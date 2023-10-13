import 'dart:developer';

import 'package:anime_repository/anime_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_list_state.dart';

class AnimeListCubit extends Cubit<AnimeListState> {
  AnimeListCubit({
    required AnimeRepository animeRepository,
  })  : _animeRepository = animeRepository,
        super(const AnimeListState());

  final AnimeRepository _animeRepository;

  Future<void> fetchAnimeList() async {
    emit(
      state.copyWith(
        animeListStatus: AnimeListStatus.loading,
      ),
    );

    try {
      final animeList = await _animeRepository.fetchAnimeList();

      if (animeList.titles!.isNotEmpty) {
        emit(
          state.copyWith(
            animeListStatus: AnimeListStatus.success,
            animeList: animeList.titles,
          ),
        );
      } else {
        emit(
          state.copyWith(
            animeListStatus: AnimeListStatus.empty,
          ),
        );
      }
    } catch (err, stack) {
      log(err.toString());
      log(stack.toString());

      emit(
        state.copyWith(
          animeListStatus: AnimeListStatus.error,
        ),
      );
    }
  }
}
