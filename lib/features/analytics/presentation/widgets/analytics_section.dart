import 'package:flutter/material.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../core/theme/app_spacing.dart';

class AnalyticsSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const AnalyticsSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, trailing: trailing),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    );
  }
}