import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/model/single_track_arguments.dart';

class CurrentPlayingModel extends ChangeNotifier {
  /// Internal, private state of the track.
  final AudioPlayer _player = AudioPlayer(playerId: 'current');

  SingleTrack? _source;
  Duration? _duration;
  bool _isPlaying = false;

  Future<void> startTrack(SingleTrack track) async {
    if (_source != null) {
      await _player.stop();
    }
    await _player.play(UrlSource(track.previewUrl!));
    _source = track;
    _isPlaying = true;
    notifyListeners();

    _player.onDurationChanged.listen(((Duration duration) {
      _duration = duration;
    }));

    _player.onPositionChanged.listen((Duration position) {
      if (_duration != null && position.inSeconds >= _duration!.inSeconds) {
        _isPlaying = false;
        startTrack(track);
        notifyListeners();
      }
    });

    _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }

  SingleTrack? get track => _source;

  void stop() async {
    if (_source != null) {
      _source = null;

      await _player.stop();
      await _player.release();

      notifyListeners();
    }
  }

  Future<void> play() async {
    if (_source != null) {
      await _player.resume();
      notifyListeners();
    }
  }

  Future<void> pause() async {
    if (_source != null) {
      await _player.pause();
      notifyListeners();
    }
  }

  Future<void> toggle() async {
    if (_source != null) {
      if (_player.state == PlayerState.playing) {
        await _player.pause();
      } else {
        await _player.resume();
      }
      notifyListeners();
    }
  }

  bool get isPlaying => _source != null && _isPlaying;

  AudioPlayer get player => _player;

  Duration? get duration => _duration;
}
