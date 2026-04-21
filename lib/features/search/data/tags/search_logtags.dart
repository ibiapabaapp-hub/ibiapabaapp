import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum SearchAction implements LogTag {
  restore('[RESTORE]');

  @override
  final String tag;
  const SearchAction(this.tag);
}