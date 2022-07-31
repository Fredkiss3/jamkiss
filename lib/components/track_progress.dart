import 'package:flutter/material.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/utils.dart';

class TrackProgress extends StatelessWidget {
  // La durée totale du titre en secondes
  final int totalTime;
  // La progression courante de la musique en secondes
  final int currentTime;

  final Future<void> Function(int percent)? onDragTick;

  const TrackProgress(
      {Key? key,
      required this.totalTime,
      required this.currentTime,
      this.onDragTick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var value = currentTime;
    // if (totalTime == 0) {
    //   value
    // }

    return Column(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - 20.0),
          child: SliderTheme(
            data: SliderThemeData(
              trackShape: CustomTrackShape(),
            ),
            child: Slider(
              value: currentTime.toDouble(),
              activeColor: secondaryColor,
              inactiveColor: secondaryColor.withAlpha(60),
              max: totalTime.toDouble(),
              label: getDuration(currentTime),
              onChanged: (value) async {
                if (onDragTick != null) {
                  onDragTick!(value.toInt());
                }
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getDuration(currentTime),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16.0)),
            Text(getDuration(totalTime),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16.0)),
          ],
        )
      ],
    );
  }
}

/// Custom Track Shape pour régler un problème de padding
/// avec le slider
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
