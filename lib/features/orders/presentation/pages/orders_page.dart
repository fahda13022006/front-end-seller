import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String filter = 'Semua';

  final List<_Order> orders = [
    _Order(
      '#PT-10231',
      'Budi Santoso',
      '2 Produk',
      'Rp 320.000',
      'Perlu Diproses',
    ),
    _Order(
      '#PT-10230',
      'Dewi Lestari',
      '1 Produk',
      'Rp 185.000',
      'Dikemas',
    ),
    _Order(
      '#PT-10229',
      'Rizal Akbar',
      '4 Produk',
      'Rp 540.000',
      'Dikirim',
    ),
    _Order(
      '#PT-10228',
      'Siti Aminah',
      '3 Produk',
      'Rp 276.000',
      'Selesai',
    ),
  ];

  bool _isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 700;

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    final shown = filter == 'Semua'
        ? orders
        : orders
            .where(
              (order) => order.status == filter,
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: AppTextStyles.h2,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 58,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              children: [
                'Semua',
                'Perlu Diproses',
                'Dikemas',
                'Dikirim',
                'Selesai',
              ].map(
                (item) {
                  final selected =
                      filter == item;

                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: selected,
                      selectedColor:
                          AppColors.lightGreenBackground,
                      side: BorderSide(
                        color: selected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                      labelStyle:
                          AppTextStyles.bodyMedium.copyWith(
                        color: selected
                            ? AppColors.primary
                            : AppColors.textDark,
                      ),
                      onSelected: (_) {
                        setState(() {
                          filter = item;
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ),

          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 1000),
                child: shown.isEmpty
                    ? const _EmptyOrders()
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          isMobile ? 16 : 24,
                          8,
                          isMobile ? 16 : 24,
                          30,
                        ),
                        itemCount: shown.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order =
                              shown[index];

                          return _OrderCard(
                            order: order,
                            onChangeStatus: () {
                              _showStatusSheet(
                                order,
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusSheet(
    _Order order,
  ) {
    const statuses = [
      'Perlu Diproses',
      'Dikemas',
      'Dikirim',
      'Selesai',
    ];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              4,
              16,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ubah Status Pesanan',
                    style: AppTextStyles.h2,
                  ),
                ),

                const SizedBox(height: 12),

                ...statuses.map(
                  (status) {
                    final selected =
                        order.status == status;

                    return ListTile(
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      leading: Icon(
                        selected
                            ? Icons
                                .radio_button_checked_rounded
                            : Icons
                                .radio_button_off_rounded,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textGrey,
                      ),
                      title: Text(status),
                      onTap: () {
                        setState(() {
                          order.status = status;
                        });

                        Navigator.pop(
                          sheetContext,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.onChangeStatus,
  });

  final _Order order;
  final VoidCallback onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        AppColors.lightGreenBackground,
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.id,
                        style:
                            AppTextStyles.bodySemiBold,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.customer,
                        style:
                            AppTextStyles.bodyMuted,
                      ),
                    ],
                  ),
                ),

                _StatusBadge(
                  order.status,
                ),
              ],
            ),

            const SizedBox(height: 14),

            const Divider(),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    label: 'Jumlah',
                    value: order.items,
                  ),
                ),

                Expanded(
                  child: _InfoItem(
                    label: 'Total',
                    value: order.total,
                  ),
                ),

                OutlinedButton(
                  onPressed: onChangeStatus,
                  child: const Text(
                    'Ubah Status',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(
    this.status,
  );

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status) {
      case 'Dikirim':
        color = AppColors.info;
        break;

      case 'Selesai':
        color = AppColors.success;
        break;

      case 'Dikemas':
        color = AppColors.warning;
        break;

      default:
        color = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius:
            BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontSize: 9,
        ),
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Belum ada pesanan.',
        style: AppTextStyles.bodyMuted,
      ),
    );
  }
}

class _Order {
  _Order(
    this.id,
    this.customer,
    this.items,
    this.total,
    this.status,
  );

  final String id;
  final String customer;
  final String items;
  final String total;
  String status;
}