import 'package:flutter/material.dart';
import 'package:jamkiss/components/search_result.dart';
import 'package:jamkiss/constants/spotify.dart';
import 'package:jamkiss/constants/theme.dart';
import 'package:jamkiss/model/search_result_item.dart';
import 'package:jamkiss/utils.dart';
import 'package:spotify/spotify.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = "";
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _queryController.addListener(() => setState(() {
          _query = _queryController.text;
        }));
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JAMKISS 🎶',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Trouvez plus facilement votre prochain son catchy.',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: textColor),
                            color: secondaryColor.withAlpha(60)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _queryController,
                                style: Theme.of(context).textTheme.headline6,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Nom du titre, artiste ou playlist",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: textColor.withAlpha(100)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.search,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder<Iterable<SearchResultItem>>(
            future: spotifyApiClient.search
                .get(_query, types: [
                  SearchType.track,
                ])
                .getPage(20, 0)
                .then((pages) => pages.expand((page) {
                      try {
                        return page.items?.toList() ?? [];
                      } catch (e) {
                        return [];
                      }
                    }).map((item) => SearchResultItem(
                        name: item.name, id: item.id, object: item))),
            builder: (context, snapshot) {
              List<SearchResultItem> items = snapshot.data?.toList() ?? [];
              items.sort(compareElements);
              // print(items[67]);
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    )
                  : items.isEmpty
                      ? Center(
                          child: Text("Aucun Track trouvé pour l'instant",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: textColor.withAlpha(100))),
                        )
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: ((context, i) => SearchResult(
                                element: items[i],
                                isLast: i == items.length - 1,
                              )),
                        );
            },
          ))
        ],
      ),
    ));
  }
}

/**
 * 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final search = spotifyApiClient.search;
    // search.get("Take on").getPage(30, 0).then((pages) {
    //   var items = pages[0].items;
    //   if (items != null) {
    //     // for (var item in items) {
    //       // print("Values Received: ${item.id} - ${item.name} (${item.type})");

    //       // if (item is PlaylistSimple) {
    //         // print(
    //         //   item.id,
    //         // );
    //         // if (item.tracks != null) {
    //         // print("tracks: ${item.tracks!.itemsNative}");
    //         // }
    //       // }
    //     }
    //   }
    // });
    // spotifyApiClient.tracks.get('2WfaOiMkCvy7F5fcp2zZ8L').then((track) {
    //   print("Track Retrevied: ${track.name}");
    // });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: spotifyApiClient.search
            .get("Take on")
            .getPage(30, 0)
            .then((pages) async {
          var p = pages.expand((page) {
            List l = [];
            try {
              l = page.items?.toList() ?? [];
              print("items: ${l}");
            } catch (e) {
              l = [];
            }
            return l;
          }).toList();

          print("list: ${p.length}");
          return p;
        }).catchError((e) => print("Error !! $e")),
        builder: (context, snapshot) {
          print(
              "Items: ${snapshot.data ?? []}, length: ${snapshot.data?.length ?? 0}");
          var items = snapshot.data ?? [];
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: ((context, i) =>
                      Text("${items[i].name} - (${items[i].type})")),
                );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

 */