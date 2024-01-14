import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/game_item_widget.dart';

class HistoryGameView extends StatefulWidget {
  const HistoryGameView({super.key});

  @override
  State<HistoryGameView> createState() => _HistoryGameViewState();
}

class _HistoryGameViewState extends State<HistoryGameView> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GamesBloc>(context).add(GetAllGames());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SizedBox(
      height: mediaQuery.height,
      width: mediaQuery.width,
      child: BlocBuilder<GamesBloc, GamesState>(
        builder: (context, gamesStates) {
          switch (gamesStates) {
            case GamesInProgress():
              return const Center(child: CircularProgressIndicator());

            case GamesFailure():
              return Center(
                child: Text(
                  "Something went wrong, please try again",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black45,
                      ),
                ),
              );

            case GamesSuccess():
              final gameList =
                  gamesStates.games?.where((game) => game?.status == GameStatus.completed).toList().reversed.toList() ??
                      [];

              if (gameList.isEmpty) {
                return Center(
                  child: Text(
                    "No Games.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black45,
                        ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: gameList?.length,
                itemBuilder: (context, index) {
                  return GameItemWidget(
                    game: gameList?[index],
                  );
                },
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
