import 'dart:math';

import 'package:flutter/material.dart';

bool isTablet(BuildContext context) {
  // Getting device width and height using MediaQuery
  Size screenSize = MediaQuery.of(context).size;

  // Calculating diagonal screen size
  double diagonalSize = sqrt(
    (screenSize.width * screenSize.width) +
    (screenSize.height * screenSize.height),
  );

  // Typical threshold for tablet devices
  return diagonalSize >= 7.0 && (screenSize.shortestSide >= 600);
}
