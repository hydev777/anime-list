import 'package:anime_repository/anime_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../anime_details/cubit/anime_details_cubit.dart';
import '../anime_list/cubit/anime_list_cubit.dart';
import '../router/router.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.animeRepository,
  });

  final AnimeRepository animeRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnimeListCubit>(
          create: (context) => AnimeListCubit(
            animeRepository: widget.animeRepository,
          ),
          lazy: false,
        ),
        BlocProvider<AnimeDetailsCubit>(
          create: (context) => AnimeDetailsCubit(
            animeRepository: widget.animeRepository,
          ),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
