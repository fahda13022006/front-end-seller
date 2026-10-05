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
    final foreground = light ? Colors.white : AppColors.primary;
    final titleColor = light ? Colors.white : AppColors.textDark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 40 : 58,
          height: compact ? 40 : 58,
          decoration: BoxDecoration(
            color: light ? Colors.white.withOpacity(.16) : AppColors.lightGreenBackground,
            borderRadius: BorderRadius.circular(compact ? 13 : 18),
          ),
          child: Icon(
            Icons.eco_rounded,
            color: foreground,
            size: compact ? 26 : 38,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Petani Tech',
              style: AppTextStyles.h2.copyWith(color: titleColor),
            ),
            if (!compact)
              Text(
                'Seller Center',
                style: AppTextStyles.caption.copyWith(
                  color: light ? Colors.white70 : AppColors.textGrey,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
