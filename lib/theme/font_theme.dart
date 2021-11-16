import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

buildTextTheme(TextTheme base) {
  base = base.copyWith(
    headline1: base.headline1.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay4FontSize,
      letterSpacing: kLetterSpacing,
    ),
    headline2: base.headline2.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay3FontSize,
      letterSpacing: kLetterSpacing,
    ),
    headline3: base.headline3.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay2FontSize,
      letterSpacing: kLetterSpacing,
    ),
    headline4: base.headline4.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay1FontSize,
      letterSpacing: kLetterSpacing,
    ),
    headline5: base.headline5.copyWith(
      fontSize: kHeadlineFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: kLetterSpacing,
    ),
    headline6: base.headline6.copyWith(
      fontSize: kSubheadFontSize,
      letterSpacing: kLetterSpacing,
    ),
    subtitle1: base.subtitle1.copyWith(
      fontSize: kTitleFontSize,
      letterSpacing: kLetterSpacing,
      fontWeight: FontWeight.w600,
      color: kBrandRedColor,
    ),
    subtitle2: base.subtitle2.copyWith(
      letterSpacing: kLetterSpacing,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w400,
    ),
    bodyText1: base.bodyText1.copyWith(
      fontSize: kBody1FontSize,
      letterSpacing: kLetterSpacing,
    ),
    bodyText2: base.bodyText2.copyWith(
      fontSize: kBody2FontSize,
      letterSpacing: kLetterSpacing,
    ),
    button: base.button.copyWith(
      fontSize: kButtonFontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: kLetterSpacing,
    ),
    caption: base.caption.copyWith(
      fontSize: kCaptionFontSize,
      letterSpacing: kLetterSpacing,
    ),
    overline: base.overline.copyWith(
      fontSize: kOverlineFontSize,
      letterSpacing: kLetterSpacing,
      fontWeight: FontWeight.w600,
      color: kBrandRedColor,
    ),
  );

  return base.apply(
    fontFamily: 'JosefinSans',
    displayColor: kBrandRedColor,
  );
}
