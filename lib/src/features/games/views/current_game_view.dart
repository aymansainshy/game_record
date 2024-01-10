import 'package:flutter/material.dart';
import 'package:hareeg/src/features/games/widgets/game_item_widget.dart';

class CurrentGameView extends StatefulWidget {
  const CurrentGameView({super.key});

  @override
  State<CurrentGameView> createState() => _CurrentGameViewState();
}

class _CurrentGameViewState extends State<CurrentGameView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SizedBox(
      height: mediaQuery.height,
      width: mediaQuery.width,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return GameItemWidget();
        },
      ),
    );
  }
}
