import 'package:dio/dio.dart';

class HttpSeriesFactory {
  static Response getSeriesModelJson({required int? page, int? totalPages}) {
    return Response(
      data: {
        'page': page,
        'total_pages': totalPages,
        'results': [
          {
            'id': 1233069,
            'poster_path': '/wqllCospPViEt7AeYIl4ZskKdSj.jpg',
            'name': 'Breaking Bad',
          },
          {
            'id': 1233070,
            'poster_path': '/wqllCospPViEt7AeYIl4ZskKdSk.jpg',
            'name': 'The Minecraft Series',
          }
        ]
      },
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': page}),
    );
  }

  static Response getSeriesModelSerializeErrorJson() {
    return Response(
      data: {'page': true, 'total_pages': [], 'results': 'resultado'},
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': 1}),
    );
  }

  static Response getSerieModelSerializeErrorJson() {
    return Response(
      data: {
        'page': 1,
        'total_pages': 100,
        'results': [
          {
            'id': true,
            'poster_path': 1234,
            'name': ['Breaking Bad'],
          }
        ]
      },
      statusCode: 200,
      requestOptions:
          RequestOptions(path: '/flufflix', queryParameters: {'page': 1}),
    );
  }

  static Response getSerieDetailsModelJson() {
    return Response(
      data: {
        "adult": false,
        "backdrop_path": "/wQEW3xLrQAThu1GvqpsKQyejrYS.jpg",
        "episode_run_time": [69],
        "first_air_date": "2021-11-06",
        "genres": [
          {"id": 16, "name": "Animação"},
          {"id": 10765, "name": "Sci-Fi & Fantasy"},
          {"id": 18, "name": "Drama"},
          {"id": 10759, "name": "Action & Adventure"}
        ],
        "id": 94605,
        "name": "Arcane",
        "overview":
            "Em meio ao conflito entre as cidades-gêmeas de Piltover e Zaun, duas irmãs lutam em lados opostos de uma guerra entre tecnologias mágicas e convicções incompatíveis.",
        "poster_path": "/m3Tzf6k537PnhOEwaSRNCSxedLS.jpg",
        "seasons": [
          {
            "season_number": 0,
          },
          {
            "season_number": 1,
          },
          {
            "season_number": 2,
          }
        ],
        "vote_average": 8.776,
        "credits": {
          "cast": [
            {
              "known_for_department": "Acting",
              "name": "Hailee Steinfeld",
              "popularity": 12.8993,
            },
            {
              "known_for_department": "Acting",
              "name": "Ella Purnell",
              "popularity": 4.9156,
            },
            {
              "known_for_department": "Acting",
              "name": "Ella Purnell",
              "popularity": 4.9156,
            },
            {
              "known_for_department": "Acting",
              "name": "Ella Purnell",
              "popularity": 4.9156,
            }
          ],
          "crew": [
            {
              "known_for_department": "Directing",
              "name": "Arnaud Delord",
              "popularity": 0.1765,
            },
            {
              "known_for_department": "Directing",
              "name": "Arnaud Delord",
              "popularity": 0.1765,
            },
            {
              "known_for_department": "Directing",
              "name": "Arnaud Delord",
              "popularity": 0.1765,
            },
            {
              "known_for_department": "Creator",
              "name": "Christian Linke",
              "popularity": 0.3586,
            }
          ]
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieDetailsModelSerializeErrorJson() {
    return Response(
      data: {
        "adult": 'nop',
        "backdrop_path": "/wQEW3xLrQAThu1GvqpsKQyejrYS.jpg",
        "episode_run_time": [],
        "first_air_date": "2021-11-06",
        "seasons": [
          {
            "season_number": true,
          },
          {
            "season_number": 1,
          },
          {
            "season_number": 2,
          }
        ],
        "vote_average": "8.776",
        "credits": null
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieDetailsCreditItemModelSerializeErrorJson() {
    return Response(
      data: {
        "adult": false,
        "backdrop_path": "/wQEW3xLrQAThu1GvqpsKQyejrYS.jpg",
        "episode_run_time": [],
        "first_air_date": "2021-11-06",
        "genres": [
          {"id": 16, "name": "Animação"},
          {"id": 10765, "name": "Sci-Fi & Fantasy"},
          {"id": 18, "name": "Drama"},
          {"id": 10759, "name": "Action & Adventure"}
        ],
        "id": 94605,
        "name": "Arcane",
        "overview":
            "Em meio ao conflito entre as cidades-gêmeas de Piltover e Zaun, duas irmãs lutam em lados opostos de uma guerra entre tecnologias mágicas e convicções incompatíveis.",
        "poster_path": "/m3Tzf6k537PnhOEwaSRNCSxedLS.jpg",
        "seasons": [
          {
            "season_number": 0,
          },
          {
            "season_number": 1,
          },
          {
            "season_number": 2,
          }
        ],
        "vote_average": 8.776,
        "credits": {
          "cast": [
            {
              "known_for_department": true,
              "name": 123,
              "popularity": 12.8993,
            },
            {
              "known_for_department": [],
              "name": "Ella Purnell",
              "popularity": '',
            },
          ],
          "crew": ''
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieTrailersModelJson() {
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

  static Response getSerieTrailersModelSerializeErroJson() {
    return Response(
      data: {'results': true},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieTrailerModelSerializeErrorJson() {
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

  static Response getSerieSeasonModelJson() {
    return Response(
      data: {
        "episodes": [
          {
            "name": "Piloto",
            "overview":
                "Um professor de química do ensino médio começa a vender drogas para sustentar sua família.",
            "runtime": 59,
            "still_path": "/ydlY3iPfeOAvu8gVqrxPoMvzNCn.jpg",
          },
          {
            "name": "The Cat's in the Bag",
            "overview":
                "O saldo da primeira transação fracassada de Walt e Jesse é de dois cadáveres e sua desova. Skyler suspeita que seu marido esteja tramando algo.",
            "runtime": 49,
            "still_path": "/xwQRVskT9IK7ktbrrWc2xoT4nPv.jpg",
          },
          {
            "name": "And the Bag's in the River",
            "overview":
                "Enquanto Walt limpa a bagunça que foi deixada após a primeira venda de drogas, ele pensa em contar a Skyler o segredo sobre a sua doença.",
            "runtime": 49,
            "still_path": "/n8Dah3Tc1vlc4i7bQ9zYPWaFO0e.jpg",
          },
          {
            "name": "Cancer Man",
            "overview":
                "Forçado a revelar a verdade sobre sua doença, Walt enfrenta o dilema de pagar pelos caros tratamentos de câncer.",
            "runtime": 49,
            "still_path": "/2UbRgW6apE4XPzhHPA726wUFyaR.jpg",
          },
          {
            "name": "Gray Matter",
            "overview":
                "Skyler organiza uma intervenção para persuadir Walt a aceitar a generosa oferta de seu antigo parceiro de pesquisa de pagar pelo seu tratamento de câncer.",
            "runtime": 49,
            "still_path": "/82G3wZgEvZLKcte6yoZJahUWBtx.jpg",
          },
          {
            "name": "Crazy Handful of Nothin'",
            "overview":
                "Conforme os efeitos colaterais e os custos do seu tratamento aumentam rapidamente, Walt exige que Jesse encontre um grande comprador para suas drogas, deixando Jesse encrencado com um perigoso ex-presidiário.",
            "runtime": 49,
            "still_path": "/rCCLuycNPL30W3BtuB8HafxEMYz.jpg",
          },
          {
            "name": "A No-Rough-Stuff-Type Deal",
            "overview":
                "Após Jesse escapar da morte, Walt concorda em produzir mais drogas para Tuco, enquanto Skyler suspeita que sua irmã roubou um presente de chá de bebê.",
            "runtime": 48,
          }
        ],
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieSeasonModelSerializeErroJson() {
    return Response(
      data: {'episodes': true},
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }

  static Response getSerieEpisodeModelSerializeErrorJson() {
    return Response(
      data: {
        'episodes': [
          {
            'name': [],
            'overview': true,
          },
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: '/flufflix'),
    );
  }
}
