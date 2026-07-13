import 'package:get/get.dart';

import '../../presentation/home/pages/portfolio_home_page.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => const PortfolioHomePage()),
  ];
}
