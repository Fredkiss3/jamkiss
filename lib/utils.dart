import 'package:jamkiss/model/search_result_item.dart';

int compareElements(SearchResultItem a, SearchResultItem b) {
  // print(a.intrinsicObject.runtimeType);
  if (a.type == b.type) {
    return 0;
  } else {
    if (b.type == 'track') {
      return 1;
    } else if (a.type == 'track') {
      return -1;
    } else {
      return 0;
    }
  }
}
