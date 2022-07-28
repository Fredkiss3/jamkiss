class Track {
  final String? previewURL;
  final String artistName;
  final String coverUrl;
  final String name;
  final String spotifyURL;

  Track({
    required this.name,
    required this.artistName,
    required this.coverUrl,
    required this.spotifyURL,
    required this.previewURL,
  });

  // factory Track.fromMap(Map<String, dynamic> map) {
  //   return Track(
  //       name: map['name'],
  //       artistName: map['artists'][0]['name'],
  //       coverUrl: coverUrl,
  //       spotifyURL: spotifyURL,
  //       previewURL: previewURL);
  // }
}
