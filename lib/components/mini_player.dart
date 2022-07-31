import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/current_playing.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentPlayingModel>(
      builder: ((context, state, child) {
        var track = state.track;
        return track == null
            ? Container()
            : Material(
                child: Container(
                  decoration: const BoxDecoration(color: primaryColor),
                  child: SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              elevation: 10.0,
                              child: track.cover == null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          color: tertiaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child:
                                          const Icon(CupertinoIcons.music_note),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        track.cover!,
                                        fit: BoxFit.cover,
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  track.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          fontSize: 16.0,
                                          color: bgColor,
                                          fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  track.artist,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontSize: 14.0,
                                          color: bgColor,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await state.toggle();
                                  },
                                  style: TextButton.styleFrom(
                                      primary: secondaryColor,
                                      padding: const EdgeInsets.all(10.0),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft),
                                  child: Icon(
                                    size: 20,
                                    state.isPlaying
                                        ? CupertinoIcons.pause_fill
                                        : CupertinoIcons.play_fill,
                                    color: bgColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
