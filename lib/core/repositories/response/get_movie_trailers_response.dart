import 'dart:convert';

class Trailer {
  final String type;
  final String name;

  Trailer({required this.type, required this.name});

  factory Trailer.fromJson(Map<String, dynamic> jsonResponse) {
    return Trailer(type: jsonResponse['type'], name: jsonResponse['name']);
  }

  Map<String, dynamic> get toJson => ({'type': type, 'name': name});
}

class GetMovieTrailersResponse {
  final List<Trailer> trailers;

  GetMovieTrailersResponse({required this.trailers});

  factory GetMovieTrailersResponse.fromJson(Map<String, dynamic> jsonResponse) {
    return GetMovieTrailersResponse(
        trailers: (jsonResponse['results'] as List? ?? [])
            .map((item) => Trailer.fromJson(item))
            .toList());
  }

  String get toJson =>
      jsonEncode({'results': trailers.map((item) => item.toJson).toList()});
}
