import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final Future<void> Function() onTap;
  final String buttonText;
  const CustomButton(
      {required this.buttonText, required this.onTap, super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          showLoader = true;
        });
        await widget.onTap();
        setState(() {
          showLoader = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xff834eed),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 50,
        alignment: Alignment.center,
        width: double.infinity,
        child: showLoader
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                widget.buttonText,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
      ),
    );
  }
}
