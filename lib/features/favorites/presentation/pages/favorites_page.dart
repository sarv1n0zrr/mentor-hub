import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mentor_hub/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:mentor_hub/features/mentors/presentation/widgets/course_card.dart';
import 'package:mentor_hub/features/mentors/presentation/widgets/mentor_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Text('No favorites yet'),
            );
          }

          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final item = state.favorites[index];
              if (item.type == 'course') {
                return CourseCard(
                  courseName: item.name,
                  description: item.description,
                  price: item.price,
                  rating: item.rating,
                  photo: item.photo,
                );
              } else {
                return MentorCard(
                  mentorName: item.name,
                  subject: item.description,
                  rating: item.rating,
                  photo: item.photo,
                  price: item.price,
                );
              }
            },
          );
        },
      ),
    );
  }
}
