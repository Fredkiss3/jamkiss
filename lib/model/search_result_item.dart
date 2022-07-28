import 'package:spotify/spotify.dart';

class SearchResultItem {
  final String name;
  final String id;
  final String type;
  final dynamic intrinsicObject;

  SearchResultItem({
    required this.name,
    required this.id,
    required this.type,
    required this.intrinsicObject,
  });

  String? get cover {
    var intrinsinc = intrinsicObject;
    if (intrinsinc is AlbumSimple ||
        intrinsinc is PlaylistSimple ||
        intrinsinc is Artist) {
      return intrinsinc.images?.first.url;
    } else if (intrinsinc is Track) {
      return intrinsinc.artists?.first.images?.first.url ??
          intrinsinc.album?.images?.first.url;
    }
    return null;
  }
}
