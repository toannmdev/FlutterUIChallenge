import 'package:base_app/base_app.dart';
import 'package:flutter_ui_challenge/base/base_request_new.dart';
import 'package:flutter_ui_challenge/base/locator/get_it.dart';
import 'package:flutter_ui_challenge/const/const.dart';
import 'package:flutter_ui_challenge/feature/covid/model/covid_summary_response.dart';

class CovidRepository {
  final BaseRequestNew baseRequest = GetIt.I<BaseRequestNew>();

  Future<CovidSummary> getCovidSummary() async {
    var response = await baseRequest.sendRequest(
        '$sBaseUrl$sCovidSummaryUrl', RequestMethod.GET);
    CovidSummary covidSummary = CovidSummary.fromJson(response);
    return covidSummary;
  }
}
