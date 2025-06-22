import 'package:flutter/material.dart';

class AppSpace extends StatelessWidget {
  const AppSpace({super.key, this.space = 10, this.isHorizontal = false});
  final double space;
  final bool isHorizontal;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isHorizontal ? 0 : space,
      width: isHorizontal ? space : 0,
    );
  }
}
