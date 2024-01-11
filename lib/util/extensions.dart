import 'package:flutter/material.dart';

getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

extension GetSize on double {
  double toResponsive(BuildContext context) {
    return (getSize(context).height * this) + (getSize(context).width * this);
  }

  double h(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }

  double w(BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}
