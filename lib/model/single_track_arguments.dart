import 'package:jamkiss/constants/spotify.dart';
import 'package:spotify/spotify.dart';

class SingleTrackArguments {
  late Track _track;
  bool _hasNext = false;
  bool _hasPrevious = false;

  SingleTrackArguments(
      {required Track track, bool? hasNext, bool? hasPrevious}) {
    _track = track;
    _hasNext = hasNext ?? false;
    _hasPrevious = hasPrevious ?? false;

    print("track: ${_track.id}, ${_track.previewUrl}");
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

  bool get hasNext => _hasNext;
  bool get hasPrevious => _hasPrevious;
}
