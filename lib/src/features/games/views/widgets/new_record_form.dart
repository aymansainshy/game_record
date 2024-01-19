import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hareeg/src/theme/app_theme.dart';

const textDirection = TextDirection.ltr;

class NewRecordForm extends StatelessWidget {
  const NewRecordForm({
    super.key,
    required this.focusNode,
    this.onSaved,
    // required this.controller,
  });

  //
  final void Function(String?)? onSaved;

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
      validator: (value) {
        if (value == null) {
          return "Add score";
        }
        if (value.isEmpty) {
          return "Invalid input";
        }
        var parsedValue = int.tryParse(value);
        if (parsedValue == null) {
          return "Invalid number";
        }
        return null;
      },
      onChanged: (value) {
        if (value.length == 3) {
          FocusScope.of(context).nextFocus();
        }
      },
      onSaved: onSaved,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.primaryColorHex,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.primaryColorHex,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.primaryColorHex,
            width: 1.5,
          ),
        ),
        hintText: "0",
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[400],
            ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        focusColor: Theme.of(context).colorScheme.primary,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
