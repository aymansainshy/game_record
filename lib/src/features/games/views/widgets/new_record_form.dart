import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const textDirection = TextDirection.ltr;

class NewRecordForm extends StatelessWidget {
  const NewRecordForm({
    super.key,
    required this.focusNode,
    // required this.controller,
  });

  //
  // final void Function(String?)? onPlayerSaved;
  // final String? Function(String?)? playerNameValidator;

  final FocusNode? focusNode;

  // final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      focusNode: focusNode,
      autofocus: true,
      style: Theme.of(context).textTheme.titleLarge,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
      ],
      // onFieldSubmitted: (_) {
      //   FocusScope.of(context).nextFocus();
      // },
      onChanged: (value) {
        if (value.length == 3) {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide(color: Colors.black26,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          // borderSide: BorderSide(color: Colors.black26),
        ),
        hintText: "0",
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        focusColor: Theme.of(context).colorScheme.primary,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
