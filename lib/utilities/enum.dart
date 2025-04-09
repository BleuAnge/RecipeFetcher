// ignore_for_file: constant_identifier_names

enum SearchType {
  CATEGORIES,
  AREAS,
  INGREDIENTS;

  String get name => toString().split('.').last;
}