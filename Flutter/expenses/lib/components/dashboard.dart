import 'package:expenses/components/chart.dart';
import 'package:expenses/models/chart_data.dart';
import 'package:expenses/models/register.dart';
import 'package:expenses/models/value_formatter.dart';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<ChartData> _data;
  late List<List<ChartData>> _dataValues;

  late DateTime _initialDate;
  late DateTime _lastDate;

  late DateTime _currentDate;

  late String _title;
  late String _subtitle;
  late String _legend;
  late String _footer;

  final ScrollController _scrollController = ScrollController();

  final Map<int, Function> _totals = {
    0: Register.getTotalDay,
    1: Register.getTotalWeek,
    2: Register.getTotalMonth,
    3: Register.getTotalYear,
  };

  final Map<int, String> _periodName = {
    0: 'Day',
    1: 'Week',
    2: 'Month',
    3: 'Year',
    4: 'Total',
  };

  int _selectedTotal = 1;
  int _selectedPeriod = 0;
  int _selectedStackPeriod = -2;
  bool _selectedEmpty = false;

  @override
  void initState() {
    _data = [];
    _dataValues = [];

    _initialDate = Register.byDate.first.dateTime;
    _lastDate = Register.byDate.last.dateTime;

    _currentDate = _initialDate;

    _title = Register.indexFullMonth(_currentDate.month)!;
    _subtitle = _currentDate.year.toString();
    _legend = _periodName[_selectedTotal]!;
    _footer = Register.indexFullWeek(_currentDate.weekday)!;

    _updateDataMap();

    _scrollController.addListener(_updateLabelOnScroll);

    super.initState();
  }

  int get _day => _currentDate.day;
  int get _week => _currentDate.weekday;
  int get _month => _currentDate.month;
  int get _year => _currentDate.year;

  String get _weekName => Register.indexWeek(_week)!;
  String get _fullWeekName => Register.indexFullWeek(_week)!;

  String get _monthName => Register.indexMonth(_month)!;
  String get _fullMonthName => Register.indexFullMonth(_month)!;

  DateTime _nextDay() => _currentDate.add(Duration(days: 1));
  DateTime _nextWeek() => _endWeek().add(Duration(days: 1));
  DateTime _nextMonth() => DateTime(_year, _month + 1);
  DateTime _nextYear() => DateTime(_year + 1);

  DateTime _startWeek() {
    DateTime startWeek = _currentDate.subtract(Duration(days: _week - 1));
    return (startWeek.month != _month) ? DateTime(_year, _month) : startWeek;
  }

  DateTime _endWeek() {
    DateTime endWeek = _startWeek().add(Duration(days: 7));
    return (endWeek.month != _month)
        ? DateTime(_year, _month + 1, 0)
        : endWeek.subtract(Duration(days: endWeek.weekday));
  }

  DateTime _startMonth() => DateTime(_year, _month);
  DateTime _endMonth() => DateTime(_year, _month + 1).add(Duration(days: -1));

  DateTime _startYear() => DateTime(_year);
  DateTime _endYear() => DateTime(_year + 1).add(Duration(days: -1));

  String _periodLabel() {
    switch (_selectedPeriod) {
      case 0:
        return _day.toString();
      case 1:
        return _weekName;
      case 2:
        return _monthName;
      case 3:
        return _year.toString();
      default:
        return _day.toString();
    }
  }

  List<Register> _periodRegister() {
    switch (_selectedStackPeriod) {
      case -1:
      case 0:
        switch (_selectedPeriod) {
          case 0:
            return Register.dateFilter(
                initialDate: _currentDate, finalDate: _currentDate);
          case 1:
            return Register.dateFilter(
                initialDate: _startWeek(), finalDate: _endWeek());
          case 2:
            return Register.dateFilter(
                initialDate: _startMonth(), finalDate: _endMonth());
          case 3:
            return Register.dateFilter(
                initialDate: _startYear(), finalDate: _endYear());
          default:
            return List.empty();
        }
      case 1:
        return Register.dateFilter(
            initialDate: _startWeek(), finalDate: _endWeek());
      case 2:
        return Register.dateFilter(
            initialDate: _startMonth(), finalDate: _endMonth());
      case 3:
        return Register.dateFilter(
            initialDate: _startYear(), finalDate: _endYear());
      default:
        return List.empty();
    }
  }

  double _total(DateTime dateTime) {
    return (_selectedTotal == _totals.length)
        ? Register.total
        : _totals[_selectedTotal]!(dateTime);
  }

  double _value(DateTime dateTime) {
    return _totals[_selectedPeriod]!(dateTime);
  }

  double _percentage() {
    double value = _value(_currentDate);
    double total = _total(_currentDate);

    return (value == 0.0 || total == 0.0) ? 0.0 : value / total;
  }

  void _nextPeriod() {
    setState(() {
      switch (_selectedPeriod) {
        case 0:
          _currentDate = _nextDay();
        case 1:
          _currentDate = _nextWeek();
        case 2:
          _currentDate = _nextMonth();
        case 3:
          _currentDate = _nextYear();
        default:
          _currentDate = _initialDate;
      }
    });
  }

  void _selectTotal() {
    setState(() {
      _selectedTotal++;

      _selectedTotal = (_selectedTotal % (_totals.length + 1)) > _selectedPeriod
          ? _selectedTotal % (_totals.length + 1)
          : _selectedPeriod + 1;
    });

    _updateHeader();
    _updateDataMap();
  }

  void _selectPeriod() {
    setState(() {
      _selectedPeriod = ++_selectedPeriod % _totals.length;
    });

    _selectTotal();
  }

  void _selectStackPeriod() {
    setState(() {
      (_selectedStackPeriod + 1 >= _selectedPeriod)
          ? _selectedStackPeriod = -2
          : _selectedStackPeriod++;
    });

    _updateDataMap();
  }

  void _selectEmpty() {
    setState(() {
      _selectedEmpty = !_selectedEmpty;
    });

    _updateDataMap();
  }

  void _clearDataMap() {
    setState(() {
      _data.clear();
      _dataValues.clear();
    });
  }

  void _updateHeader() {
    setState(() {
      _legend = _periodName[_selectedTotal]!;
    });
  }

  void _updateDataMap() {
    _clearDataMap();

    setState(() {
      _currentDate = _initialDate;

      while (_currentDate.isBefore(_lastDate) ||
          _currentDate.isAtSameMomentAs(_lastDate)) {
        double percentage = _percentage();

        if (_selectedEmpty ? percentage != 0.0 : !_selectedEmpty) {
          _data.add(
            ChartData(
              percentage,
              title: _selectedPeriod < 2 ? _fullMonthName : _year.toString(),
              subtitle: _selectedPeriod < 3
                  ? _year.toString()
                  : _selectedPeriod >= 4
                      ? null
                      : _fullMonthName,
              legend: _periodName[_selectedTotal]!,
              topLabel: ValueFormatter(_total(_currentDate)).toString(),
              bottomLabel: _periodLabel(),
              footer: _fullWeekName,
            ),
          );

          _dataValues.add([]);

          if (_selectedStackPeriod != -2) {
            DateTime lastRegister = _currentDate.subtract(Duration(days: 1));

            for (Register register in _periodRegister()) {
              if (_selectedStackPeriod == -1) {
                _dataValues.last.add(ChartData(
                    register.value.toDouble() /
                        _totals[_selectedPeriod]!(register.dateTime),
                    bottomLabel: register.dateTime.toString()));
              } else if (!lastRegister.isAtSameMomentAs(register.dateTime)) {
                lastRegister = register.dateTime;

                _dataValues.last.add(ChartData(
                    _totals[_selectedStackPeriod]!(register.dateTime) /
                        _totals[_selectedPeriod]!(register.dateTime),
                    bottomLabel: register.dateTime.toString()));
              }
            }
          }
        }

        _nextPeriod();
      }
    });
  }

  void _updateLabelOnScroll() {
    double offset = _scrollController.offset;
    double itemHeight = 100.0;
    int index = (offset / itemHeight).round();

    if (index >= 0 && index < _data.length) {
      setState(() {
        _title = _data[index].title ?? '';
        _subtitle = _data[index].subtitle ?? '';
        _footer = _data[index].footer ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 350,
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Center(
            child: Card(
              elevation: 5,
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text(
                                  _subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  _title,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FittedBox(
                                child: Text(
                                  _legend,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Chart(
                      _data,
                      dataValues: _dataValues,
                      randomColor: true,
                      defaultColor: true,
                      scrollController: _scrollController,
                      width: 400,
                      height: 170,
                      barHeight: 90,
                      barColor: Theme.of(context).colorScheme.primary,
                      darkMode: Theme.of(context).brightness == Brightness.dark,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  _footer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _selectTotal,
                  mini: true,
                  shape: CircleBorder(),
                  child: Icon(Icons.percent_rounded),
                ),
                FloatingActionButton(
                  onPressed: _selectPeriod,
                  mini: true,
                  shape: CircleBorder(),
                  child: Icon(Icons.calendar_today_rounded),
                ),
                FloatingActionButton(
                  onPressed: _selectStackPeriod,
                  mini: true,
                  shape: CircleBorder(),
                  child: Icon(Icons.stacked_bar_chart_rounded),
                ),
                FloatingActionButton(
                  onPressed: _selectEmpty,
                  mini: true,
                  shape: CircleBorder(),
                  child: Icon(
                    _selectedEmpty ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
