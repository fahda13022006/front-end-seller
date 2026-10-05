import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';
import 'package:frontend_seller/core/theme/app_text_styles.dart';
import 'package:frontend_seller/core/widgets/petani_tech_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(
    text: 'seller@petanitech.id',
  );

  final passwordController = TextEditingController(
    text: '12345678',
  );

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Desktop mulai 900px
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: isDesktop
          ? _buildDesktop()
          : _buildMobile(),
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    return SafeArea(
      child: Row(
        children: [
          // =====================================================
          // LEFT BRAND PANEL
          // =====================================================

          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(60),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
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
                    light: true,
                  ),

                  const Spacer(),

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 650,
                    ),
                    child: Text(
                      'Kelola toko pertanian\ndalam satu dashboard.',
                      style: AppTextStyles.display.copyWith(
                        color: Colors.white,
                        fontSize: 44,
                        height: 1.22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Produk, pesanan, toko, dan laporan penjualan '
                    'seller Petani Tech.',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.white.withValues(
                        alpha: 0.88,
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),

          // =====================================================
          // RIGHT LOGIN
          // =====================================================

          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: _buildLoginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        22,
        20,
        32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            
          ),

            // ===================================================
            // HERO MOBILE
            // Kelola toko tetap muncul di HP
            // ===================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primaryLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Dekorasi lingkaran
                  Positioned(
                    right: -35,
                    top: -40,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.08,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 25,
                    bottom: -45,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.06,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo kecil di hero
                      const PetaniTechLogo(
                        compact: true,
                        light: true,
                      ),

                      const SizedBox(height: 22),

                      Text(
                        'Kelola toko pertanian\ndalam satu dashboard.',
                        style: AppTextStyles.h1.copyWith(
                          color: Colors.white,
                          fontSize: 23,
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Produk, pesanan, toko, dan laporan '
                        'penjualan dalam satu tempat.',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white.withValues(
                            alpha: 0.88,
                          ),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ===================================================
            // LOGIN
            // ===================================================

            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOGIN FORM
  // ============================================================

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Login Seller',
          style: AppTextStyles.h1,
        ),

        const SizedBox(height: 6),

        Text(
          'Masuk untuk mengelola toko Petani Tech Anda.',
          style: AppTextStyles.bodyMuted,
        ),

        const SizedBox(height: 26),

        // EMAIL
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'seller@petanitech.id',
            prefixIcon: Icon(
              Icons.email_outlined,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // PASSWORD
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Lupa password?',
            ),
          ),
        ),

        const SizedBox(height: 8),

        // LOGIN
        FilledButton.icon(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          },
          icon: const Icon(
            Icons.login_rounded,
          ),
          label: const Text(
            'Login',
          ),
        ),

        const SizedBox(height: 22),

        // DIVIDER
        Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                'ATAU',
                style: AppTextStyles.caption,
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
          ],
        ),

        const SizedBox(height: 22),

        // GOOGLE
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Text(
            'G',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          label: const Text(
            'Login dengan Google',
          ),
        ),

        const SizedBox(height: 14),

        // REGISTER
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/register',
            );
          },
          style: TextButton.styleFrom(
            backgroundColor:
                AppColors.lightGreenBackground,
            padding: const EdgeInsets.symmetric(
              vertical: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
          ),
          child: const Text(
            'Belum punya akun? Daftar Seller',
          ),
        ),
      ],
    );
  }
}