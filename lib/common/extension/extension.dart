import 'package:flutter/material.dart';

extension StringExtension on String {
  pngImage() => "assets/images/$this.png";
  jPGImage() => "assets/image/$this.jpg";
}

getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

extension GetSize on double {
  double res(BuildContext context) {
    return (getSize(context).height * this) + (getSize(context).width * this);
  }

  double h(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }

  double w(BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}
