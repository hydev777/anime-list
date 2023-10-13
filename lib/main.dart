import 'package:anime_repository/anime_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app/app.dart';

void main() {
  final animeRepository = AnimeRepository(
    httpClient: http.Client(),
  );

  runApp(
    App(
      animeRepository: animeRepository,
    ),
  );
}
