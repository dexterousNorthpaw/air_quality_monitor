import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFields extends StatelessWidget {
  final String fieldName;
  final TextEditingController textEditingController;
  final bool obscureText;
  final String hintText;
  final void Function()? onPressed;
  const LoginFields(
      {required this.fieldName,
      required this.textEditingController,
      required this.hintText,
      this.obscureText = false,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              fieldName,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: textEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                textStyle: const TextStyle(fontSize: 13),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red, width: 0.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red, width: 0.5),
              ),
              suffixIcon: onPressed == null
                  ? null
                  : IconButton(
                      onPressed: () {
                        onPressed!();
                      },
                      icon: Icon(
                        obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
            ),
            obscureText: obscureText,
            validator: (value) {
              return value!.trim().isEmpty
                  ? '$fieldName cannot be empty'
                  : null;
            },
          ),
        ],
      ),
    );
  }
}
