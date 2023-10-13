import 'package:go_router/go_router.dart';

import '../anime_details/view/anime_details.dart';
import '../anime_list/view/anime_list.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/anime-list',
      builder: (context, state) => const AnimeList(),
    ),
    GoRoute(
      path: '/anime/:id',
      builder: (context, state) => AnimeDetails(
        animeId: state.pathParameters['id'],
      ),
    ),
  ],
  initialLocation: "/anime-list",
);
