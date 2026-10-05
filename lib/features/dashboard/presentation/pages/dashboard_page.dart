import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_spacing.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';
import 'package:frontend_seller/core/widgets/petani_tech_logo.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  bool _isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 700;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Dashboard Seller',
          style: AppTextStyles.h2,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1300,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 16 : 24,
              isMobile ? 12 : 20,
              isMobile ? 16 : 24,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WelcomeCard(
                  isMobile: isMobile,
                ),

                const SizedBox(height: AppSpacing.lg),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;

                    final columns = width >= 1100
                        ? 4
                        : width >= 700
                            ? 2
                            : 2;

                    final gap = isMobile ? 10.0 : 14.0;

                    final itemWidth =
                        (width - ((columns - 1) * gap)) / columns;

                    final stats = [
                      const _StatCard(
                        title: 'Penjualan Hari Ini',
                        value: 'Rp 2,45 jt',
                        note: '+12%',
                        icon: Icons.payments_outlined,
                      ),
                      const _StatCard(
                        title: 'Pesanan Baru',
                        value: '18',
                        note: '6 diproses',
                        icon: Icons.shopping_bag_outlined,
                      ),
                      const _StatCard(
                        title: 'Produk Aktif',
                        value: '42',
                        note: '3 stok tipis',
                        icon: Icons.inventory_2_outlined,
                      ),
                      const _StatCard(
                        title: 'Rating Toko',
                        value: '4.8',
                        note: '128 ulasan',
                        icon: Icons.star_outline_rounded,
                      ),
                    ];

                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: stats
                          .map(
                            (item) => SizedBox(
                              width: itemWidth,
                              child: item,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pesanan Terbaru',
                        style: AppTextStyles.h2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Lihat Semua'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Card(
                  child: Column(
                    children: const [
                      _OrderRow(
                        id: '#PT-10231',
                        customer: 'Budi Santoso',
                        total: 'Rp 320.000',
                        status: 'Perlu Diproses',
                      ),
                      Divider(),
                      _OrderRow(
                        id: '#PT-10230',
                        customer: 'Dewi Lestari',
                        total: 'Rp 185.000',
                        status: 'Dikemas',
                      ),
                      Divider(),
                      _OrderRow(
                        id: '#PT-10229',
                        customer: 'Rizal Akbar',
                        total: 'Rp 540.000',
                        status: 'Dikirim',
                      ),
                    ],
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

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 26,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryDark,
            AppColors.primaryLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PetaniTechLogo(
            compact: true,
            light: true,
          ),

          SizedBox(
            height: isMobile ? 22 : 30,
          ),

          Text(
            'Selamat datang,\nToko Tani Sejahtera!',
            style: isMobile
                ? AppTextStyles.h2.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  )
                : AppTextStyles.h1.copyWith(
                    color: Colors.white,
                  ),
          ),

          const SizedBox(height: 8),

          Text(
            'Pantau performa toko dan kelola aktivitas penjualan dari sini.',
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(
                alpha: 0.88,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String title;
  final String value;
  final String note;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < 700;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(
          mobile ? 14 : 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: mobile ? 38 : 42,
              height: mobile ? 38 : 42,
              decoration: BoxDecoration(
                color: AppColors.lightGreenBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: mobile ? 20 : 24,
              ),
            ),

            SizedBox(
              height: mobile ? 12 : 18,
            ),

            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMuted,
            ),

            const SizedBox(height: 3),

            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: mobile
                    ? AppTextStyles.h3
                    : AppTextStyles.h2,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({
    required this.id,
    required this.customer,
    required this.total,
    required this.status,
  });

  final String id;
  final String customer;
  final String total;
  final String status;

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < 700;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lightGreenBackground,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: AppTextStyles.bodySemiBold,
                ),
                const SizedBox(height: 2),
                Text(
                  customer,
                  style: AppTextStyles.bodyMuted,
                ),
                if (mobile) ...[
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                total,
                style: AppTextStyles.bodyMedium,
              ),
              if (!mobile) ...[
                const SizedBox(height: 4),
                Text(
                  status,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}