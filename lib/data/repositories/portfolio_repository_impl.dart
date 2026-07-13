import '../../domain/entities/portfolio_profile.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._localDataSource);

  final PortfolioLocalDataSource _localDataSource;

  @override
  PortfolioProfile getProfile() => _localDataSource.getProfile();
}
