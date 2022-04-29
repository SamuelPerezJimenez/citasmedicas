import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/DOCTORAGENDA-02.png',
          )
          // const Icon(
          //   Icons.library_books,
          //   color: Color.fromARGB(255, 255, 255, 255),
          //   size: 50,
          // ),
          // const SizedBox(height: 20),
          // Text(
          //   'Samuel Pérez',
          //   style: GoogleFonts.montserratAlternates(
          //       fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          // )
        ],
      ),
    );
  }
}
