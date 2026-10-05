import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final products = <_Product>[
    _Product('Pupuk Organik 10 Kg', 'Pupuk', 85000, 24, true),
    _Product('Benih Jagung Hibrida', 'Benih', 72000, 8, true),
    _Product('Pestisida Nabati 1 L', 'Perawatan', 55000, 0, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: _showProductForm,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Tambah Produk'),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: AppTextStyles.h3),
                        const SizedBox(height: 4),
                        Text('${product.category} • Stok ${product.stock}', style: AppTextStyles.bodyMuted),
                        const SizedBox(height: 6),
                        Text('Rp ${_formatPrice(product.price)}', style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  ),
                  Switch(
                    value: product.active,
                    onChanged: (value) => setState(() => product.active = value),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') _showProductForm(product: product);
                      if (value == 'delete') setState(() => products.removeAt(index));
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Hapus')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProductForm({_Product? product}) {
    final name = TextEditingController(text: product?.name ?? '');
    final category = TextEditingController(text: product?.category ?? '');
    final price = TextEditingController(text: product?.price.toString() ?? '');
    final stock = TextEditingController(text: product?.stock.toString() ?? '');

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(product == null ? 'Tambah Produk' : 'Edit Produk'),
        content: SizedBox(
          width: 460,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama produk')),
                const SizedBox(height: 12),
                TextField(controller: category, decoration: const InputDecoration(labelText: 'Kategori')),
                const SizedBox(height: 12),
                TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga')),
                const SizedBox(height: 12),
                TextField(controller: stock, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              setState(() {
                if (product == null) {
                  products.add(
                    _Product(
                      name.text,
                      category.text,
                      int.tryParse(price.text) ?? 0,
                      int.tryParse(stock.text) ?? 0,
                      true,
                    ),
                  );
                } else {
                  product
                    ..name = name.text
                    ..category = category.text
                    ..price = int.tryParse(price.text) ?? 0
                    ..stock = int.tryParse(stock.text) ?? 0;
                }
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final reverseIndex = digits.length - i;
      buffer.write(digits[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) buffer.write('.');
    }
    return buffer.toString();
  }
}

class _Product {
  _Product(this.name, this.category, this.price, this.stock, this.active);

  String name;
  String category;
  int price;
  int stock;
  bool active;
}
