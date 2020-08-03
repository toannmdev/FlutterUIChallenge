part of 'covid_bloc.dart';

@immutable
abstract class CovidEvent {}

class GetCovidSummary extends CovidEvent {
  final bool showLoading;

  GetCovidSummary({this.showLoading = true});
}