import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';

class SalesReportPage extends StatelessWidget {
  const SalesReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sales = [
      42.0,
      58.0,
      50.0,
      76.0,
      64.0,
      88.0,
      72.0,
    ];

    const days = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ];

    final mobile =
        MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Laporan',
          style: AppTextStyles.h2,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 1300,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              mobile ? 16 : 24,
              12,
              mobile ? 16 : 24,
              30,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                if (mobile)
                  SizedBox(
                    height: 128,
                    child: ListView(
                      scrollDirection:
                          Axis.horizontal,
                      children: const [
                        SizedBox(
                          width: 230,
                          child: _ReportCard(
                            'Omzet Bulan Ini',
                            'Rp 18.750.000',
                            '+15,8%',
                            Icons
                                .trending_up_rounded,
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 210,
                          child: _ReportCard(
                            'Total Pesanan',
                            '148',
                            '+9,4%',
                            Icons
                                .shopping_cart_outlined,
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 210,
                          child: _ReportCard(
                            'Produk Terjual',
                            '326',
                            '+11,2%',
                            Icons
                                .inventory_outlined,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Row(
                    children: [
                      Expanded(
                        child: _ReportCard(
                          'Omzet Bulan Ini',
                          'Rp 18.750.000',
                          '+15,8%',
                          Icons
                              .trending_up_rounded,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _ReportCard(
                          'Total Pesanan',
                          '148',
                          '+9,4%',
                          Icons
                              .shopping_cart_outlined,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _ReportCard(
                          'Produk Terjual',
                          '326',
                          '+11,2%',
                          Icons
                              .inventory_outlined,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),

                Text(
                  'Penjualan 7 Hari Terakhir',
                  style: AppTextStyles.h2,
                ),

                const SizedBox(height: 12),

                Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      mobile ? 10 : 20,
                      22,
                      mobile ? 10 : 20,
                      14,
                    ),
                    child: SizedBox(
                      height:
                          mobile ? 200 : 260,
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children:
                            List.generate(
                          sales.length,
                          (index) {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 3,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .end,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            Alignment
                                                .bottomCenter,
                                        child:
                                            FractionallySizedBox(
                                          heightFactor:
                                              sales[index] /
                                                  100,
                                          widthFactor:
                                              mobile
                                                  ? .65
                                                  : .55,
                                          child:
                                              DecoratedBox(
                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  AppColors
                                                      .primaryLight,
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      days[index],
                                      style:
                                          AppTextStyles
                                              .caption,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Produk Terlaris',
                  style: AppTextStyles.h2,
                ),

                const SizedBox(height: 12),

                const Card(
                  child: Column(
                    children: [
                      _BestProduct(
                        rank: 1,
                        name:
                            'Pupuk Organik 10 Kg',
                        sold: '86 terjual',
                      ),
                      Divider(),
                      _BestProduct(
                        rank: 2,
                        name:
                            'Benih Jagung Hibrida',
                        sold: '64 terjual',
                      ),
                      Divider(),
                      _BestProduct(
                        rank: 3,
                        name:
                            'Pestisida Nabati 1 L',
                        sold: '48 terjual',
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

class _ReportCard extends StatelessWidget {
  const _ReportCard(
    this.title,
    this.value,
    this.growth,
    this.icon,
  );

  final String title;
  final String value;
  final String growth;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color:
                    AppColors.lightGreenBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        AppTextStyles.bodyMuted,
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment:
                        Alignment.centerLeft,
                    child: Text(
                      value,
                      style:
                          AppTextStyles.h3,
                    ),
                  ),
                  Text(
                    growth,
                    style: AppTextStyles
                        .caption
                        .copyWith(
                      color:
                          AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BestProduct extends StatelessWidget {
  const _BestProduct({
    required this.rank,
    required this.name,
    required this.sold,
  });

  final int rank;
  final String name;
  final String sold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  AppColors.lightGreenBackground,
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Text(
              '$rank',
              style: AppTextStyles
                  .bodySemiBold
                  .copyWith(
                color:
                    AppColors.primary,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              name,
              style:
                  AppTextStyles.bodyMedium,
            ),
          ),

          Text(
            sold,
            style:
                AppTextStyles.bodyMuted,
          ),
        ],
      ),
    );
  }
}