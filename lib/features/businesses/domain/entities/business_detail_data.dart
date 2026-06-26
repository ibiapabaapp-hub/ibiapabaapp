import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/shared/models/media.dart';

class BusinessDetailData {
  final Business business;
  final List<Media> media;
  const BusinessDetailData({required this.business, required this.media});
}
