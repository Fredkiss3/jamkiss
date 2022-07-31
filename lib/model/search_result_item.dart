import 'package:spotify/spotify.dart';

class SearchResultItem {
  final String name;
  final String id;
  final Track object;

  SearchResultItem({
    required this.name,
    required this.id,
    required this.object,
  });

  String get type {
    switch (object.type) {
      case "track":
        return "Titre";
      case "playlist":
        return "Playlist";
      case "album":
        return "Album";
      case "artist":
        return "Artiste";
      default:
        return "Unknown";
    }
  }

  String? get cover =>
      object.artists?.first.images?.first.url ??
      object.album?.images?.first.url;

  String get artist => object.artists?.first.name ?? 'Unknown';
}
