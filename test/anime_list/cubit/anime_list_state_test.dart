import 'package:anime_list/anime_list/cubit/anime_list_cubit.dart';
import 'package:test/test.dart';

void main() {
  test('can be instantiated', () {
    expect(
      const AnimeListState(),
      isNotNull,
    );
  });
}
