part of 'popular_cubit.dart';
// import 'package:movie_nti_aug/models/movies_model.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}
final class PopularLoading extends PopularState {}
final class PopularSuccess extends PopularState {
  final PopularResponse popularResponse;
  PopularSuccess(this.popularResponse);
}
final class PopularFailure extends PopularState {
  final String message;
  PopularFailure(this.message);

}
