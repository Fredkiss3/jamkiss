import 'package:spotify/spotify.dart';

const spotifyClientID =
    String.fromEnvironment("SPOTIFY_CLIENT_ID", defaultValue: "Unknown");
const spotifyClientSecret =
    String.fromEnvironment("SPOTIFY_CLIENT_SECRET", defaultValue: "Unknown");

final credentials = SpotifyApiCredentials(spotifyClientID, spotifyClientSecret);
final spotifyApiClient = SpotifyApi(credentials);
