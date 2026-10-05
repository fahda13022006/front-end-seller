# Fix Notes

Perbaikan yang dilakukan:
- package name dipastikan `frontend_seller`
- semua import internal menggunakan `package:frontend_seller/...`
- widget `PetaniTechLogo` dan `SectionHeader` berada di `lib/core/widgets/`
- theme berada di `lib/core/theme/`
- `withOpacity()` diganti menjadi `withValues(alpha: ...)`
- `test/widget_test.dart` diperbarui agar menggunakan `PetaniTechSellerApp`

Setelah menyalin file ke project:

```bash
flutter clean
flutter pub get
flutter analyze
flutter run -d chrome
```
