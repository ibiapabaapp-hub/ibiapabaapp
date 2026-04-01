import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

abstract class CompaniesRemoteDatasource {
  Future<List<Company>> getAllCompanies();
  Future<Company> getCompanyById(String id);
}