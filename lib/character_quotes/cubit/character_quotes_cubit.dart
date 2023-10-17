import 'package:anime_repository/anime_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'character_quotes_state.dart';

class CharacterQuotesCubit extends Cubit<CharacterQuotesState> {
  CharacterQuotesCubit({
    required AnimeRepository animeRepository,
  })  : _animeRepository = animeRepository,
        super(const CharacterQuotesState());

  final AnimeRepository _animeRepository;

  Future<void> onFetchCharacterQuotes(String characterId) async {
    emit(
      state.copyWith(
        characterQuotesStatus: CharacterQuotesStatus.loading,
      ),
    );

    try {
      final characterQuotes =
          await _animeRepository.getCharacterQuotes(characterId);

      emit(
        state.copyWith(
          characterQuotesStatus: CharacterQuotesStatus.success,
          characterQuotes: characterQuotes,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          characterQuotesStatus: CharacterQuotesStatus.error,
        ),
      );
    }
  }
}
