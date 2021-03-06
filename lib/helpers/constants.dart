import 'dart:math';

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff0006c1);
final kSecondaryColor = Colors.blueGrey[50];
final kTextColor = Colors.blueGrey.withOpacity(0.5);
final kColorRandom =
    Colors.primaries[Random().nextInt(Colors.primaries.length)];

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
