import 'package:flutter/material.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class TotalScoreWidget extends StatelessWidget {
  const TotalScoreWidget({
    super.key,
    required this.gamePlayer,
    required this.mediaQuery,
    required this.gamePlayerLength,
    required this.color,
    required this.game,
  });

  final GamePlayer gamePlayer;
  final Size mediaQuery;
  final int gamePlayerLength;
  final Color color;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: (mediaQuery.width / gamePlayerLength),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: gamePlayer.isFire() ? Color(0xFFD22323) : color,
        border: Border.all(
          color: Colors.black, // You can change the color as needed
          width: 3,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: gamePlayer.isFire() ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Text(
                  gamePlayer.totalPlayerScore().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }),
          ),
          if (gamePlayer.isFire())
            Positioned(
              top: -25,
              left: -15,
              child: Text(
                "🔥",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),
            ),
          if (gamePlayer.isChampion(game) ?? false)
            Positioned(
              top: -25,
              left: -15,
              child: Text(
                "👑",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),
            ),
        ],
      ),
    );
  }
}
