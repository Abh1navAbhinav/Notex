import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackbar({
  required BuildContext context,
  required String text,
  Color backgroundColor = Colors.white,
  Color textcolor = Colors.red,
  FontWeight fontWeight = FontWeight.w400,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.aBeeZee(
              color: textcolor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
