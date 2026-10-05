import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyles.h2,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          mobile ? 16 : 24,
          16,
          mobile ? 16 : 24,
          30,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 680,
            ),
            child: Column(
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration:
                      const BoxDecoration(
                    color: AppColors
                        .lightGreenBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Fahda Febriya',
                  style: AppTextStyles.h2,
                ),

                const SizedBox(height: 3),

                Text(
                  'seller@petanitech.id',
                  style:
                      AppTextStyles.bodyMuted,
                ),

                const SizedBox(height: 8),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration:
                      BoxDecoration(
                    color: AppColors
                        .lightGreenBackground,
                    borderRadius:
                        BorderRadius.circular(
                      999,
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons
                            .verified_rounded,
                        size: 16,
                        color:
                            AppColors.primary,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Seller Terverifikasi',
                        style: AppTextStyles
                            .caption
                            .copyWith(
                          color:
                              AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Card(
                  child: Column(
                    children: [
                      _ProfileMenu(
                        icon:
                            Icons.person_outline,
                        title:
                            'Informasi Akun',
                        subtitle:
                            'Nama, email, dan data seller',
                        onTap: () {},
                      ),

                      const Divider(),

                      _ProfileMenu(
                        icon: Icons
                            .verified_user_outlined,
                        title:
                            'Verifikasi Seller',
                        subtitle:
                            'Akun telah diverifikasi admin',
                        trailing: const Icon(
                          Icons
                              .check_circle_rounded,
                          color:
                              AppColors.success,
                        ),
                        onTap: () {},
                      ),

                      const Divider(),

                      _ProfileMenu(
                        icon:
                            Icons.security_outlined,
                        title:
                            'Keamanan Akun',
                        subtitle:
                            'Ubah password dan keamanan login',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child:
                      OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                        '/login',
                        (route) => false,
                      );
                    },
                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          AppColors.danger,
                      side: const BorderSide(
                        color:
                            AppColors.danger,
                      ),
                    ),
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    label:
                        const Text('Keluar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color:
              AppColors.lightGreenBackground,
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style:
            AppTextStyles.bodySemiBold,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodyMuted,
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right_rounded,
          ),
    );
  }
}