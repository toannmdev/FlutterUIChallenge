part of 'covid_bloc.dart';

@immutable
abstract class CovidState {}

class CovidInitial extends CovidState {}

class CovidSummarySuccess extends CovidState {
  final CovidSummary covidSummary;

  CovidSummarySuccess(this.covidSummary);
}
