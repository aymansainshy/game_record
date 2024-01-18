import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/sigle-game-bloc/single_game_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/new_record_form.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class AddNewRecordDialog extends StatefulWidget {
  const AddNewRecordDialog({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  State<AddNewRecordDialog> createState() => _AddNewRecordDialogState();
}

class _AddNewRecordDialogState extends State<AddNewRecordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  late List<FocusNode> _focusNodes;

  late int availablePlayersLength;
  late List<GamePlayer> availablePlayersList;

  // late List<TextEditingController> _controllers;

  late int? score = 0;

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formKey.currentState?.save();
    Navigator.pop(context);
  }

  void generateFocusNode() {
    _focusNodes = List.generate(availablePlayersLength, (index) => FocusNode());
    // _controllers = List.generate(widget.game.getGamePlayers().length, (index) => TextEditingController());

    // for (int i = 0; i < widget.game.getGamePlayers().length; i++) {
    //   _controllers[i].addListener(() {
    //     if (_controllers[i].text.isEmpty && i > 0) {
    //       FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
    //     }
    //   });
    // }

    // _controllers[5].addListener(() {
    //   if (_controllers[5].text.isEmpty) {
    //     FocusScope.of(context).requestFocus(_focusNodes[4]);
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();

    availablePlayersList = widget.game.getCurrentPlayers();
    availablePlayersLength = availablePlayersList.length;

    generateFocusNode();
  }

  @override
  void dispose() {
    for (int i = 0; i < availablePlayersLength; i++) {
      _focusNodes[i].dispose();
      // _controllers[i].dispose();
    }
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final duration = context.select((GameTimerBloc bloc) => bloc.state.duration);

    return Dialog(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      insetPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        height: mediaQuery.height / 3,
        width: mediaQuery.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(
                    availablePlayersLength,
                    (index) {
                      // final currentPlayers = widget.game.getCurrentPlayers();
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          SizedBox(
                            width: mediaQuery.width / availablePlayersLength,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.2,
                                    color: AppColors.primaryColorHex,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                child: Text(
                                  availablePlayersList[index].player.name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: mediaQuery.width / availablePlayersLength,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: NewRecordForm(
                                focusNode: _focusNodes[index],
                                // controller: _controllers[index],
                                onSaved: (value) {
                                  if (value != null || value!.isNotEmpty) {
                                    var isFire = availablePlayersList[index].addScore(int.parse(value));

                                    if (isFire) {
                                      // TODO: For fire sound ....
                                      print("WAAAAAAAAAAAIiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                                    }

                                    final updatedGPlayerList = widget.game.getCurrentPlayers();
                                    print("Current Players : ${updatedGPlayerList.length}");

                                    if (updatedGPlayerList.length == 1) {
                                      widget.game.champion = updatedGPlayerList.first.player.id;

                                      // TODO: For champion sound ....
                                      // TODO: trigger some animation ....

                                      context.read<SingleGameBloc>().add(UpdateGameDuration(
                                            game: widget.game,
                                            duration: duration,
                                          ));
                                      context.read<SingleGameBloc>().add(UpdateGameStatus(
                                            status: GameStatus.completed,
                                            game: widget.game,
                                          ));

                                      context.read<GameTimerBloc>().add(const TimerReset());
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: SizedBox(
                  width: mediaQuery.width,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text("Save Record"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
