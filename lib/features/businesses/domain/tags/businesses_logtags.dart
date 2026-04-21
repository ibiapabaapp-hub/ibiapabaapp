import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum BusinessAction implements LogTag {
  getAllBusinesses('[GET_ALL_BUSINESSES]'),
  getBusinessById('[GET_BUSINESS_BY_ID]'),
  getBusinessMedia('[GET_BUSINESS_MEDIA]');

  @override
  final String tag;
  const BusinessAction(this.tag);
}