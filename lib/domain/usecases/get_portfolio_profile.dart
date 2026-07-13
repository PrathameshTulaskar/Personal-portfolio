import '../entities/portfolio_profile.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolioProfile {
  const GetPortfolioProfile(this._repository);

  final PortfolioRepository _repository;

  PortfolioProfile call() => _repository.getProfile();
}
