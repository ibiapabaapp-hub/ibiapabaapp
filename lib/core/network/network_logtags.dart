import 'package:ibivibe/core/logger/log_tags.dart';

enum NetworkAction implements LogTag {
  interceptor('[INTERCEPTOR]'),
  request('[REQUEST]'),
  response('[RESPONSE]');

  @override
  final String tag;
  const NetworkAction(this.tag);
}
