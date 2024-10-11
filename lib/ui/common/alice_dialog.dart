import 'package:alice/model/alice_translation.dart';
import 'package:alice/ui/common/alice_context_ext.dart';
import 'package:alice/ui/common/alice_theme.dart';
import 'package:flutter/material.dart';

/// General dialogs used in Alice.
class AliceGeneralDialog {
  /// Helper method used to open alarm with given title and description.
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String description,
    String? firstButtonTitle,
    String? secondButtonTitle,
    Function? firstButtonAction,
    Function? secondButtonAction,
  }) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: AliceTheme.getTheme(),
            child: AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                TextButton(
                  onPressed: () {
                    // ignore: avoid_dynamic_calls
                    firstButtonAction?.call();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    firstButtonTitle ?? context.i18n(AliceTranslationKey.accept),
                  ),
                ),
                if (secondButtonTitle != null)
                  TextButton(
                    onPressed: () {
                      // ignore: avoid_dynamic_calls
                      secondButtonAction?.call();
                      Navigator.of(context).pop();
                    },
                    child: Text(secondButtonTitle),
                  ),
              ],
            ),
          );
        },
      );

  /// Snackbar
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack({
    required BuildContext context,
    required String title,
    required String description,
    required int code,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  code.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: code == 200 || code == 201 ? Colors.green : Colors.red,
                  ),
                ),
              ),
              SizedBox(
                width: 24.0,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24.0),
              Flexible(
                  flex: 1,
                  child: Icon(
                    code == 200 || code == 201 ? Icons.check : Icons.warning_amber,
                    color: code == 200 || code == 201 ? Colors.green : Colors.red,
                  )),
            ],
          ),
        ),
      );
}
