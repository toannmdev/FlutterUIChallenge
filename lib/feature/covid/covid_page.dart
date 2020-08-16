import 'package:base_app/base_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_challenge/base/locator/get_it.dart';
import 'package:flutter_ui_challenge/const/colors.dart';
import 'package:flutter_ui_challenge/const/const.dart';
import 'package:flutter_ui_challenge/feature/covid/model/covid_summary_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/covid_bloc.dart';
import 'repository/covid_repository.dart';
import 'widgets/covid_region_widget.dart';
import 'widgets/covid_widgets.dart';

class CovidSummaryPage extends StatefulWidget {
  CovidSummaryPage({Key key}) : super(key: key);

  @override
  _CovidSummaryPageState createState() => _CovidSummaryPageState();
}

class _CovidSummaryPageState
    extends BaseStatefulWidgetState<CovidSummaryPage, CovidBloc>
    // with TickerProviderStateMixin<CovidSummaryPage> 
    {
  
  // final RefreshController _refreshController = RefreshController();

  @override
  BaseBloc initBloc() {
    return CovidBloc()..add(GetCovidSummary());
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(sMainAppbarTitle),
      ),
      body: (BlocProvider(
          create: (context) => bloc,
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is CovidSummarySuccess) {
                return 
                // SmartRefresher(
                //   onRefresh: () async{
                //     // bloc.add(GetCovidSummary());
                //     await GetIt.I<CovidRepository>().getCovidSummary();
                //     _refreshController.refreshCompleted();
                //   },
                //   header: BezierCircleHeader(
                //     bezierColor: darkAccentColor,
                //   ),
                //   controller: _refreshController,
                // child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    buildWorldCovidWidget(context, state.covidSummary,
                        () => bloc.add(GetCovidSummary())),
                    Expanded(
                          child: CovidRegionWidget(state.covidSummary)),
                    
                  ],
                // )
                );
              } else {
                return Center(
                  child: wBuildLoading(),
                );
              }
            },
          ))),
    );
  }
}
