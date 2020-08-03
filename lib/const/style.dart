import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle textHintStyle = TextStyle(color: textColorHint, fontSize: 12);

TextStyle textHeadLine6WithBoldStyle(BuildContext context) =>
    Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold);

TextTheme textThemeOf(BuildContext context) => Theme.of(context).textTheme;
