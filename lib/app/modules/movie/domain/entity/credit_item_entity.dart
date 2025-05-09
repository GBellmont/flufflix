abstract class CreditItemEntity {
  final String name;
  final String knowForDepartment;
  final double popularity;

  const CreditItemEntity(
      {required this.name,
      required this.knowForDepartment,
      required this.popularity});
}
