import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/main.dart';

void main() {
  testWidgets('portfolio renders core sections', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(
      find.text('Senior Flutter Lead building scalable mobile products.'),
      findsOneWidget,
    );
    expect(find.text('Animated skill strength'), findsOneWidget);
    expect(find.text('Beautiful app case studies'), findsOneWidget);
    expect(find.text('Ask about Prathamesh'), findsOneWidget);
  });
}
