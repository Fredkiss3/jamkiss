import 'package:spotify/spotify.dart';

class SingleTrack {
  late Track _track;
  String? _nextID;
  String? _previousID;

  SingleTrack({required Track track, String? nextID, String? prevID}) {
    _track = track;
    _nextID = nextID;
    _previousID = prevID;
  }

  String get name => _track.name!;
  String get id => _track.id!;
  String? get previewUrl => _track.previewUrl;
  String? get cover {
    return _track.artists?.first.images?.first.url ??
        _track.album?.images?.first.url;
  }

  String? get artistID => _track.artists?.first.id;
  String get artist => _track.artists?.first.name ?? 'Unknown';

  bool get hasNext => _nextID != null;
  bool get hasPrevious => _previousID != null;

  String? get nextID => _nextID;
  String? get prevID => _previousID;
}
