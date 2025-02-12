// lib/features/mentors/presentation/widgets/course_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/favorites/domain/models/favorite_item.dart';
import 'package:mentor_hub/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mentor_hub/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:mentor_hub/features/favorites/presentation/bloc/favorites_state.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final String description;
  final String price;
  final double rating;
  final String photo;

  const CourseCard({
    Key? key,
    required this.courseName,
    required this.description,
    required this.price,
    required this.rating,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favoritesState) {
        final String courseId = courseName; // Using name as ID for simplicity
        final bool isFavorite = favoritesState.favorites
            .any((item) => item.id == courseId && item.type == 'course');

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(photo),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    i < rating.floor()
                                        ? Icons.star
                                        : (i < rating
                                            ? Icons.star_half
                                            : Icons.star_border),
                                    color: Colors.purple,
                                    size: 16,
                                  ),
                                SizedBox(width: 4),
                                Text('$rating'),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  context
                                      .read<FavoritesBloc>()
                                      .add(RemoveFavorite(courseId));
                                } else {
                                  context.read<FavoritesBloc>().add(
                                        AddFavorite(
                                          FavoriteItem(
                                            id: courseId,
                                            name: courseName,
                                            description: description,
                                            price: price,
                                            rating: rating,
                                            photo: photo,
                                            type: 'course',
                                          ),
                                        ),
                                      );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
