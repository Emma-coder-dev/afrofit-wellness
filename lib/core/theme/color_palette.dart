import 'package:flutter/material.dart';

class ColorPalette {
  // Primary Colors
  static const Color primary = Color(0xFF2E7D32); // African green (vitality, growth)
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF1B5E20);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFF6F00); // Warm orange (energy, warmth)
  static const Color secondaryLight = Color(0xFFFF9800);
  static const Color secondaryDark = Color(0xFFE65100);
  
  // Accent Colors
  static const Color accent = Color(0xFFFFC107); // Gold (achievement, success)
  static const Color accentLight = Color(0xFFFFD54F);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);
  
  // Text Colors - FIXED FOR READABILITY ✅
  static const Color textPrimary = Color(0xFF212121);       // Dark gray - Main text
  static const Color textSecondary = Color(0xFF757575);     // Medium gray - Secondary text (FIXED)
  static const Color textHint = Color(0xFF9E9E9E);          // Light gray - Hints (FIXED)
  static const Color textDisabled = Color(0xFFBDBDBD);      // Disabled text
  static const Color textOnPrimary = Color(0xFFFFFFFF);     // White text on colored backgrounds
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Input Colors
  static const Color inputBackground = Color(0xFFFAFAFA);
  static const Color inputBorder = Color(0xFFBDBDBD);       // Medium gray border (FIXED)
  static const Color inputBorderFocused = Color(0xFF2E7D32); // Primary color when focused
  
  // Category Colors (for food types, exercise types)
  static const Color categoryProtein = Color(0xFFE91E63); // Pink
  static const Color categoryCarbs = Color(0xFFFF9800);   // Orange
  static const Color categoryVegetable = Color(0xFF4CAF50); // Green
  static const Color categoryFruit = Color(0xFFFFEB3B);   // Yellow
  
  // Body Part Colors (for exercise targeting)
  static const Color bodyCore = Color(0xFFFF6F00);
  static const Color bodyUpperBody = Color(0xFF2196F3);
  static const Color bodyLowerBody = Color(0xFF9C27B0);
  static const Color bodyCardio = Color(0xFFF44336);
  
  // Progress Colors
  static const Color progressExcellent = Color(0xFF4CAF50);
  static const Color progressGood = Color(0xFF8BC34A);
  static const Color progressFair = Color(0xFFFFC107);
  static const Color progressPoor = Color(0xFFFF9800);
  static const Color progressBad = Color(0xFFF44336);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryLight, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Overlay Colors (for dark overlays on images)
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black
  
  // Shadow Colors
  static const Color shadowLight = Color(0x0F000000); // 6% black
  static const Color shadowMedium = Color(0x29000000); // 16% black
}