import 'package:jamkiss/model/search_result_item.dart';

int compareElements(SearchResultItem a, SearchResultItem b) {
  // print(a.intrinsicObject.runtimeType);
  if (a.type == b.type) {
    return 0;
  } else {
    if (b.type == 'Titre') {
      return 1;
    } else if (a.type == 'Titre') {
      return -1;
    } else {
      return 0;
    }
  }
}

String getDuration(int time) {
  final seconds = (time % 60).toString().padLeft(2, '0');
  final minutes = (time / 60).floor();

  return "$minutes:$seconds";
}
