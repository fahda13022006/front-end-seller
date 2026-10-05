import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_seller/app.dart';

void main() {
  testWidgets(
    'Petani Tech Seller menampilkan halaman login',
    (tester) async {
      await tester.pumpWidget(
        const PetaniTechSellerApp(),
      );

      expect(
        find.text('Login Seller'),
        findsOneWidget,
      );

      expect(
        find.text('Petani Tech'),
        findsWidgets,
      );
    },
  );
}