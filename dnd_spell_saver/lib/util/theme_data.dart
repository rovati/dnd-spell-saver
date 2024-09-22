import 'package:flutter/material.dart';

class AppThemeData {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF34ba6e),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color.fromARGB(255, 202, 230, 211),
    onPrimaryContainer: Color(0xFF202A33),
    secondary: Color(0xFFD1D0A3),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE6E6D6),
    onSecondaryContainer: Color(0xFF333328),
    tertiary: Color(0xFF242F40),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color.fromARGB(255, 198, 230, 214),
    onTertiaryContainer: Color(0xFF1D2533),
    error: Color(0xFFB0413E),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFE6B8B6),
    onErrorContainer: Color(0xFF331312),
    surface: Color(0xFFfcfcfc),
    onSurface: Color.fromARGB(255, 50, 51, 50),
    surfaceContainerHighest: Color.fromARGB(255, 240, 248, 244),
    onSurfaceVariant: Color.fromARGB(255, 94, 102, 97),
    outline: Color.fromARGB(255, 141, 153, 146),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBED4E6),
    onPrimary: Color(0xFF2F3F4C),
    primaryContainer: Color(0xFF3F5566),
    onPrimaryContainer: Color(0xFFCAD9E6),
    secondary: Color(0xFFE6E6CF),
    onSecondary: Color(0xFF4C4C3C),
    secondaryContainer: Color(0xFF666650),
    onSecondaryContainer: Color(0xFFE6E6D6),
    tertiary: Color(0xFFB8CAE6),
    onTertiary: Color(0xFF2B384C),
    tertiaryContainer: Color(0xFF394A66),
    onTertiaryContainer: Color(0xFFC6D2E6),
    error: Color(0xFFE6A5A3),
    onError: Color(0xFF4C1C1B),
    errorContainer: Color(0xFF662624),
    onErrorContainer: Color(0xFFE6B8B6),
    surface: Color(0xFF323333),
    onSurface: Color(0xFFe4e5e6),
    surfaceContainerHighest: Color(0xFF5e6366),
    onSurfaceVariant: Color(0xFFdee2e6),
    outline: Color(0xFFaaafb3),
  );

  static Color cardColor(bool isHovering) =>
      isHovering ? lightColorScheme.primaryContainer : Colors.white;

  static Color containerColor(bool isSelected, bool isHovering) {
    if (isSelected) {
      return lightColorScheme.primary;
    } else {
      if (isHovering) {
        return lightColorScheme.primaryContainer;
      } else {
        return lightColorScheme.surfaceContainerHighest;
      }
    }
  }

  static Color valueContainerColor(bool isSelected) {
    if (isSelected) {
      return lightColorScheme.primary;
    } else {
      return lightColorScheme.surfaceContainerHighest;
    }
  }

  static Color valueContainerBorderColor(bool isSelected, bool isHovering) {
    if (isSelected) {
      return lightColorScheme.primary;
    } else {
      if (isHovering) {
        return lightColorScheme.primaryContainer;
      } else {
        return lightColorScheme.surfaceContainerHighest;
      }
    }
  }

  static Color textColor(bool isSelected, bool isHovering) {
    if (isSelected) {
      return lightColorScheme.onPrimary;
    } else {
      if (isHovering) {
        return lightColorScheme.onPrimaryContainer;
      } else {
        return lightColorScheme.onSurface;
      }
    }
  }

  static Color dropdownEntryColor(bool isSelected) {
    return isSelected ? lightColorScheme.primary : lightColorScheme.onPrimary;
  }
}
