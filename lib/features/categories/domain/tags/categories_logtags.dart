import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum CategoryAction implements LogTag {
  getParentCategories('[GET_PARENT_CATEGORIES]'),
  getChildrenCategories('[GET_CHILDREN_CATEGORIES]');

  @override
  final String tag;
  const CategoryAction(this.tag);
}