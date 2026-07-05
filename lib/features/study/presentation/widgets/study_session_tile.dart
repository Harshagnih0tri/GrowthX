import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';

class StudySessionTile extends StatelessWidget {
  final String subject;
  final String duration;
  final String time;
  final VoidCallback? onDelete;

  const StudySessionTile({
    super.key,
    required this.subject,
    required this.duration,
    required this.time,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.surfaceBorder, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.study.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(Icons.menu_book_rounded, color: AppColors.study, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: AppTextStyles.body),
                Text(time, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(duration, style: AppTextStyles.title.copyWith(fontSize: 14)),
          if (onDelete != null) ...[
            const SizedBox(width: AppSpacing.sm),
            InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
              ),
            ),
          ],
        ],
      ),
    );
  }
}