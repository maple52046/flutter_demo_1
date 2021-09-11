import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Title22 extends StatelessWidget {
  /* Make text title with font size 22 */
  final String title;
  Title22(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.mcLaren(
        textStyle: TextStyle(
          color: CupertinoColors.black,
          fontSize: 22,
        ),
      ),
    );
  }
}
