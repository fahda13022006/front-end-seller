import 'package:flutter/material.dart';

import 'package:frontend_seller/core/theme/app_colors.dart';

import 'package:frontend_seller/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:frontend_seller/features/products/presentation/pages/products_page.dart';
import 'package:frontend_seller/features/orders/presentation/pages/orders_page.dart';
import 'package:frontend_seller/features/store/presentation/pages/store_page.dart';
import 'package:frontend_seller/features/reports/presentation/pages/sales_report_page.dart';
import 'package:frontend_seller/features/profile/presentation/pages/profile_page.dart';

class SellerShellPage extends StatefulWidget {
  const SellerShellPage({super.key});

  @override
  State<SellerShellPage> createState() => _SellerShellPageState();
}

enum SellerMenu {
  dashboard,
  products,
  orders,
  store,
  reports,
  profile,
}

class _SellerShellPageState extends State<SellerShellPage> {
  SellerMenu selectedMenu = SellerMenu.dashboard;

  bool get _isDesktop =>
      MediaQuery.sizeOf(context).width >= 900;

  Widget _getCurrentPage() {
    switch (selectedMenu) {
      case SellerMenu.dashboard:
        return const DashboardPage();

      case SellerMenu.products:
        return const ProductsPage();

      case SellerMenu.orders:
        return const OrdersPage();

      case SellerMenu.store:
        return const StorePage();

      case SellerMenu.reports:
        return const SalesReportPage();

      case SellerMenu.profile:
        return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDesktop) {
      return _buildDesktop();
    }

    return _buildMobile();
  }

  // =========================================================
  // MOBILE
  // =========================================================

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: _getCurrentPage(),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.divider,
                width: 0.7,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _MobileNavItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard_rounded,
                  label: 'Beranda',
                  selected:
                      selectedMenu == SellerMenu.dashboard,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.dashboard;
                    });
                  },
                ),
              ),

              Expanded(
                child: _MobileNavItem(
                  icon: Icons.inventory_2_outlined,
                  selectedIcon: Icons.inventory_2_rounded,
                  label: 'Produk',
                  selected:
                      selectedMenu == SellerMenu.products,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.products;
                    });
                  },
                ),
              ),

              Expanded(
                child: _MobileNavItem(
                  icon: Icons.receipt_long_outlined,
                  selectedIcon: Icons.receipt_long_rounded,
                  label: 'Pesanan',
                  selected:
                      selectedMenu == SellerMenu.orders,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.orders;
                    });
                  },
                ),
              ),

              Expanded(
                child: _MobileNavItem(
                  icon: Icons.storefront_outlined,
                  selectedIcon: Icons.storefront_rounded,
                  label: 'Toko',
                  selected:
                      selectedMenu == SellerMenu.store,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.store;
                    });
                  },
                ),
              ),

              Expanded(
                child: _MobileNavItem(
                  icon: Icons.bar_chart_outlined,
                  selectedIcon: Icons.bar_chart_rounded,
                  label: 'Laporan',
                  selected:
                      selectedMenu == SellerMenu.reports,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.reports;
                    });
                  },
                ),
              ),

              Expanded(
                child: _MobileNavItem(
                  icon: Icons.person_outline_rounded,
                  selectedIcon: Icons.person_rounded,
                  label: 'Profil',
                  selected:
                      selectedMenu == SellerMenu.profile,
                  onTap: () {
                    setState(() {
                      selectedMenu = SellerMenu.profile;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // DESKTOP
  // =========================================================

  Widget _buildDesktop() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 270,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ===============================
                  // LOGO
                  // ===============================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      26,
                      22,
                      32,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color:
                                AppColors.lightGreenBackground,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.eco_rounded,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          'Petani Tech',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _SidebarItem(
                    icon: Icons.dashboard_outlined,
                    selectedIcon: Icons.dashboard_rounded,
                    label: 'Dashboard',
                    selected:
                        selectedMenu == SellerMenu.dashboard,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.dashboard;
                      });
                    },
                  ),

                  _SidebarItem(
                    icon: Icons.inventory_2_outlined,
                    selectedIcon: Icons.inventory_2_rounded,
                    label: 'Produk',
                    selected:
                        selectedMenu == SellerMenu.products,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.products;
                      });
                    },
                  ),

                  _SidebarItem(
                    icon: Icons.receipt_long_outlined,
                    selectedIcon: Icons.receipt_long_rounded,
                    label: 'Pesanan',
                    selected:
                        selectedMenu == SellerMenu.orders,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.orders;
                      });
                    },
                  ),

                  _SidebarItem(
                    icon: Icons.storefront_outlined,
                    selectedIcon: Icons.storefront_rounded,
                    label: 'Toko',
                    selected:
                        selectedMenu == SellerMenu.store,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.store;
                      });
                    },
                  ),

                  _SidebarItem(
                    icon: Icons.bar_chart_outlined,
                    selectedIcon: Icons.bar_chart_rounded,
                    label: 'Laporan',
                    selected:
                        selectedMenu == SellerMenu.reports,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.reports;
                      });
                    },
                  ),

                  _SidebarItem(
                    icon: Icons.person_outline_rounded,
                    selectedIcon: Icons.person_rounded,
                    label: 'Profil',
                    selected:
                        selectedMenu == SellerMenu.profile,
                    onTap: () {
                      setState(() {
                        selectedMenu = SellerMenu.profile;
                      });
                    },
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      20,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                          '/login',
                          (route) => false,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.red.shade500,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'Keluar',
                              style: TextStyle(
                                color: Colors.red.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: _getCurrentPage(),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// MOBILE NAVIGATION ITEM
// =============================================================

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 7,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 42,
              height: 30,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primaryLight
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                selected ? selectedIcon : icon,
                size: 21,
                color: selected
                    ? Colors.black
                    : AppColors.textDark,
              ),
            ),

            const SizedBox(height: 3),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: selected
                      ? AppColors.primary
                      : AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// DESKTOP SIDEBAR ITEM
// =============================================================

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 3,
      ),
      child: Material(
        color: selected
            ? AppColors.lightGreenBackground
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(
                  selected ? selectedIcon : icon,
                  color: selected
                      ? AppColors.primary
                      : AppColors.textGrey,
                ),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: selected
                        ? AppColors.primary
                        : AppColors.textDark,
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