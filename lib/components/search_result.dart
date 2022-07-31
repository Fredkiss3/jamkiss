import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/search_result_item.dart';
import 'package:jamkiss/model/single_track_arguments.dart';

class SearchResult extends StatelessWidget {
  final SearchResultItem element;
  final bool isLast;

  const SearchResult({required this.element, required this.isLast, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, !isLast ? 5.0 : 20.0),
      child: InkWell(
        onTap: () async {
          if (element.object.type == 'track') {
            FocusManager.instance.primaryFocus?.unfocus();
            await Future.delayed(const Duration(milliseconds: 200));

            Navigator.of(context).pushNamed('/single',
                arguments: SingleTrack(
                  track: element.object,
                ));
          }
        },
        // splashColor: Colors.red.shade100,
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: secondaryColor),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                child: element.cover != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(element.cover!),
                        radius: 25,
                      )
                    : const Icon(CupertinoIcons.music_note),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      element.name,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: bgColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      element.artist,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: bgColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: bgColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
