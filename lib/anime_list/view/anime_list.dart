import 'package:anime_list/anime_list/cubit/anime_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({super.key});

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AnimeListCubit>().onFetchAnimeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Anime List"),
        ),
        body: BlocBuilder<AnimeListCubit, AnimeListState>(
          builder: (context, state) {
            if (state.animeListStatus == AnimeListStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.animeListStatus == AnimeListStatus.success) {
              return ListView.builder(
                itemCount: state.animeList!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.animeList![index].wikipediaUrl!),
                  onTap: () {
                    context.push("/anime/${state.animeList![index].animeId}");
                  },
                ),
              );
            }

            if (state.animeListStatus == AnimeListStatus.empty) {
              return const Center(
                child: Text("Anime list is empty"),
              );
            }

            if (state.animeListStatus == AnimeListStatus.error) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            }

            return const Center(
              child: Text("Some unexpected error happened"),
            );
          },
        ),
      ),
    );
  }
}
