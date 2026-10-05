import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
    );

    return base.copyWith(
      // =========================
      // TEXT
      // =========================
      textTheme: GoogleFonts.poppinsTextTheme(
        base.textTheme,
      ).apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),

      // =========================
      // APP BAR
      // =========================
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h2,
      ),

      // =========================
      // CARD
      // =========================
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),

      // =========================
      // INPUT
      // =========================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        labelStyle: AppTextStyles.bodyMuted,
        hintStyle: AppTextStyles.bodyMuted,

        prefixIconColor: AppColors.textGrey,
        suffixIconColor: AppColors.textGrey,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.borderGreen,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.borderGreen,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.7,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.danger,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 1.7,
          ),
        ),
      ),

      // =========================
      // FILLED BUTTON
      // =========================
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.disabled,

          minimumSize: const Size(
            0,
            50,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          textStyle: AppTextStyles.button,
        ),
      ),

      // =========================
      // OUTLINED BUTTON
      // =========================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,

          side: const BorderSide(
            color: AppColors.borderGreen,
            width: 1.4,
          ),

          minimumSize: const Size(
            0,
            50,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 13,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          textStyle: AppTextStyles.button,
        ),
      ),

      // =========================
      // TEXT BUTTON
      // =========================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
        ),
      ),

      // =========================
      // FLOATING BUTTON
      // =========================
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      // =========================
      // SWITCH
      // =========================
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }

            return AppColors.border;
          },
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }

            return AppColors.textGrey;
          },
        ),
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryLight,
        surfaceTintColor: Colors.transparent,

        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppTextStyles.navigationSelected;
            }

            return AppTextStyles.navigation;
          },
        ),

        iconTheme: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: AppColors.textDark,
                size: 22,
              );
            }

            return const IconThemeData(
              color: AppColors.textDark,
              size: 22,
            );
          },
        ),
      ),

      // =========================
      // DIVIDER
      // =========================
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // =========================
      // SNACKBAR
      // =========================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textDark,
        contentTextStyle: AppTextStyles.body.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      // =========================
      // BOTTOM SHEET
      // =========================
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
      ),
    );
  }
}