import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class PopMenuVerifiedOptionContract {
  final PopMenuOptionsTypeEnum type;
  final bool isActive;

  const PopMenuVerifiedOptionContract(
      {required this.isActive, required this.type});
}
