import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAppbar extends AppBar {
  AppAppbar({Key? key, required String title})
      : super(
            key: key,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              title,
              style: GoogleFonts.pacifico(fontSize: 30.0, color: Colors.black),
            ),
            // iconTheme: const IconThemeData(
            //   color: Colors.black,
            // ),
            automaticallyImplyLeading: false);
}
