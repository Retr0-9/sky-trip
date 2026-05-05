import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  SkyTrip Design System
// ─────────────────────────────────────────────────────────

class AppTheme {
  static ThemeData get lightTheme => _buildLightTheme();
  static ThemeData get darkTheme => _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        primary: AppColors.cyan,
        onPrimary: Colors.white,
        secondary: AppColors.orange,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.gradientTop.withOpacity(0.85),
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.cyan,
        unselectedItemColor: AppColors.textHint,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.md,
          side: BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyan, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        space: 1,
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cyanLight,
        labelStyle: const TextStyle(color: AppColors.cyanDark, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.full),
        side: BorderSide.none,
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    // Dark mode colors
    const darkBg = Color(0xFF1A1A1A);
    const darkSurface = Color(0xFF242424);
    const darkBorder = Color(0xFF3A3A3A);
    const darkTextPrimary = Color(0xFFE8E8E8);
    const darkTextSecondary = Color(0xFFB0B0B0);
    const darkTextHint = Color(0xFF808080);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        brightness: Brightness.dark,
        primary: AppColors.cyan,
        onPrimary: Colors.white,
        secondary: AppColors.orange,
        surface: darkSurface,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: darkBorder,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700,
          color: darkTextPrimary,
        ),
        iconTheme: const IconThemeData(color: darkTextPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: AppColors.cyan,
        unselectedItemColor: darkTextHint,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: const CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.md,
          side: BorderSide(color: darkBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkTextPrimary,
          side: const BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyan, width: 2),
        ),
        hintStyle: const TextStyle(color: darkTextHint, fontSize: 14),
        labelStyle: const TextStyle(color: darkTextSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        space: 1,
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cyan.withOpacity(0.2),
        labelStyle: const TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.full),
        side: BorderSide.none,
      ),
    );
  }
}
class AppColors {
  // Primary — softer cyan to match the screenshot palette
  static const cyan       = Color(0xFF5BB8C8);
  static const cyanLight  = Color(0xFFDFF2F7);
  static const cyanDark   = Color(0xFF3A8FA0);

  // Accent
  static const orange     = Color(0xFFFF7043);
  static const green      = Color(0xFF26A69A);
  static const purple     = Color(0xFF7C4DFF);
  static const gold       = Color(0xFFFFB300);

  // Neutrals
  static const bg         = Color(0xFFF5F0EB);  // warm cream (screenshot top)
  static const surface    = Colors.white;
  static const border     = Color(0xFFE2D9D0);
  static const textPrimary   = Color(0xFF2C2C2E);
  static const textSecondary = Color(0xFF6B7280);
  static const textHint      = Color(0xFFB0B8C4);

  // Status
  static const success    = Color(0xFF00C896);
  static const warning    = Color(0xFFFFA726);
  static const error      = Color(0xFFEF5350);
  static const cancelled  = Color(0xFFEF5350);
  static const upcoming   = Color(0xFF5BB8C8);
  static const completed  = Color(0xFF26A69A);

  // ── App gradient: warm cream top → soft sky-blue bottom ──
  static const gradientTop    = Color(0xFFF5F0EB);
  static const gradientMid    = Color(0xFFDEEFF5);
  static const gradientBottom = Color(0xFFB5D9E8);
}

class AppTextStyles {
  static const displayLarge = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w800,
    color: AppColors.textPrimary, letterSpacing: -0.5, height: 1.2,
  );
  static const displayMedium = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary, letterSpacing: -0.3,
  );
  static const titleLarge = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static const titleMedium = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const titleSmall = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400,
    color: AppColors.textPrimary, height: 1.5,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400,
    color: AppColors.textPrimary, height: 1.5,
  );
  static const bodySmall = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  static const labelLarge = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: AppColors.textSecondary, letterSpacing: 0.3,
  );
  static const price = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w800,
    color: AppColors.cyan, letterSpacing: -0.5,
  );
}

class AppRadius {
  static const sm   = BorderRadius.all(Radius.circular(8));
  static const md   = BorderRadius.all(Radius.circular(12));
  static const lg   = BorderRadius.all(Radius.circular(16));
  static const xl   = BorderRadius.all(Radius.circular(24));
  static const full = BorderRadius.all(Radius.circular(999));
}

class AppShadows {
  static const sm = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2)),
  ];
  static const md = [
    BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
  static const lg = [
    BoxShadow(color: Color(0x12000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
  static const card = [
    BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
    BoxShadow(color: Color(0x05000000), blurRadius: 2, offset: Offset(0, 1)),
  ];
}

// ─────────────────────────────────────────────────────────
//  Gradient Background Wrapper
//  Wrap any screen's Scaffold in this to get the gradient
// ─────────────────────────────────────────────────────────

class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.45, 1.0],
          colors: isDark
              ? const [
                  Color(0xFF1A1A1A),    // dark bg top
                  Color(0xFF242424),    // dark mid
                  Color(0xFF2A3A4A),    // dark bottom (slight blue tint)
                ]
              : const [
                  AppColors.gradientTop,    // warm cream
                  AppColors.gradientMid,    // pale sky
                  AppColors.gradientBottom, // soft cyan-blue
                ],
        ),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────
//  Shared UI Components
// ─────────────────────────────────────────────────────────

/// Polished section card container
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;

  const AppCard({super.key, required this.child, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = color ?? (isDark ? const Color(0xFF242424) : AppColors.surface);
    final borderColor = isDark ? const Color(0xFF3A3A3A) : AppColors.border;
    
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.md,
        border: Border.all(color: borderColor),
        boxShadow: AppShadows.card,
      ),
      child: child,
    );
  }
}

/// Polished settings/list tile row
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? const Color(0xFFE8E8E8) : AppColors.textPrimary;
    final secondaryTextColor = isDark ? const Color(0xFFB0B0B0) : AppColors.textSecondary;
    final dividerColor = isDark ? const Color(0xFF3A3A3A) : AppColors.border;
    
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: AppRadius.sm,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppColors.cyan).withOpacity(0.1),
                    borderRadius: AppRadius.sm,
                  ),
                  child: Icon(icon, color: iconColor ?? AppColors.cyan, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ?? Icon(Icons.chevron_right,
                    color: secondaryTextColor, size: 20),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: dividerColor, indent: 52),
      ],
    );
  }
}

/// Section header used in settings, profile, etc.
class AppSectionLabel extends StatelessWidget {
  final String label;
  const AppSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? const Color(0xFFB0B0B0) : AppColors.textSecondary;
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w700,
          color: textColor, letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// Polished price tag badge
class PriceBadge extends StatelessWidget {
  final String amount;
  final String? label;
  const PriceBadge({super.key, required this.amount, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(amount, style: AppTextStyles.price),
        if (label != null) Text(label!, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
