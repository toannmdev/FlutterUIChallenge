import 'package:base_app/base_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_challenge/const/const.dart';

import 'bloc/covid_bloc.dart';
import 'widgets/covid_widgets.dart';
import 'widgets/covid_region_widget.dart';

class CovidSummaryPage extends StatefulWidget {
  CovidSummaryPage({Key key}) : super(key: key);

  @override
  _CovidSummaryPageState createState() => _CovidSummaryPageState();
}

class _CovidSummaryPageState
    extends BaseStatefulWidgetState<CovidSummaryPage, CovidBloc>
    with TickerProviderStateMixin<CovidSummaryPage> {
  // final ScrollController _scrollController = ScrollController();

  // AnimationController _hideFabAnimation;

  // bool _handleScrollNotification(ScrollNotification notification) {
  //   // if (notification.depth == 0) {
  //   if (notification is UserScrollNotification) {
  //     final UserScrollNotification userScroll = notification;
  //     switch (userScroll.direction) {
  //       case ScrollDirection.forward:
  //         if (userScroll.metrics.maxScrollExtent !=
  //             userScroll.metrics.minScrollExtent) {
  //           _hideFabAnimation.reverse();
  //         }
  //         break;
  //       case ScrollDirection.reverse:
  //         if (userScroll.metrics.maxScrollExtent !=
  //             userScroll.metrics.minScrollExtent) {
  //           _hideFabAnimation.forward();
  //         }
  //         break;
  //       case ScrollDirection.idle:
  //         break;
  //     }
  //   }
  //   // }
  //   return false;
  // }

  @override
  BaseBloc initBloc() {
    // _hideFabAnimation =
    //     AnimationController(vsync: this, duration: kThemeAnimationDuration);
    // _hideFabAnimation.reverse();

    return CovidBloc()..add(GetCovidSummary());
  }

  @override
  Widget buildWidgets(BuildContext context) {
    return
        //  NotificationListener<ScrollNotification>(
        //   onNotification: _handleScrollNotification,
        //   child:
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(sMainAppbarTitle),
      ),
      // floatingActionButton: ScaleTransition(
      //   scale: _hideFabAnimation,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       _scrollController.animateTo(
      //         0.0,
      //         curve: Curves.easeOut,
      //         duration: const Duration(milliseconds: 300),
      //       );
      //     },
      //     child: Icon(
      //       Icons.arrow_upward,
      //       color: Colors.white,
      //     ),
      //     backgroundColor: lightPrimaryColor,
      //   ),
      // ),
      body: (BlocProvider(
          create: (context) => bloc,
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is CovidSummarySuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    buildWorldCovidWidget(context, state.covidSummary,
                        () => bloc.add(GetCovidSummary())),
                    Expanded(
                      child: SingleChildScrollView(
                          // controller: _scrollController,
                          child: CovidRegionWidget(state.covidSummary)),
                    )
                  ],
                );
              } else {
                return Center(
                  child: wBuildLoading(),
                );
              }
            },
          ))),
      // ),
    );
  }
}
