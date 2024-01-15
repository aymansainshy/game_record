import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/players-bloc/players_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/create_new_player_form.dart';

class CreateNewPlayerBottomSheet extends StatefulWidget {
  const CreateNewPlayerBottomSheet({super.key});

  @override
  State<CreateNewPlayerBottomSheet> createState() => _CreateNewPlayerBottomSheetState();
}

class _CreateNewPlayerBottomSheetState extends State<CreateNewPlayerBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final FocusNode _playerNameFocusNode = FocusNode();

  late String? playerName;

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    if (playerName != null) {
      BlocProvider.of<PlayersBloc>(context).add(CreateNewPlayer(name: playerName!));
      playerName = null;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _playerNameFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create new player',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CreateNewPlayerForm(
                onPlayerSaved: (String? value) {
                  playerName = value;
                },
                playerFocusNode: _playerNameFocusNode,
              ),
              Container(
                width: mediaQuery.width,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    _saveForm();
                  },
                  child: Text("Save Player"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
