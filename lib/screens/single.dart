import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/components/track_progress.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/single_track_arguments.dart';
import 'package:audioplayers/audioplayers.dart';

class SingleTrackScreen extends StatefulWidget {
  const SingleTrackScreen({Key? key}) : super(key: key);

  @override
  State<SingleTrackScreen> createState() => _SingleTrackScreenState();
}

class _SingleTrackScreenState extends State<SingleTrackScreen> {
  bool _hasStarted = false;
  bool _isPlaying = false;
  int _totalTime = 0;
  final player = AudioPlayer(playerId: 'current');

  @override
  Widget build(BuildContext context) {
    final track =
        ModalRoute.of(context)!.settings.arguments as SingleTrackArguments;

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
                    onPressed: () async {
                      final track = ModalRoute.of(context)!.settings.arguments
                          as SingleTrackArguments;

                      if (track.previewUrl != null) {
                        await player.stop();
                        await player.release();
                      }

                      // ignore: use_build_context_synchronously
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
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
              StreamBuilder<Duration>(
                  stream: player.onPositionChanged,
                  builder: (context, snapshot) {
                    return TrackProgress(
                      totalTime: track.previewUrl == null ? 0 : 30,
                      currentTime: snapshot.data?.inSeconds ?? 0,
                      onDragTick: (duration) async {
                        await player.seek(Duration(seconds: duration));
                      },
                    );
                  }),
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
                                await player.play(UrlSource(track.previewUrl!));
                              } else {
                                if (player.state == PlayerState.playing) {
                                  await player.pause();
                                } else {
                                  await player.resume();
                                }
                              }

                              setState(() {
                                if (!_hasStarted) {
                                  _isPlaying = true;
                                  _hasStarted = true;
                                } else {
                                  _isPlaying = !_isPlaying;
                                }
                              });
                            },
                      style: ElevatedButton.styleFrom(
                          alignment: AlignmentDirectional.center,
                          primary: secondaryColor,
                          padding: const EdgeInsets.all(20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0))),
                      child: Icon(_isPlaying
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
  }
}
