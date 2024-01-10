import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart' as dialog;

const String kLogoAnimation = "logoAnimation";
const double kElevatedButtonHeight = 55.0;

// final logger = Logger(
//   printer: PrettyPrinter(),
// );

customeAlertDialoge({
  BuildContext? context,
  Function? fun,
  String? title,
  String? errorMessage,
  String? imageUrl,
  dialog.AlertType? alertType,
}) {
  return dialog.Alert(
    context: context!,
    style: dialog.AlertStyle(
      animationType: dialog.AnimationType.grow,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontSize: 14),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      descTextAlign: TextAlign.center,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
      ),
      alertAlignment: Alignment.center,
    ),
    type: imageUrl == null ? alertType ?? dialog.AlertType.warning : null,
    title: "$title",
    desc: "$errorMessage",
    image: imageUrl == null
        ? null
        : Image.asset(
            imageUrl,
            color: Colors.blue[700],
          ),
    buttons: [
      dialog.DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(context);
          fun!();
        },
        color: Theme.of(context).colorScheme.primary,
        radius: BorderRadius.circular(8.0),
      ),
    ],
  ).show();
}
