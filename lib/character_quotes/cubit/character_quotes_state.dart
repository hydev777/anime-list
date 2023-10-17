// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'character_quotes_cubit.dart';

enum CharacterQuotesStatus { initial, loading, success, empty, error }

class CharacterQuotesState extends Equatable {
  const CharacterQuotesState({
    this.characterQuotes,
    this.characterQuotesStatus,
  });

  final CharacterQuotes? characterQuotes;
  final CharacterQuotesStatus? characterQuotesStatus;

  CharacterQuotesState copyWith({
    CharacterQuotes? characterQuotes,
    CharacterQuotesStatus? characterQuotesStatus,
  }) {
    return CharacterQuotesState(
      characterQuotes: characterQuotes ?? this.characterQuotes,
      characterQuotesStatus:
          characterQuotesStatus ?? this.characterQuotesStatus,
    );
  }

  @override
  List<Object?> get props => [
        characterQuotes,
        characterQuotesStatus,
      ];
}
