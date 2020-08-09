import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge/const/colors.dart';
import 'package:flutter_ui_challenge/const/dimens.dart';
import 'package:flutter_ui_challenge/feature/covid/model/covid_summary_response.dart';
import 'package:flutter_ui_challenge/const/const.dart';
import 'package:flutter_ui_challenge/utils/currency_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class CovidRegionWidget extends StatefulWidget {
  final CovidSummary covidSummary;

  CovidRegionWidget(this.covidSummary);

  @override
  CovidRegionWidgetState createState() => CovidRegionWidgetState();
}

class CovidRegionWidgetState extends State<CovidRegionWidget> {
  static final int _totalRows = 4;

  static const int sortName = 0;
  static const int sortConfirmed = 1;
  static const int sortRecovered = 2;
  static const int sortDeaths = 4;
  bool isAscendingName = true;
  bool isAscendingConfirmed = true;
  bool isAscendingRecovered = true;
  bool isAscendingDeaths = true;
  int sortType = sortName;

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: _getColumnWidth(),
        rightHandSideColumnWidth:
            MediaQuery.of(context).size.width - _getColumnWidth(),
        isFixedHeader: true,
        headerWidgets: _buildTitles(),
        leftSideItemBuilder: _buildLeftSideItems,
        rightSideItemBuilder: _buildRightSideItems,
        itemCount: widget.covidSummary.countries.length,
        rowSeparatorWidget: const Divider(
          color: Colors.white30,
          height: 0.05,
          thickness: 0.5,
        ),
        leftHandSideColBackgroundColor: Colors.transparent,
        rightHandSideColBackgroundColor: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _buildTitles() {
    final List<Country> countries = widget.covidSummary.countries;
    return [
      InkWell(
        child: _buildText(
            '${sortType == sortName ? (isAscendingName ? '↓' : '↑') : ''} $sRegion',
            textAlign: TextAlign.left,
            bgColor: sortType == sortName ? cardBackgroundColor: Colors.transparent),
        onTap: () {
          sortType = sortName;
          isAscendingName = !isAscendingName;
          setState(() {
            isAscendingName
                ? countries.sort((a, b) => a.country.compareTo(b.country))
                : countries.sort((a, b) => b.country.compareTo(a.country));
          });
        },
        onLongPress: () => _showToast(sRegion),
      ),
      InkWell(
        child: _buildText(
            '${sortType == sortConfirmed ? (isAscendingConfirmed ? '↓' : '↑') : ''} $sConfirmedNumber',
            textAlign: TextAlign.right,
            bgColor: sortType == sortConfirmed ? cardBackgroundColor: Colors.transparent),
        onTap: () {
          sortType = sortConfirmed;
          isAscendingConfirmed = !isAscendingConfirmed;
          setState(() {
            isAscendingConfirmed
                ? countries.sort(
                    (a, b) => a.totalConfirmed.compareTo(b.totalConfirmed))
                : countries.sort(
                    (a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
          });
        },
        onLongPress: () => _showToast(sConfirmedNumber),
      ),
      InkWell(
        child: _buildText(
            '${sortType == sortRecovered ? (isAscendingRecovered ? '↓' : '↑') : ''} $sTotalRecovered',
            textAlign: TextAlign.right,
            bgColor: sortType == sortRecovered ? cardBackgroundColor: Colors.transparent),
        onTap: () {
          sortType = sortRecovered;
          isAscendingRecovered = !isAscendingRecovered;
          setState(() {
            isAscendingRecovered
                ? countries.sort(
                    (a, b) => a.totalRecovered.compareTo(b.totalRecovered))
                : countries.sort(
                    (a, b) => b.totalRecovered.compareTo(a.totalRecovered));
          });
        },
        onLongPress: () => _showToast(sTotalRecovered),
      ),
      InkWell(
        child: _buildText(
            '${sortType == sortDeaths ? (isAscendingDeaths ? '↓' : '↑') : ''} $sTotalDeaths',
            textAlign: TextAlign.right,
            bgColor: sortType == sortDeaths ? cardBackgroundColor: Colors.transparent),
        onTap: () {
          sortType = sortDeaths;
          isAscendingDeaths = !isAscendingDeaths;
          setState(() {
            isAscendingDeaths
                ? countries
                    .sort((a, b) => a.totalDeaths.compareTo(b.totalDeaths))
                : countries
                    .sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));
          });
        },
        onLongPress: () => _showToast(sTotalDeaths),
      ),
    ];
  }

  Widget _buildLeftSideItems(BuildContext context, int index) {
    final Country country = widget.covidSummary.countries[index];
    return InkWell(
      child: _buildText(country.country, textAlign: TextAlign.left),
      onTap: () => _showToast('${country.countryCode} - ${country.country}'),
    );
  }

  Widget _buildRightSideItems(BuildContext context, int index) {
    final Country country = widget.covidSummary.countries[index];
    final String strIODNC =
        country.newConfirmed != null && country.newConfirmed > 0 ? '+' : '';
    final String strIODNR =
        country.newRecovered != null && country.newRecovered > 0 ? '+' : '';
    final String strIODND =
        country.newDeaths != null && country.newDeaths > 0 ? '+' : '';

    final String totalConfirmed =
        getDecimalFormattedString('${country.totalConfirmed}');
    final String totalRecovered =
        getDecimalFormattedString('${country.totalRecovered}');
    final String totalDeaths =
        getDecimalFormattedString('${country.totalDeaths}');

    return Row(
      children: <Widget>[
        InkWell(
          child: _buildText(totalConfirmed, textAlign: TextAlign.right),
          onTap: () => _showToast(
              '${country.country} $sConfirmedNumber: $totalConfirmed ($strIODNC${country.newConfirmed})'),
        ),
        InkWell(
          child: _buildText(totalRecovered, textAlign: TextAlign.right),
          onTap: () => _showToast(
              '${country.country} $sTotalRecovered: $totalRecovered ($strIODNR${country.newRecovered})'),
        ),
        InkWell(
          child: _buildText(totalDeaths, textAlign: TextAlign.right),
          onTap: () => _showToast(
              '${country.country} $sTotalDeaths: $totalDeaths ($strIODND${country.newDeaths})'),
        ),
      ],
    );
  }

  Widget _buildText(String display,
      {TextAlign textAlign = TextAlign.right, Color textColor, Color bgColor}) {
    return Container(
      color: bgColor,
        width: _getColumnWidth(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(dDefaultPadding, dDefaultPadding * 2,
              dDefaultPadding, dDefaultPadding * 2),
          child: Text(
            display,
            textAlign: textAlign,
            style: TextStyle(color: textColor, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toastBackgroundColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  double _getColumnWidth() {
    return (MediaQuery.of(context).size.width) / _totalRows;
  }
}
