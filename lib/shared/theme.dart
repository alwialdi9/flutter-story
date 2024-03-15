part of 'shared.dart';

Color mainColor = "1D5D9B".toColor();
Color greyColor = "8D92A3".toColor();

Color firstColor = "1D5D9B".toColor();
Color secondColor = "75C2F6".toColor();
Color thirdColor = "F4D160".toColor();
Color fourthColor = "FBEEAC".toColor();

Widget loadingIndicator = SpinKitFadingCircle(
              size: 45,
              color: firstColor,
            );

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle22 = GoogleFonts.poppins().copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle16 = GoogleFonts.poppins().copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle14 = GoogleFonts.poppins().copyWith(color: Colors.black, fontWeight: FontWeight.w500);

const double defaultMargin = 24;
