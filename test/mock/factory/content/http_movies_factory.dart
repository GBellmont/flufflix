import 'package:dio/dio.dart';

class HttpMoviesFactory {
  static Response getMoviesModelJson({required int? page, int? totalPages}) {
    return Response(
      data: {
        'page': page,
        'total_pages': totalPages,
        'results': [
          {
            'id': 1233069,
            'poster_path': '/wqllCospPViEt7AeYIl4ZskKdSj.jpg',
            'title': 'Exterritorial',
            'release_date': '2025-01-01'
          },
          {
            'id': 1233070,
            'poster_path': '/wqllCospPViEt7AeYIl4ZskKdSk.jpg',
            'title': 'The Minecraft Movie',
            'release_date': '2025-01-01'
          }
        ]
      },
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': page}),
    );
  }

  static Response getMoviesModelSerializeErrorJson() {
    return Response(
      data: {'page': true, 'total_pages': [], 'results': 'resultado'},
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': 1}),
    );
  }

  static Response getMovieModelSerializeErrorJson() {
    return Response(
      data: {
        'page': 1,
        'total_pages': 100,
        'results': [
          {
            'id': true,
            'poster_path': 1234,
            'title': ['Exterritorial'],
          }
        ]
      },
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': 1}),
    );
  }

  static Response getMovieDetailsModelJson() {
    return Response(
      data: {
        'id': 986056,
        'title': 'Thunderbolts*',
        'overview':
            'Depois de se verem presos em uma armadilha mortal, uma equipe não convencional de anti-heróis deve embarcar em uma missão perigosa que os forçará a confrontar os cantos mais sombrios de seus passados.',
        'poster_path': '/eKD2p840nsRXLUR25ciVsNMJgOB.jpg',
        'backdrop_path': '/rthMuZfFv4fqEU4JVbgSW9wQ8rs.jpg',
        'release_date': '2025-04-30',
        'adult': false,
        'runtime': 126,
        'belongs_to_collection': {'name': 'Marvel Collection'},
        'vote_average': 7.55,
        'genres': [
          {'name': 'Ação'},
          {'name': 'Aventura'},
          {'name': 'Ficção científica'}
        ],
        'credits': {
          'cast': [
            {
              'known_for_department': 'Acting',
              'name': 'Florence Pugh',
              'popularity': 19.9855,
            },
            {
              'known_for_department': 'Acting',
              'name': 'Sebastian Stan',
              'popularity': 9.3371,
            },
            {
              'known_for_department': 'Acting',
              'name': 'Florence Pugh',
              'popularity': 19.9855,
            },
            {
              'known_for_department': 'Acting',
              'name': 'Florence Pugh',
              'popularity': 19.9855,
            },
            {
              'known_for_department': 'Acting',
              'name': 'Julia Louis-Dreyfus',
              'popularity': 5.3157,
            }
          ],
          'crew': [
            {
              'known_for_department': 'Directing',
              'name': 'Jake Schreier',
              'popularity': 3.9152,
            },
            {
              'known_for_department': 'Production',
              'name': 'Brian Chapek',
              'popularity': 1.2768,
            },
            {
              'known_for_department': 'Directing',
              'name': 'Jeff Okabayashi',
              'popularity': 1.2003,
            }
          ]
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getMovieDetailsModelSerializeErrorJson() {
    return Response(
      data: {
        'id': true,
        'title': 'Thunderbolts*',
        'overview':
            'Depois de se verem presos em uma armadilha mortal, uma equipe não convencional de anti-heróis deve embarcar em uma missão perigosa que os forçará a confrontar os cantos mais sombrios de seus passados.',
        'poster_path': '/eKD2p840nsRXLUR25ciVsNMJgOB.jpg',
        'backdrop_path': '/rthMuZfFv4fqEU4JVbgSW9wQ8rs.jpg',
        'release_date': '2025-04-30',
        'adult': false,
        'runtime': 126,
        'belongs_to_collection': null,
        'vote_average': 7.55,
        'genres': null,
        'credits': {'cast': null, 'crew': null}
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getMovieDetailsCreditItemModelSerializeErrorJson() {
    return Response(
      data: {
        'id': 986056,
        'title': 'Thunderbolts*',
        'overview':
            'Depois de se verem presos em uma armadilha mortal, uma equipe não convencional de anti-heróis deve embarcar em uma missão perigosa que os forçará a confrontar os cantos mais sombrios de seus passados.',
        'poster_path': '/eKD2p840nsRXLUR25ciVsNMJgOB.jpg',
        'backdrop_path': '/rthMuZfFv4fqEU4JVbgSW9wQ8rs.jpg',
        'release_date': '2025-04-30',
        'adult': false,
        'runtime': 126,
        'belongs_to_collection': {'name': 'Marvel Collection'},
        'vote_average': 7.55,
        'genres': [
          {'name': 'Ação'},
          {'name': 'Aventura'},
          {'name': 'Ficção científica'}
        ],
        'credits': {
          'cast': [
            {
              'known_for_department': true,
              'name': 'Florence Pugh',
              'popularity': 19.9855,
            },
          ],
          'crew': [
            {
              'known_for_department': 'Directing',
              'name': 'Jake Schreier',
              'popularity': 'string',
            },
          ]
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getMovieTrailersModelJson() {
    return Response(
      data: {
        'results': [
          {
            'name': 'Trailer Oficial 3 Dublado',
            'type': 'Trailer',
          },
          {
            'name': 'Trailer Oficial 3 Legendado',
            'type': 'Trailer',
          },
          {
            'name': 'Trailer Oficial 2 Dublado',
            'type': 'Trailer',
          },
          {
            'name': 'Trailer Oficial 2 Legendado',
            'type': 'Trailer',
          },
          {
            'name': 'Trailer Oficial Dublado',
            'type': 'Trailer',
          },
          {
            'name': 'Trailer Oficial Legendado',
            'type': 'Trailer',
          }
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getMovieTrailersModelSerializeErroJson() {
    return Response(
      data: {'results': true},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getMovieTrailerModelSerializeErrorJson() {
    return Response(
      data: {
        'results': [
          {
            'name': [],
            'type': true,
          },
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }
}
