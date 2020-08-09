import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge/const/colors.dart';
import 'package:flutter_ui_challenge/const/const.dart';
import 'package:flutter_ui_challenge/const/dimens.dart';
import 'package:flutter_ui_challenge/const/style.dart';
import 'package:flutter_ui_challenge/feature/covid/model/covid_summary_response.dart';
import 'package:flutter_ui_challenge/utils/currency_utils.dart';
import 'package:flutter_ui_challenge/utils/date_time_utils.dart';
import 'package:jiffy_vi/jiffy.dart';

/// unused
BoxDecoration defaultBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
        Color(0xFFb06ab3),
        // Color(0xFF4ca1af),
        Color(0xFF4568dc),
      ]));
}

Widget buildWorldCovidWidget(
    BuildContext context, CovidSummary covidSummary, Function onRefresh) {
  return Container(
    decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(dDefaultRadius))),
    margin: EdgeInsets.all(dDefaultPadding),
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(dPaddingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  sWorld,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              InkWell(
                  onTap: () => onRefresh(),
                  child: buildCovidLastUpdatedText(context, covidSummary)),
            ],
          ),
          SizedBox(
            height: dDefaultPadding,
          ),
          // Center(
          //   child: _buildTextHint(
          //     sTotalConfirmed,
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextHint(
                sTotalConfirmed,
              ),
              SizedBox(
                width: dDefaultPadding / 2,
              ),
              _buildTextOption(covidSummary.global.newConfirmed,
                  textColor: textColorIncreaseNews)
            ],
          ),
          SizedBox(
            height: dDefaultPadding,
          ),
          Center(
            child: _buildTextHeader(
              context,
              getDecimalFormattedString(
                  '${covidSummary.global.totalConfirmed}'),
            ),
          ),
          SizedBox(
            height: dDefaultPadding * 2,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildTextHint(
                          sTotalRecovered,
                        ),
                        SizedBox(
                          width: dDefaultPadding / 2,
                        ),
                        _buildTextOption(covidSummary.global.newRecovered,
                            textColor: textColorIncrease)
                      ],
                    ),
                    SizedBox(
                      height: dDefaultPadding,
                    ),
                    _buildTextHeader(
                        context,
                        getDecimalFormattedString(
                            '${covidSummary.global.totalRecovered}'))
                  ],
                ),
              ),
              Container(
                  height: 32,
                  child: VerticalDivider(
                    color: textColorHint,
                  )),
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildTextHint(sTotalDeaths),
                        SizedBox(
                          width: dDefaultPadding / 2,
                        ),
                        _buildTextOption(covidSummary.global.newDeaths,
                            textColor: textColorDecrease)
                      ],
                    ),
                    SizedBox(
                      height: dDefaultPadding,
                    ),
                    _buildTextHeader(
                        context,
                        getDecimalFormattedString(
                            '${covidSummary.global.totalDeaths}')),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildCovidLastUpdatedText(
    BuildContext context, CovidSummary covidSummary) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: dDefaultPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          ' ${Jiffy(covidSummary.date, PATTERN_3).fromNow()}',
          style: textThemeOf(context)
              .bodyText2
              .copyWith(fontStyle: FontStyle.italic, color: textColorHint),
        ),
        Icon(
          Icons.refresh,
          color: textColorHint,
          size: textThemeOf(context).bodyText2.fontSize * 1.5,
        )
      ],
    ),
  );
}

Widget _buildTextHeader(BuildContext context, String headerStr) {
  return Text(headerStr, style: textHeadLine6WithBoldStyle(context));
}

Widget _buildTextHint(String hintStr) {
  return Text(
    hintStr,
    style: textHintStyle,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

Widget _buildTextOption(num number, {Color textColor}) {
  textColor ??=
      number != null && number >= 0 ? textColorIncrease : textColorDecrease;
  String strIOD = number != null && number > 0 ? '+' : '';
  return Text(
    '($strIOD${getDecimalFormattedString('$number')})',
    style: textHintStyle.copyWith(color: textColor),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
