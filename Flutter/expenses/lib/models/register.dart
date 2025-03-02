import 'package:expenses/models/value_formatter.dart';

import 'package:flutter/material.dart';

class Register {
  static final List<Register> _registrar = [];

  static const double _zero = 0.0;
  static double _total = 0.0;

  static final Map<int, Map<int, Map<int, Map<int, List<Register>>>>> dataMap =
      {};

  static final Map<int, Map<int, Map<int, Map<int, double>>>> totalDayMap = {};
  static final Map<int, Map<int, Map<int, double>>> totalWeekMap = {};
  static final Map<int, Map<int, double>> totalMonthMap = {};
  static final Map<int, double> totalYearMap = {};

  static final Map<int, String> weekNames = {
    DateTime.sunday: 'S',
    DateTime.monday: 'M',
    DateTime.tuesday: 'Tu',
    DateTime.wednesday: 'W',
    DateTime.thursday: 'Th',
    DateTime.friday: 'F',
    DateTime.saturday: 'Sa',
  };

  static final Map<int, String> fullWeekNames = {
    DateTime.sunday: 'Sunday',
    DateTime.monday: 'Monday',
    DateTime.tuesday: 'Tuesday',
    DateTime.wednesday: 'Wednesday',
    DateTime.thursday: 'Thursday',
    DateTime.friday: 'Friday',
    DateTime.saturday: 'Saturday',
  };

  static final Map<int, String> monthNames = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  static final Map<int, String> fullMonthNames = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  static const Map<int, String> priorityLevels = {
    1: "Nothing urgent for now... 😎",
    2: "Things are starting to get messy... 😬",
    3: "Hurry up, it’s going to get bad! 😨",
    4: "Brace yourself for the explosion! 💥",
  };

  static const Map<int, Map<String, Object>> paymentMethods = {
    0: {
      'Type': 'Others',
      'Icon': Icons.apps,
    },
    1: {
      'Type': 'Cash',
      'Icon': Icons.money_rounded,
    },
    2: {
      'Type': 'Card',
      'Icon': Icons.credit_card,
    },
    3: {
      'Type': 'Bank Transfer',
      'Icon': Icons.account_balance_rounded,
    },
    4: {
      'Type': 'Digital Wallet',
      'Icon': Icons.account_balance_wallet_rounded,
    },
    5: {
      'Type': 'Check',
      'Icon': Icons.payments_rounded,
    },
  };

  static const Map<int, Map<String, Object>> coinTypes = {
    0: {
      'Name': 'Others',
      'Code': 'Others',
      'Icon': Icons.monetization_on_outlined,
    },
    1: {
      'Name': 'Dollar',
      'Code': 'USD',
      'Icon': Icons.attach_money,
    },
    2: {
      'Name': 'Euro',
      'Code': 'EUR',
      'Icon': Icons.euro,
    },
    3: {
      'Name': 'Yen',
      'Code': 'JPY',
      'Icon': Icons.currency_yen,
    },
    4: {
      'Name': 'Yuan',
      'Code': 'CNY',
      'Icon': Icons.currency_yuan,
    },
    5: {
      'Name': 'Franc',
      'Code': 'CHF',
      'Icon': Icons.currency_franc,
    },
    6: {
      'Name': 'Lira',
      'Code': 'TRY',
      'Icon': Icons.currency_lira,
    },
    7: {
      'Name': 'Pound',
      'Code': 'GBP',
      'Icon': Icons.currency_pound,
    },
    8: {
      'Name': 'Ruble',
      'Code': 'RUB',
      'Icon': Icons.currency_ruble,
    },
    9: {
      'Name': 'Rupee',
      'Code': 'INR',
      'Icon': Icons.currency_rupee,
    },
    10: {
      'Name': 'Real',
      'Code': 'BRL',
      'Icon': Icons.money_rounded,
    },
  };

  final int index = _registrar.length;

  final ValueFormatter value;
  final String name;
  final String topic;
  final DateTime dateTime;

  final String description;
  final int priority;
  final int payment;
  final int coin;
  final bool status;
  final bool dateSort;
  final bool toAdd;

  final Map<int, Map<String, Object>> payments;
  final Map<int, Map<String, Object>> coins;
  final Map<int, String> priorities;

  Register(
    this.value,
    this.name,
    this.topic,
    this.dateTime, {
    this.description = '',
    this.priority = 0,
    this.payment = 0,
    this.coin = 0,
    this.status = false,
    this.dateSort = false,
    this.toAdd = false,
    this.payments = paymentMethods,
    this.coins = coinTypes,
    this.priorities = priorityLevels,
  }) {
    _buildDataMaps();

    if (toAdd) {
      _add(this, dateSort: dateSort);
      _total += value.toDouble();
    }
  }

  int get year => dateTime.year;
  int get month => dateTime.month;
  int get week => dateTime.weekday;
  int get day => dateTime.day;

  String get weekDay => weekNames[dateTime.weekday]!;
  String get fullWeekDay => fullWeekNames[dateTime.weekday]!;

  String get monthDay => monthNames[dateTime.month]!;
  String get fullMonthDay => fullMonthNames[dateTime.month]!;

  List<Register> get registrar => [..._registrar];

  String get paymentType => (payments[payment]?['Type'] as String);
  IconData get paymentIcon => (payments[payment]?['Icon'] as IconData);

  String get coinName => (coins[coin]?['Name'] as String);
  String get coinCode => (coins[coin]?['Code'] as String);
  IconData get coinIcon => (coins[coin]?['Icon'] as IconData);

  void _buildDataMaps() {
    _buildWeekDataMap();

    _buildTotalDayDataMap();
    _buildTotalWeekDataMap();
    _buildTotalMonthDataMap();
    _buildTotalYearDataMap();
  }

  void _buildWeekDataMap() {
    if (!dataMap.containsKey(dateTime.year)) {
      DateTime currentDate = DateTime(dateTime.year, 1, 1);
      DateTime lastDate = DateTime(dateTime.year, 12, 31);

      while (currentDate.isBefore(lastDate.add(Duration(days: 1)))) {
        int year = currentDate.year;
        int month = currentDate.month;
        int weekday = currentDate.weekday;
        int day = currentDate.day;

        dataMap.putIfAbsent(year, () => {});
        dataMap[year]!.putIfAbsent(month, () => {});
        dataMap[year]![month]!.putIfAbsent(weekday, () => {});
        dataMap[year]![month]![weekday]!.putIfAbsent(day, () => []);

        currentDate = currentDate.add(Duration(days: 1));
      }
    }
  }

  void _weekDataMapAdd() {
    dataMap[year]![month]![week]![day]!.add(this);
  }

  void _buildTotalDayDataMap() {
    if (totalDayMap.containsKey(year) &&
        totalDayMap[year]!.containsKey(month) &&
        totalDayMap[year]![month]!.containsKey(week) &&
        totalDayMap[year]![month]![week]!.containsKey(day)) {
      totalDayMap[year]![month]![week]![day] =
          totalDayMap[year]![month]![week]![day]! + value.toDouble();
    } else {
      totalDayMap.putIfAbsent(year, () => {});
      totalDayMap[year]!.putIfAbsent(month, () => {});
      totalDayMap[year]![month]!.putIfAbsent(week, () => {});
      totalDayMap[year]![month]![week]!
          .putIfAbsent(day, () => value.toDouble());
    }
  }

  void _buildTotalWeekDataMap() {
    if (totalWeekMap.containsKey(year) &&
        totalWeekMap[year]!.containsKey(month) &&
        totalWeekMap[year]![month]!.containsKey(week)) {
      totalWeekMap[year]![month]![week] =
          totalWeekMap[year]![month]![week]! + value.toDouble();
    } else {
      totalWeekMap.putIfAbsent(year, () => {});
      totalWeekMap[year]!.putIfAbsent(month, () => {});
      totalWeekMap[year]![month]!.putIfAbsent(week, () => value.toDouble());
    }
  }

  void _buildTotalMonthDataMap() {
    if (totalMonthMap.containsKey(year) &&
        totalMonthMap[year]!.containsKey(month)) {
      totalMonthMap[year]![month] =
          totalMonthMap[year]![month]! + value.toDouble();
    } else {
      totalMonthMap.putIfAbsent(year, () => {});
      totalMonthMap[year]!.putIfAbsent(month, () => value.toDouble());
    }
  }

  void _buildTotalYearDataMap() {
    if (totalYearMap.containsKey(year)) {
      totalYearMap[year] = totalYearMap[year]! + value.toDouble();
    } else {
      totalYearMap.putIfAbsent(year, () => value.toDouble());
    }
  }

  void _add(Register register, {bool dateSort = false}) {
    if (dateSort) {
      if (_registrar.isEmpty) {
        _registrar.add(register);
      } else {
        int index = _registrar.indexWhere(
            (existing) => register.dateTime.isBefore(existing.dateTime));

        if (index == -1) {
          _registrar.add(register);
        } else {
          _registrar.insert(index, register);
        }
      }
    } else {
      _registrar.add(register);
    }

    _weekDataMapAdd();
  }

  void remove() => _registrar.removeAt(index);

  static double getTotalDay(DateTime dateTime) {
    if (totalDayMap.containsKey(dateTime.year) &&
        totalDayMap[dateTime.year]!.containsKey(dateTime.month) &&
        totalDayMap[dateTime.year]![dateTime.month]!
            .containsKey(dateTime.weekday) &&
        totalDayMap[dateTime.year]![dateTime.month]![dateTime.weekday]!
            .containsKey(dateTime.day)) {
      return totalDayMap[dateTime.year]![dateTime.month]![dateTime.weekday]![
          dateTime.day]!;
    } else {
      return _zero;
    }
  }

  static double getTotalWeek(DateTime dateTime) {
    if (totalWeekMap.containsKey(dateTime.year) &&
        totalWeekMap[dateTime.year]!.containsKey(dateTime.month) &&
        totalWeekMap[dateTime.year]![dateTime.month]!
            .containsKey(dateTime.weekday)) {
      return totalWeekMap[dateTime.year]![dateTime.month]![dateTime.weekday]!;
    } else {
      return _zero;
    }
  }

  static double getTotalMonth(DateTime dateTime) {
    if (totalMonthMap.containsKey(dateTime.year) &&
        totalMonthMap[dateTime.year]!.containsKey(dateTime.month)) {
      return totalMonthMap[dateTime.year]![dateTime.month]!;
    } else {
      return _zero;
    }
  }

  static double getTotalYear(DateTime dateTime) {
    if (totalYearMap.containsKey(dateTime.year)) {
      return totalYearMap[dateTime.year]!;
    } else {
      return _zero;
    }
  }

  static String? indexWeek(int week) => weekNames[week];
  static String? indexFullWeek(int week) => fullWeekNames[week];

  static String? indexMonth(int month) => monthNames[month];
  static String? indexFullMonth(int month) => fullMonthNames[month];

  static double get total => _total;

  static List<Register> get getRegistrar => [..._registrar];

  static List<Register> get byIndex =>
      List.from(_registrar)..sort((a, b) => a.index.compareTo(b.index));

  static List<Register> get byDate =>
      List.from(_registrar)..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  static List<Register> get byValue => List.from(_registrar)
    ..sort((a, b) => a.value.toDouble().compareTo(b.value.toDouble()));

  static void onIndexSort({bool ascendant = true}) => ascendant
      ? _registrar.sort((a, b) => a.index.compareTo(b.index))
      : _registrar.sort((a, b) => b.index.compareTo(a.index));

  static void onDateSort({bool ascendant = true}) => ascendant
      ? _registrar.sort((a, b) => a.dateTime.compareTo(b.dateTime))
      : _registrar.sort((a, b) => b.dateTime.compareTo(a.dateTime));

  static void onValueSort({bool ascendant = true}) => ascendant
      ? _registrar
          .sort((a, b) => a.value.toDouble().compareTo(b.value.toDouble()))
      : _registrar
          .sort((a, b) => b.value.toDouble().compareTo(a.value.toDouble()));

  static void addRegister(Register register) => _registrar.add(register);
  static void removeRegister(int index) => _registrar.removeAt(index);
  static void clearRegistrar() => _registrar.clear();

  static List<Register> getDayDataMap(DateTime dateTime) {
    if (dataMap.containsKey(dateTime.year) &&
        dataMap[dateTime.year]!.containsKey(dateTime.month) &&
        dataMap[dateTime.year]![dateTime.month]!
            .containsKey(dateTime.weekday) &&
        dataMap[dateTime.year]![dateTime.month]![dateTime.weekday]!
            .containsKey(dateTime.day)) {
      return dataMap[dateTime.year]![dateTime.month]![dateTime.weekday]![
          dateTime.day]!;
    } else {
      return List.empty(growable: true);
    }
  }

  static List<Register> searchFilter(String? value) {
    return _registrar.where((register) {
      final matchesName = value == null ||
          register.name.toLowerCase().contains(value.toLowerCase());

      final matchesLabel = value == null ||
          register.topic.toLowerCase().contains(value.toLowerCase());

      final matchesValue = value == null ||
          register.value
              .toDouble()
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase());

      return matchesName || matchesLabel || matchesValue;
    }).toList();
  }

  static List<Register> dateFilter({
    DateTime? initialDate,
    DateTime? finalDate,
  }) {
    return byDate.where((register) {
      final datesMatches = (initialDate == null ||
              register.dateTime.isAfter(initialDate) ||
              register.dateTime.isAtSameMomentAs(initialDate)) &&
          (finalDate == null ||
              register.dateTime.isBefore(finalDate) ||
              register.dateTime.isAtSameMomentAs(finalDate));

      return datesMatches;
    }).toList();
  }
}
