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

  // Checking if the diagonal screen size is greater than 7 inches
  return diagonalSize > 7.0;
}