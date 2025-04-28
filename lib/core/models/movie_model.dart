import 'package:flufflix/components/pagination/contract/index.dart';

class Movie extends PaginationCardContract {
  const Movie(int id, String title, String imagePath)
      : super(id: id, title: title, imagePath: imagePath);

  factory Movie.fromJson(Map<String, dynamic> jsonItem) {
    return Movie(jsonItem['id'], jsonItem['title'], jsonItem['poster_path']);
  }
}
