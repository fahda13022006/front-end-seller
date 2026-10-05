# Petani Tech Seller - Responsive / Mobile First

Perubahan utama:

- Fokus mobile untuk lebar < 600 px.
- Tablet 600-999 px tetap memakai bottom navigation.
- Desktop >= 1000 px memakai sidebar.
- Bottom navigation mobile: Beranda, Produk, Pesanan, Laporan, Lainnya.
- Menu Lainnya berisi Kelola Toko, Profil Seller, dan Keluar.
- Dashboard: kartu statistik menjadi horizontal scroll di HP agar tidak memakan layar terlalu panjang.
- Laporan: kartu ringkasan menjadi horizontal scroll di HP, chart dipadatkan, daftar produk terlaris dibuat compact.
- Produk: tombol Tambah Produk menjadi FAB di HP; form tambah/edit menjadi bottom sheet.
- Pesanan: layout card berubah menjadi vertikal di HP agar badge dan menu tidak overflow.
- Toko dan Profil: outer card dihilangkan pada HP agar area layar lebih efisien.
- Semua breakpoint dan padding responsive dipusatkan di lib/core/responsive/app_responsive.dart.

Setelah mengganti file project, jalankan:

flutter clean
flutter pub get
flutter analyze
flutter run -d chrome
