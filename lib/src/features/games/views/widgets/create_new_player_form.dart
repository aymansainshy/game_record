import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hareeg/src/core/widgets/build_form_field.dart';

const textDirection = TextDirection.ltr;

class CreateNewPlayerForm extends StatelessWidget {
  const CreateNewPlayerForm({
    super.key,
    required this.onPlayerSaved,
    required this.playerFocusNode,
    this.playerNameValidator,
  });

  final void Function(String?)? onPlayerSaved;
  final String? Function(String?)? playerNameValidator;

  final FocusNode? playerFocusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: BuildFormField(
        textDirection: textDirection,
        fieldName: "Player Name",
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        focusNode: playerFocusNode,
        prefixIcon: const Icon(
          CupertinoIcons.person_add_solid,
          color: Colors.grey,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
        onFieldSubmitted: (_) {
          // FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        validator: playerNameValidator,
        onSaved: onPlayerSaved,
      ),
    );
  }
}
