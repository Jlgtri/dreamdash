import 'package:flutter/material.dart';

const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment(0.40, -0.91),
  end: Alignment(-0.4, 0.91),
  colors: <Color>[Color(0xFF104B8E), Color(0xFF306AAC)],
);

const LinearGradient secondaryGradient = LinearGradient(
  begin: Alignment(0.31, -0.95),
  end: Alignment(-0.31, 0.95),
  colors: <Color>[Color(0xFFFBD080), Color(0xFFF2DDB5), Color(0xFFFCD180)],
);

const BoxShadow buttonShadow = BoxShadow(
  color: Color(0x19000000),
  blurRadius: 4,
  offset: Offset(5, 4),
);

extension ScrollToBottom on ScrollController {
  Future<void> scrollToBottom() async {
    final double baseOffset = offset;
    if (baseOffset != position.maxScrollExtent) {
      while (baseOffset == offset) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        jumpTo(position.maxScrollExtent);
      }
    }
  }
}
