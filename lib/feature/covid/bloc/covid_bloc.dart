import 'dart:async';

import 'package:base_app/bloc/base_bloc.dart';
import 'package:flutter_ui_challenge/base/locator/get_it.dart';
import 'package:flutter_ui_challenge/feature/covid/model/covid_summary_response.dart';
import 'package:flutter_ui_challenge/feature/covid/repository/covid_repository.dart';
import 'package:meta/meta.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends BaseBloc<CovidEvent, CovidState> {
  final CovidRepository _covidRepository = GetIt.I<CovidRepository>();

  CovidBloc() : super(CovidInitial());

  @override
  Stream<CovidState> mapEventToState(
    CovidEvent event,
  ) async* {
    if (event is GetCovidSummary) {
      if (event.showLoading) {
        yield CovidInitial();
      }
      CovidSummary covidSummary = await _covidRepository.getCovidSummary();
      yield CovidSummarySuccess(covidSummary);
    }
  }
}
