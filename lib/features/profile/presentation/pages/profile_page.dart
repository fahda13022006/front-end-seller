import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();

  Uint8List? _profileImageBytes;
  String? _profileImageName;

  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      if (pickedFile == null) return;

      final bytes = await pickedFile.readAsBytes();

      if (!mounted) return;

      setState(() {
        _profileImageBytes = bytes;
        _profileImageName = pickedFile.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto profil berhasil diperbarui.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih foto profil.'),
        ),
      );
    }
  }

  void _removeProfileImage() {
    setState(() {
      _profileImageBytes = null;
      _profileImageName = null;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Foto profil berhasil dihapus.'),
      ),
    );
  }

  void _showProfilePhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    'Foto Profil',
                    style: AppTextStyles.h2,
                  ),
                ),

                const SizedBox(height: 6),

                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenBackground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(
                    _profileImageBytes == null
                        ? 'Pilih Foto'
                        : 'Ganti Foto',
                    style: AppTextStyles.bodySemiBold,
                  ),
                  subtitle: Text(
                    'Pilih gambar dari perangkat',
                    style: AppTextStyles.bodyMuted,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _pickProfileImage();
                  },
                ),

                if (_profileImageBytes != null) ...[
                  const SizedBox(height: 6),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    leading: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.danger.withValues(
                          alpha: 0.10,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.danger,
                      ),
                    ),
                    title: Text(
                      'Hapus Foto',
                      style: AppTextStyles.bodySemiBold.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                    subtitle: Text(
                      'Gunakan foto profil bawaan',
                      style: AppTextStyles.bodyMuted,
                    ),
                    onTap: _removeProfileImage,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 700;

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
            constraints: const BoxConstraints(
              maxWidth: 680,
            ),
            child: Column(
              children: [
                // =====================================
                // FOTO PROFIL
                // =====================================

                GestureDetector(
                  onTap: _showProfilePhotoOptions,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightGreenBackground,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.08,
                              ),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _profileImageBytes != null
                              ? Image.memory(
                                  _profileImageBytes!,
                                  width: 104,
                                  height: 104,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.person_rounded,
                                  size: 54,
                                  color: AppColors.primary,
                                ),
                        ),
                      ),

                      // Tombol edit foto
                      Positioned(
                        right: -2,
                        bottom: 2,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                TextButton.icon(
                  onPressed: _showProfilePhotoOptions,
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                  ),
                  label: Text(
                    _profileImageBytes == null
                        ? 'Tambah Foto Profil'
                        : 'Ubah Foto Profil',
                  ),
                ),

                if (_profileImageName != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Text(
                      _profileImageName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption,
                    ),
                  ),

                const SizedBox(height: 4),

                // =====================================
                // NAMA SELLER
                // =====================================

                Text(
                  'Fahda Febriya',
                  style: AppTextStyles.h2,
                ),

                const SizedBox(height: 3),

                Text(
                  'seller@petanitech.id',
                  style: AppTextStyles.bodyMuted,
                ),

                const SizedBox(height: 10),

                // =====================================
                // STATUS VERIFIKASI
                // =====================================

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenBackground,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Seller Terverifikasi',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // =====================================
                // MENU PROFIL
                // =====================================

                Card(
                  child: Column(
                    children: [
                      _ProfileMenu(
                        icon: Icons.person_outline_rounded,
                        title: 'Informasi Akun',
                        subtitle: 'Nama, email, dan data seller',
                        onTap: () {
                          _showAccountInformation();
                        },
                      ),

                      const Divider(),

                      _ProfileMenu(
                        icon: Icons.verified_user_outlined,
                        title: 'Verifikasi Seller',
                        subtitle: 'Akun telah diverifikasi admin',
                        trailing: const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                        ),
                        onTap: () {},
                      ),

                      const Divider(),

                      _ProfileMenu(
                        icon: Icons.security_outlined,
                        title: 'Keamanan Akun',
                        subtitle:
                            'Ubah password dan keamanan login',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // =====================================
                // LOGOUT
                // =====================================

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login',
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.danger,
                      side: const BorderSide(
                        color: AppColors.danger,
                      ),
                    ),
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    label: const Text('Keluar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INFORMASI AKUN
  // ============================================================

  void _showAccountInformation() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Akun',
                  style: AppTextStyles.h2,
                ),

                const SizedBox(height: 20),

                _AccountInfoRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Nama',
                  value: 'Fahda Febriya',
                ),

                const Divider(),

                _AccountInfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: 'seller@petanitech.id',
                ),

                const Divider(),

                _AccountInfoRow(
                  icon: Icons.storefront_outlined,
                  label: 'Tipe Akun',
                  value: 'Seller',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// PROFILE MENU
// ============================================================

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
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.lightGreenBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodySemiBold,
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

// ============================================================
// ACCOUNT INFO
// ============================================================

class _AccountInfoRow extends StatelessWidget {
  const _AccountInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.lightGreenBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 21,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}