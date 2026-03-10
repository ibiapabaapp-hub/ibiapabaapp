import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';

class CompanyDetailData {
  final Company company;
  final List<Media> media;
  const CompanyDetailData({required this.company, required this.media});
}
