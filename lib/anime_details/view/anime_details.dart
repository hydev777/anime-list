import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/anime_details_cubit.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails({
    super.key,
    this.animeId,
  });

  final String? animeId;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<AnimeDetailsCubit>()
          .fetchAnimeDetails(widget.animeId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AnimeDetailsCubit, AnimeDetailsState>(
          builder: (context, state) {
            if (state.animeDetailsStatus == AnimeDetailsStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.animeDetailsStatus == AnimeDetailsStatus.success) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    stretch: true,
                    onStretchTrigger: () async {},
                    stretchTriggerOffset: 300.0,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        state.animeDetails!.animeImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        state.animeDetails!.animeName!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            border: Border.all(
                              color: const Color(0xFF303030),
                              width: 3,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF303030),
                                offset: Offset(3, 10),
                                blurStyle: BlurStyle.outer,
                                spreadRadius: -6,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            shape: Border.all(
                              color: Colors.black,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                color: state.animeDetails!.characters![index]
                                            .gender ==
                                        "Male"
                                    ? Colors.blue
                                    : Colors.pink,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(2, 2),
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Image.network(
                                state.animeDetails!.characters![index]
                                    .characterImage!,
                              ),
                            ),
                            title: Text(
                              state.animeDetails!.characters![index].name!,
                              style: const TextStyle(
                                color: Color(0xFF535353),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              state.animeDetails!.characters![index].desc!,
                              style: const TextStyle(
                                color: Color(0xFF535353),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.animeDetails!.characters!.length,
                    ),
                  ),
                ],
              );
            }

            if (state.animeDetailsStatus == AnimeDetailsStatus.error) {
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
