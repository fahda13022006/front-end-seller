import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ImagePicker _imagePicker = ImagePicker();

  final List<_Product> products = [
    _Product(
      name: 'Pupuk Organik 10 Kg',
      category: 'Pupuk',
      price: 85000,
      stock: 24,
      active: true,
    ),
    _Product(
      name: 'Benih Jagung Hibrida',
      category: 'Benih',
      price: 72000,
      stock: 8,
      active: true,
    ),
    _Product(
      name: 'Pestisida Nabati 1 L',
      category: 'Perawatan',
      price: 55000,
      stock: 10,
      active: true,
    ),
  ];

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
          'Produk',
          style: AppTextStyles.h2,
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        // Desktop / tablet tombol tambah di AppBar.
        actions: !isMobile
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: FilledButton.icon(
                    onPressed: () => _showProductForm(),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Tambah Produk'),
                  ),
                ),
              ]
            : null,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1100,
          ),
          child: products.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 16 : 24,
                    isMobile ? 12 : 20,
                    isMobile ? 16 : 24,
                    isMobile ? 110 : 30,
                  ),
                  itemCount: products.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    if (isMobile) {
                      return _buildMobileProductCard(
                        product,
                        index,
                      );
                    }

                    return _buildDesktopProductCard(
                      product,
                      index,
                    );
                  },
                ),
        ),
      ),

      // Mobile: tombol tambah selalu terlihat.
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              onPressed: () => _showProductForm(),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Tambah',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }

  // ============================================================
  // MOBILE PRODUCT CARD
  // ============================================================

  Widget _buildMobileProductCard(
    _Product product,
    int index,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(
                  product,
                  size: 92,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h3,
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '${product.category} • Stok ${product.stock}',
                          style: AppTextStyles.bodyMuted,
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Rp ${_formatPrice(product.price)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Divider(
              height: 1,
              color: AppColors.divider,
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    value: product.active,
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        product.active = value;
                      });
                    },
                  ),
                ),

                Text(
                  product.active ? 'Aktif' : 'Nonaktif',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: product.active
                        ? AppColors.primary
                        : AppColors.textGrey,
                  ),
                ),

                const Spacer(),

                TextButton.icon(
                  onPressed: () {
                    _showProductForm(
                      product: product,
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 19,
                  ),
                  label: const Text('Edit'),
                ),

                const SizedBox(width: 2),

                TextButton.icon(
                  onPressed: () {
                    _confirmDelete(
                      index,
                      product,
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                  ),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 19,
                  ),
                  label: const Text('Hapus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP PRODUCT CARD
  // ============================================================

  Widget _buildDesktopProductCard(
    _Product product,
    int index,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildProductImage(
              product,
              size: 84,
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.h3,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${product.category} • Stok ${product.stock}',
                    style: AppTextStyles.bodyMuted,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Rp ${_formatPrice(product.price)}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Switch(
              value: product.active,
              onChanged: (value) {
                setState(() {
                  product.active = value;
                });
              },
            ),

            const SizedBox(width: 10),

            OutlinedButton.icon(
              onPressed: () {
                _showProductForm(
                  product: product,
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
              ),
              label: const Text('Edit'),
            ),

            const SizedBox(width: 8),

            IconButton(
              tooltip: 'Hapus produk',
              onPressed: () {
                _confirmDelete(
                  index,
                  product,
                );
              },
              color: Colors.red.shade600,
              icon: const Icon(
                Icons.delete_outline_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Widget _buildProductImage(
    _Product product, {
    required double size,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: size,
        height: size,
        color: AppColors.lightGreenBackground,
        child: product.imageBytes != null
            ? Image.memory(
                product.imageBytes!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              )
            : const Center(
                child: Icon(
                  Icons.eco_rounded,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),
      ),
    );
  }

  // ============================================================
  // TAMBAH / EDIT PRODUK
  // ============================================================

  Future<void> _showProductForm({
    _Product? product,
  }) async {
    final isEditing = product != null;

    final nameController = TextEditingController(
      text: product?.name ?? '',
    );

    final categoryController = TextEditingController(
      text: product?.category ?? '',
    );

    final priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );

    final stockController = TextEditingController(
      text: product?.stock.toString() ?? '',
    );

    Uint8List? selectedImage = product?.imageBytes;
    String? selectedImageName = product?.imageName;

    Future<void> pickImage(
      StateSetter modalSetState,
    ) async {
      try {
        final XFile? pickedFile =
            await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxWidth: 1600,
        );

        if (pickedFile == null) {
          return;
        }

        final bytes = await pickedFile.readAsBytes();

        modalSetState(() {
          selectedImage = bytes;
          selectedImageName = pickedFile.name;
        });
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Gagal memilih gambar.',
            ),
          ),
        );
      }
    }

    void saveProduct(
      BuildContext modalContext,
    ) {
      final productName = nameController.text.trim();
      final category = categoryController.text.trim();
      final price =
          int.tryParse(priceController.text.trim()) ?? 0;
      final stock =
          int.tryParse(stockController.text.trim()) ?? 0;

      if (productName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Nama produk wajib diisi.',
            ),
          ),
        );
        return;
      }

      if (category.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Kategori produk wajib diisi.',
            ),
          ),
        );
        return;
      }

      setState(() {
        if (product == null) {
          products.insert(
            0,
            _Product(
              name: productName,
              category: category,
              price: price,
              stock: stock,
              active: true,
              imageBytes: selectedImage,
              imageName: selectedImageName,
            ),
          );
        } else {
          product
            ..name = productName
            ..category = category
            ..price = price
            ..stock = stock
            ..imageBytes = selectedImage
            ..imageName = selectedImageName;
        }
      });

      Navigator.pop(modalContext);
    }

    Widget buildForm(
      BuildContext modalContext,
      StateSetter modalSetState,
    ) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          // ==========================
          // FOTO PRODUK
          // ==========================

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 190,
              color: AppColors.lightGreenBackground,
              child: selectedImage != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),

                        Positioned(
                          right: 10,
                          top: 10,
                          child: IconButton.filled(
                            onPressed: () {
                              modalSetState(() {
                                selectedImage = null;
                                selectedImageName = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 50,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tambahkan Foto Produk',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: () {
              pickImage(modalSetState);
            },
            icon: const Icon(
              Icons.photo_library_outlined,
            ),
            label: Text(
              selectedImage == null
                  ? 'Pilih Gambar'
                  : 'Ganti Gambar',
            ),
          ),

          if (selectedImageName != null) ...[
            const SizedBox(height: 5),
            Text(
              selectedImageName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMuted,
            ),
          ],

          const SizedBox(height: 18),

          // ==========================
          // FORM DATA
          // ==========================

          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Nama Produk',
              prefixIcon: Icon(
                Icons.inventory_2_outlined,
              ),
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: categoryController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Kategori',
              prefixIcon: Icon(
                Icons.category_outlined,
              ),
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Harga',
              prefixText: 'Rp ',
              prefixIcon: Icon(
                Icons.payments_outlined,
              ),
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            controller: stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Stok',
              prefixIcon: Icon(
                Icons.inventory_outlined,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(modalContext);
                  },
                  child: const Text('Batal'),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    saveProduct(modalContext);
                  },
                  icon: Icon(
                    isEditing
                        ? Icons.save_outlined
                        : Icons.add_rounded,
                  ),
                  label: Text(
                    isEditing
                        ? 'Simpan'
                        : 'Tambah Produk',
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    if (_isMobile(context)) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        builder: (sheetContext) {
          return StatefulBuilder(
            builder: (
              context,
              modalSetState,
            ) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  MediaQuery.viewInsetsOf(context)
                          .bottom +
                      24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 45,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        isEditing
                            ? 'Edit Produk'
                            : 'Tambah Produk',
                        style: AppTextStyles.h2,
                      ),

                      const SizedBox(height: 20),

                      buildForm(
                        sheetContext,
                        modalSetState,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (
              context,
              modalSetState,
            ) {
              return AlertDialog(
                title: Text(
                  isEditing
                      ? 'Edit Produk'
                      : 'Tambah Produk',
                ),
                content: SizedBox(
                  width: 500,
                  child: SingleChildScrollView(
                    child: buildForm(
                      dialogContext,
                      modalSetState,
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    stockController.dispose();
  }

  // ============================================================
  // DELETE
  // ============================================================

  Future<void> _confirmDelete(
    int index,
    _Product product,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red.shade600,
            size: 34,
          ),
          title: const Text(
            'Hapus Produk?',
          ),
          content: Text(
            'Produk "${product.name}" akan dihapus dari toko.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor:
                    Colors.red.shade600,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      setState(() {
        products.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${product.name} berhasil dihapus.',
          ),
        ),
      );
    }
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color:
                    AppColors.lightGreenBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 42,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'Belum ada produk',
              style: AppTextStyles.h2,
            ),

            const SizedBox(height: 8),

            Text(
              'Tambahkan produk pertama untuk mulai berjualan.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMuted,
            ),

            const SizedBox(height: 18),

            FilledButton.icon(
              onPressed: () {
                _showProductForm();
              },
              icon: const Icon(
                Icons.add_rounded,
              ),
              label: const Text(
                'Tambah Produk',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int value) {
    final text = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      final position = text.length - i;

      buffer.write(text[i]);

      if (position > 1 &&
          position % 3 == 1) {
        buffer.write('.');
      }
    }

    return buffer.toString();
  }
}

// ============================================================
// MODEL SEMENTARA
// NANTI BISA DIPINDAH KE models/product.dart
// ============================================================

class _Product {
  _Product({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.active,
    this.imageBytes,
    this.imageName,
  });

  String name;
  String category;
  int price;
  int stock;
  bool active;

  Uint8List? imageBytes;
  String? imageName;
}