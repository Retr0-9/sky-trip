import 'package:flutter/material.dart';

/// A styled text field used across booking, passengers, and payment screens.
/// Usage: CustomTextField(label: 'First Name', hint: 'As shown in passport')
/// With icon: CustomTextField(label: 'Email', hint: '', icon: Icons.email)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.cyan.shade300, size: 20),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    hint,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
