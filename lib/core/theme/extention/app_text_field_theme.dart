import 'package:flutter/material.dart';
import 'package:mothea3_app/core/theme/app_theme.dart';

import '../../constants/app_colors.dart';

extension AppTextFieldTheme on ThemeData {
  InputDecorationThemeData? largeTextFieldDecoration(BuildContext context) {
    if (AppTheme().isLightByBrightness(brightness)) {
      return inputDecorationTheme.copyWith(
        hintStyle: inputDecorationTheme.hintStyle?.copyWith(
            fontSize: 17,
            ),

        iconColor: AppColors.textGrey,
        suffixIconColor: AppColors.textGrey,
        prefixIconColor: AppColors.textGrey,
        filled: true,
        fillColor: AppColors.white,
        border: inputDecorationTheme.border?.copyWith(
          borderSide: const BorderSide(color: AppColors.textGrey, width: 0.8),
        ),

        enabledBorder: inputDecorationTheme.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: AppColors.textGrey, width: 0.8),
        ),
        focusedErrorBorder: inputDecorationTheme.focusedErrorBorder?.copyWith(
          borderSide: const BorderSide(color: AppColors.red, width: 1.2),
        ),
        errorBorder: inputDecorationTheme.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: AppColors.red, width: 0.8),
        ),
        focusedBorder: inputDecorationTheme.focusedBorder?.copyWith(
          borderSide: const BorderSide(color: AppColors.textGrey, width: 1.2),
        ),

        labelStyle: inputDecorationTheme.labelStyle
            ?.copyWith(color: AppColors.textGrey),
        // errorStyle: inputDecorationTheme.errorStyle,
        counterStyle: inputDecorationTheme.counterStyle
            ?.copyWith(color: AppColors.textGrey),
        isDense: true,
        helperStyle: inputDecorationTheme.helperStyle
            ?.copyWith(color: AppColors.textGrey),

        suffixStyle: inputDecorationTheme.suffixStyle
            ?.copyWith(color: AppColors.textGrey),
        prefixStyle: inputDecorationTheme.prefixStyle
            ?.copyWith(color: AppColors.textGrey),
      );
    }
    return inputDecorationTheme.copyWith(
      hintStyle: inputDecorationTheme.hintStyle?.copyWith(
          fontSize: 17,
          ),
      iconColor: AppColors.white,
      suffixIconColor: AppColors.white,
      prefixIconColor: AppColors.white,
      filled: true,
      fillColor:  AppColors.black,
      border: inputDecorationTheme.border?.copyWith(
        borderSide: const BorderSide(color: AppColors.white, width: 1),
      ),
      enabledBorder: inputDecorationTheme.enabledBorder?.copyWith(
        borderSide: const BorderSide(color: AppColors.white, width: 1),
      ),
      focusedErrorBorder: inputDecorationTheme.focusedErrorBorder?.copyWith(
        borderSide: const BorderSide(color: AppColors.red, width: 1.2),
      ),
      errorBorder: inputDecorationTheme.enabledBorder?.copyWith(
        borderSide: const BorderSide(color: AppColors.red, width: 0.8),
      ),
      focusedBorder: inputDecorationTheme.focusedBorder?.copyWith(
        borderSide: const BorderSide(color: AppColors.white, width: 1.8),
      ),
      labelStyle:
          inputDecorationTheme.labelStyle?.copyWith(color: AppColors.white),
      // errorStyle: inputDecorationTheme.errorStyle,
      counterStyle:
          inputDecorationTheme.counterStyle?.copyWith(color: AppColors.white),
      isDense: true,
      helperStyle:
          inputDecorationTheme.helperStyle?.copyWith(color: AppColors.white),

      suffixStyle:
          inputDecorationTheme.suffixStyle?.copyWith(color: AppColors.white),
      prefixStyle:
          inputDecorationTheme.prefixStyle?.copyWith(color: AppColors.white),
    );
  }
}
