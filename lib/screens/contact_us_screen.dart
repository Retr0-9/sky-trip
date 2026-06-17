import 'package:flutter/material.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n  = AppLocalizations.of(context)!;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.contactUsTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Contact channels
              AppSectionLabel(label: l10n.contactGetInTouch),
              AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  SettingsTile(
                    icon: Icons.phone_outlined,
                    iconColor: AppColors.green,
                    title: 'Call Us',
                    subtitle: '+962 6 510 0000',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.contactOpening('dialer')),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                  SettingsTile(
                    icon: Icons.email_outlined,
                    iconColor: AppColors.cyan,
                    title: 'Email Us',
                    subtitle: 'support@skytrip.com',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.contactOpening('email')),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                  SettingsTile(
                    icon: Icons.chat_bubble_outline,
                    iconColor: AppColors.purple,
                    title: 'Live Chat',
                    subtitle: 'Available 24/7',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.contactComing),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                    ),
                    showDivider: false,
                  ),
                ]),
              ),

              // FAQ
              AppSectionLabel(label: l10n.contactFaq),
              ..._faqs.map((faq) => _buildFaqTile(context, faq)),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, Map<String, String> faq) {
    final theme = Theme.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(faq['q']!, style: theme.textTheme.titleSmall),
        iconColor: AppColors.cyan,
        children: [
          Text(faq['a']!, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  static const _faqs = [
    {
      'q': 'How do I cancel a booking?',
      'a': 'Go to Tickets → select your booking → tap Cancel. Refunds are processed within 5–7 business days.',
    },
    {
      'q': 'Can I change my flight date?',
      'a': 'Yes. Select your ticket, tap Change Date, and choose a new flight. Fees may apply depending on fare class.',
    },
    {
      'q': 'What is the baggage allowance?',
      'a': 'Economy: 1 carry-on (7kg) + 1 checked bag (23kg). Business: 1 carry-on (10kg) + 2 checked bags (32kg each).',
    },
    {
      'q': 'How do I earn loyalty miles?',
      'a': 'Miles are automatically credited 48 hours after your flight. 1 mile earned per 1 JOD spent on flights.',
    },
  ];
}
