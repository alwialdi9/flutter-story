part of 'story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {}

class StoryLoadedSuccess extends StoryState {
  final List<Object> stories;
  const StoryLoadedSuccess(this.stories);

  @override
  List<Object> get props => stories;
}

class StoryLoadedFailed extends StoryState {
  final String message;

  StoryLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

class StoryMaxReached extends StoryState {}