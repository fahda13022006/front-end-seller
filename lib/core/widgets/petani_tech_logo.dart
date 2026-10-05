import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PetaniTechLogo extends StatelessWidget {
  const PetaniTechLogo({
    super.key,
    this.compact = false,
    this.light = false,
  });

  final bool compact;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final textColor = light ? Colors.white : AppColors.textDark;
    final subTextColor = light
        ? Colors.white.withValues(alpha: 0.85)
        : AppColors.textGrey;

    final logoBoxColor = light
        ? Colors.white.withValues(alpha: 0.14)
        : AppColors.lightGreenBackground;

    final imageSize = compact ? 28.0 : 34.0;
    final boxSize = compact ? 46.0 : 58.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            color: logoBoxColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/petani_tech_logo.png',
            fit: BoxFit.contain,
            width: imageSize,
            height: imageSize,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Petani Tech',
              style: (compact ? AppTextStyles.h3 : AppTextStyles.h2).copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (!compact)
              Text(
                'Seller Center',
                style: AppTextStyles.bodyMuted.copyWith(
                  color: subTextColor,
                ),
              ),
            if (compact)
              Text(
                'Seller Center',
                style: AppTextStyles.caption.copyWith(
                  color: subTextColor,
                ),
              ),
          ],
        ),
      ],
    );
  }
}