import 'package:flutter/material.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/widgets/new_record_form.dart';

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

  // late List<TextEditingController> _controllers;

  late int? score = 0;

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
  }

  void generateFocusNode() {
    _focusNodes = List.generate(widget.game.getGamePlayers().length, (index) => FocusNode());
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
    generateFocusNode();
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.game.getGamePlayers().length; i++) {
      _focusNodes[i].dispose();
      // _controllers[i].dispose();
    }
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    // print(_focusNodeList.toString());

    return Dialog(
      // backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      child: Container(
        height: mediaQuery.height / 2,
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
                    widget.game.getGamePlayers().length,
                    (index) {
                      return SizedBox(
                        height: 60,
                        width: mediaQuery.width / widget.game.getGamePlayers().length,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: NewRecordForm(
                            // onPlayerSaved: (String? value) {
                            //   if (value != null) score = int.tryParse(value);
                            // },
                            focusNode: _focusNodes[index],
                            // controller: _controllers[index],
                            // playerNameValidator: (String? value) {
                            //   if (value == null) {
                            //     return "Record is required";
                            //   }
                            //   if (value.isEmpty) {
                            //     return "Invalid record";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
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
