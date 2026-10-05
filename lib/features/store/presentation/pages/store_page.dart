import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';
import 'package:frontend_seller/core/widgets/petani_tech_logo.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() =>
      _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final storeName = TextEditingController(
    text: 'Toko Tani Sejahtera',
  );

  final description = TextEditingController(
    text:
        'Menjual pupuk, benih, dan kebutuhan pertanian pilihan.',
  );

  final address = TextEditingController(
    text: 'Indramayu, Jawa Barat',
  );

  @override
  void dispose() {
    storeName.dispose();
    description.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobile =
        MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Toko',
          style: AppTextStyles.h2,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          mobile ? 16 : 24,
          12,
          mobile ? 16 : 24,
          30,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 760,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                if (mobile)
                  _buildContent()
                else
                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(24),
                      child: _buildContent(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        const Center(
          child: PetaniTechLogo(),
        ),

        const SizedBox(height: 28),

        Text(
          'Informasi Toko',
          style: AppTextStyles.h2,
        ),

        const SizedBox(height: 6),

        Text(
          'Informasi ini akan ditampilkan pada toko Petani Tech Anda.',
          style: AppTextStyles.bodyMuted,
        ),

        const SizedBox(height: 20),

        TextField(
          controller: storeName,
          decoration:
              const InputDecoration(
            labelText: 'Nama Toko',
            prefixIcon:
                Icon(Icons.store_outlined),
          ),
        ),

        const SizedBox(height: 14),

        TextField(
          controller: description,
          maxLines: 4,
          decoration:
              const InputDecoration(
            labelText: 'Deskripsi Toko',
            alignLabelWithHint: true,
            prefixIcon:
                Icon(Icons.notes_rounded),
          ),
        ),

        const SizedBox(height: 14),

        TextField(
          controller: address,
          maxLines: 2,
          decoration:
              const InputDecoration(
            labelText: 'Alamat Toko',
            prefixIcon:
                Icon(Icons.location_on_outlined),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding:
              const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color:
                AppColors.lightGreenBackground,
            borderRadius:
                BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seller Terverifikasi',
                      style: AppTextStyles
                          .bodySemiBold
                          .copyWith(
                        color:
                            AppColors.primaryDark,
                      ),
                    ),
                    Text(
                      'Akun toko telah diverifikasi oleh admin.',
                      style:
                          AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Informasi toko berhasil disimpan.',
                ),
              ),
            );
          },
          icon:
              const Icon(Icons.save_outlined),
          label:
              const Text('Simpan Perubahan'),
        ),
      ],
    );
  }
}