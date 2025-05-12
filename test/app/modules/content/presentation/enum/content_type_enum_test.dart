import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContentTypeEnumTest', () {
    test('deve retornar enum quando receber a string corretamente', () {
      expect(ContentTypeEnum.fromString['serie'], ContentTypeEnum.serie);
      expect(ContentTypeEnum.fromString['movie'], ContentTypeEnum.movie);
      expect(ContentTypeEnum.fromString['banana'], isNull);
    });
  });
}
