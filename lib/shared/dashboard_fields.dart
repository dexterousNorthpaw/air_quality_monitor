import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardFields extends StatelessWidget {
  final String fieldName;
  final String fieldValue;
  final bool removePadding;
  const DashboardFields({
    super.key,
    required this.fieldName,
    required this.fieldValue,
    this.removePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              fieldName,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff53617c),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            width: 100,
            child: Text(
              fieldValue,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6186c5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
