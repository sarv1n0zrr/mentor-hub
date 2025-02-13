import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_hub/features/mentors/presentation/bloc/mentors_bloc.dart';
import 'package:mentor_hub/features/mentors/presentation/bloc/mentors_event.dart';
import 'package:mentor_hub/features/mentors/presentation/bloc/mentors_state.dart';
import 'package:mentor_hub/features/mentors/presentation/widgets/course_card.dart';
import 'package:mentor_hub/features/mentors/presentation/widgets/mentor_card.dart';

class MentorsPage extends StatelessWidget {
  const MentorsPage({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MentorsBloc()),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            _buildTitle("Courses"),
            _buildSearchField(),
            _buildSegmentedButton(),
            Expanded(
              child: BlocBuilder<MentorsBloc, MentorsState>(
                builder: (context, state) {
                  return _getSelectedPage(state.selected);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedPage(String selected) {
    switch (selected) {
      case "Courses":
        return _buildCoursesPage();
      case "Mentors":
        return _buildMentorsPage();
      default:
        return Container();
    }
  }

  Widget _buildCoursesPage() {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CourseCard(
            courseName: 'Python for Beginners',
            description: 'After this course you will know all base Python',
            price: '\$10.50',
            rating: 4.3,
            photo: "assets/images/image1.jpg",
          ),
          CourseCard(
            courseName: 'Flutter for Beginners',
            description: 'After this course you will know all base Flutter',
            price: '\$15.50',
            rating: 5.0,
            photo: "assets/images/image1.jpg",
          ),
          CourseCard(
            courseName: 'Java for Beginners',
            description: 'After this course you will know all base Java',
            price: '\$17.50',
            rating: 3.3,
            photo: "assets/images/image1.jpg",
          ),
          CourseCard(
            courseName: 'SQL for Beginners',
            description: 'After this course you will know all base SQL',
            price: '\$13.50',
            rating: 4.6,
            photo: "assets/images/image1.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildMentorsPage() {
    return const SingleChildScrollView(
      child: Column(
        children: [
          MentorCard(
            mentorName: 'Alisher Zhunisov',
            subject: 'Dart Teacher',
            rating: 5.0,
            photo: "assets/images/profile.jpg",
            price: "\$10",
          ),
          MentorCard(
            mentorName: 'Olzhas Tokhtasyn',
            subject: 'Python Teacher',
            rating: 5.0,
            photo: "assets/images/profile.jpg",
            price: "\$10",
          ),
          MentorCard(
            mentorName: 'Myktybayev Bakytzhan',
            subject: 'Flutter Teacher',
            rating: 5.0,
            photo: "assets/images/profile.jpg",
            price: "\$10",
          ),
          MentorCard(
            mentorName: 'Vasya Pupkin',
            subject: 'JavaScript Teacher',
            rating: 3.5,
            photo: "assets/images/profile.jpg",
            price: "\$10",
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSearchField() {
    return BlocBuilder<MentorsBloc, MentorsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFDADBD6),
                width: 1,
              ),
            ),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Color(0xFF580AFF)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: const TextStyle(color: Color(0xFF580AFF)),
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<MentorsBloc>().add(MentorsEvent.search);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF580AFF),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSegmentedButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<MentorsBloc, MentorsState>(
          builder: (context, state) {
            return SegmentedButton(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(value: "Courses", label: Text("Courses")),
                ButtonSegment<String>(value: "Mentors", label: Text("Mentors")),
              ],
              selected: {state.selected},
              onSelectionChanged: (newSelection) {
                if (newSelection.first == "Courses") {
                  context.read<MentorsBloc>().add(MentorsEvent.selectCourses);
                } else {
                  context.read<MentorsBloc>().add(MentorsEvent.selectMentors);
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.transparent;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFF580AFF);
                  }
                  return Colors.black54;
                }),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFF580AFF);
                  }
                  return null;
                }),
                side: WidgetStateProperty.all(
                  const BorderSide(color: Color(0xFFDADBD6), width: 1),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
