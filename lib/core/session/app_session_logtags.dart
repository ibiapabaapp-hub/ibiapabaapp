import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum AppSessionAction implements LogTag {
  restore('[RESTORE]'),
  initSession('[INIT_SESSION]');
  
  @override
  final String tag;
  const AppSessionAction(this.tag);
}