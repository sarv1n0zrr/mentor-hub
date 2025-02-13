import 'package:flutter_bloc/flutter_bloc.dart';
import 'mentors_event.dart';
import 'mentors_state.dart';

class MentorsBloc extends Bloc<MentorsEvent, MentorsState> {
  MentorsBloc() : super(MentorsState(selected: "Courses")) {
    on<MentorsEvent>((event, emit) {
      switch (event) {
        case MentorsEvent.selectCourses:
          emit(MentorsState(selected: "Courses"));
          break;
        case MentorsEvent.selectMentors:
          emit(MentorsState(selected: "Mentors"));
          break;
        case MentorsEvent.search:
          emit(MentorsState(selected: state.selected, isSearching: true));
          break;
      }
    });
  }
}
