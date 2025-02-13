import 'package:hive/hive.dart';

part 'favorite_item.g.dart';

@HiveType(typeId: 0)
class FavoriteItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final String photo;

  @HiveField(6)
  final String type;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.photo,
    required this.type,
  });
}
