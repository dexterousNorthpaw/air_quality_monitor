import 'package:flutter/material.dart';

Future<dynamic> showPopUpDialog({
  required BuildContext context,
  required String content,
  Color bodyTextColor = Colors.black,
  String? confirmText,
  String cancelText = "Cancel",
  Color cancelTextColor = Colors.white,
  Color confirmTextColor = Colors.white,
  void Function()? confirmFunction,
  void Function()? cancelFunction,
  bool logout = false,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: bodyTextColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: cancelFunction ??
                          () {
                            Navigator.pop(context);
                          },
                      color: Colors.black.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        cancelText,
                        style: TextStyle(fontSize: 14, color: cancelTextColor),
                      ),
                    ),
                    if (confirmText != null)
                      MaterialButton(
                        onPressed: confirmFunction,
                        color: const Color(0xff834eed),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            fontSize: 16,
                            color: confirmTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
