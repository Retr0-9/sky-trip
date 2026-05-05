import 'package:flutter/material.dart';

/// A styled text field used across booking, passengers, and payment screens.
/// Automatically adapts to light/dark theme.
class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final bool isRequired;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // get current theme
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onBackground, 
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: colorScheme.error),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Field
        GestureDetector(
          onTap: readOnly ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: colorScheme.surface, 
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outline), 
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: colorScheme.primary, size: 20), 
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    hint,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6), 
                    ),
                  ),
                ),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}