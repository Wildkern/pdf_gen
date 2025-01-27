import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomizationState {
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;

  CustomizationState({
    required this.fontSize,
    required this.fontColor,
    required this.backgroundColor,
  });

  CustomizationState copyWith({
    double? fontSize,
    Color? fontColor,
    Color? backgroundColor,
  }) {
    return CustomizationState(
      fontSize: fontSize ?? this.fontSize,
      fontColor: fontColor ?? this.fontColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

final customizationProvider =
    StateNotifierProvider<CustomizationNotifier, CustomizationState>((ref) {
  return CustomizationNotifier();
});

class CustomizationNotifier extends StateNotifier<CustomizationState> {
  CustomizationNotifier()
      : super(CustomizationState(
          fontSize: 14.0,
          fontColor: Colors.black,
          backgroundColor: Colors.white,
        ));

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void updateFontColor(Color color) {
    state = state.copyWith(fontColor: color);
  }

  void updateBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }
}
