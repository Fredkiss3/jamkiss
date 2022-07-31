import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/components/track_progress.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/current_playing.dart';
import 'package:jamkiss/model/single_track_arguments.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class SingleTrackScreen extends StatefulWidget {
  const SingleTrackScreen({Key? key}) : super(key: key);

  @override
  State<SingleTrackScreen> createState() => _SingleTrackScreenState();
}

class _SingleTrackScreenState extends State<SingleTrackScreen> {
  bool _hasStarted = false;
  bool _isPlaying = false;
  int _currentTime = 0;
  bool _isListenerAttached = false;
  // final player = AudioPlayer(playerId: 'current');

  // @override
  // void initState() {
  //   super.initState();

  //   player.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       _isPlaying = state == PlayerState.playing;
  //     });
  //   });
  //   player.onPositionChanged.listen((duration) {
  //     setState(() {
  //       _currentTime = duration.inSeconds;
  //       if (duration.inMilliseconds > 29000) {
  //         _isPlaying = false;
  //       }
  //     });
  //   });
  // }

  // Future<void> start(CurrentPlayingModel currentPlaying) async {
  //   final track = ModalRoute.of(context)!.settings.arguments as SingleTrack;

  //   currentPlaying.track = track;

  //   await player.play(UrlSource(track.previewUrl!));
  //   setState(() {
  //     _hasStarted = true;
  //   });
  // }

  // Future<void> toggle(CurrentPlayingModel currentPlaying) async {
  //   await currentPlaying.toggle();
  //   if (player.state == PlayerState.playing) {
  //     await player.pause();
  //   } else {
  //     await player.resume();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final track = ModalRoute.of(context)!.settings.arguments as SingleTrack;

    return Consumer<CurrentPlayingModel>(
        builder: ((context, currentPlaying, child) {
      if (!_isListenerAttached && currentPlaying.track?.id == track.id) {
        currentPlaying.player.onPlayerStateChanged.listen((state) {
          setState(() {
            _isPlaying = state == PlayerState.playing;
          });
        });

        currentPlaying.player.onPositionChanged.listen((duration) {
          setState(() {
            _currentTime = duration.inSeconds;
            if (currentPlaying.duration != null &&
                duration.inSeconds >= currentPlaying.duration!.inSeconds) {
              _isPlaying = false;
            }
          });
        });

        _isListenerAttached = true;
      }

      return SafeArea(
        child: Scaffold(
            body: Container(
          color: secondaryColor.withAlpha(60),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          primary: secondaryColor,
                          padding: const EdgeInsets.all(10.0),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft),
                      // ignore: prefer_const_constructors
                      child: Icon(
                        size: 20,
                        CupertinoIcons.back,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Retour à la recherche",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 10.0,
                    child: track.cover == null
                        ? Container(
                            color: secondaryColor,
                            height: 300.0,
                            width: double.infinity,
                            child: const Icon(CupertinoIcons.music_note),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              track.cover!,
                              fit: BoxFit.cover,
                              height: 300.0,
                              width: double.infinity,
                            ),
                          )),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  track.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  track.artist,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TrackProgress(
                  totalTime: track.previewUrl == null ? 0 : 29,
                  currentTime: _currentTime,
                  onDragTick: (duration) async {
                    if (!_hasStarted) {
                      await currentPlaying.startTrack(track);
                      setState(() {
                        _hasStarted = true;
                      });
                    }
                    await currentPlaying.player
                        .seek(Duration(seconds: duration));
                    setState(() {
                      _currentTime = duration;
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: !track.hasPrevious ? null : () {},
                        style: TextButton.styleFrom(
                            primary: secondaryColor,
                            padding: const EdgeInsets.all(10.0),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: const Icon(CupertinoIcons.backward_fill)),
                    const SizedBox(
                      width: 40.0,
                    ),
                    ElevatedButton(
                        onPressed: track.previewUrl == null
                            ? null
                            : () async {
                                if (!_hasStarted) {
                                  await currentPlaying.startTrack(track);
                                  setState(() {
                                    _hasStarted = true;
                                  });
                                } else {
                                  await currentPlaying.toggle();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            alignment: AlignmentDirectional.center,
                            primary: secondaryColor,
                            padding: const EdgeInsets.all(20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        child: Icon(currentPlaying.isPlaying
                            ? CupertinoIcons.pause_fill
                            : CupertinoIcons.play_fill)),
                    const SizedBox(
                      width: 40.0,
                    ),
                    TextButton(
                        onPressed: !track.hasNext ? null : () {},
                        style: TextButton.styleFrom(
                            primary: secondaryColor,
                            padding: const EdgeInsets.all(10.0),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: const Icon(CupertinoIcons.forward_fill)),
                  ],
                )
              ],
            ),
          ),
        )),
      );
    }));
  }
}
