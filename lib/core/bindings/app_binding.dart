import 'package:get/get.dart';

import '../../data/datasources/portfolio_local_data_source.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/usecases/get_portfolio_profile.dart';
import '../../presentation/home/controllers/portfolio_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioLocalDataSource>(
      PortfolioLocalDataSourceImpl.new,
      fenix: true,
    );
    Get.lazyPut<PortfolioRepository>(
      () => PortfolioRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => GetPortfolioProfile(Get.find()), fenix: true);
    Get.lazyPut(() => PortfolioController(Get.find()), fenix: true);
  }
}
