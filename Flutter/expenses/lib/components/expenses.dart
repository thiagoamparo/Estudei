import 'package:expenses/components/dashboard.dart';
import 'package:expenses/components/register_card.dart';
import 'package:expenses/components/register_form.dart';
import 'package:expenses/models/register.dart';
import 'package:expenses/models/value_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpensesApp extends StatefulWidget {
  final String title = 'Expenses App';
  final String subTitle = 'Control Your Expenses!';
  final VoidCallback toggleTheme;

  ExpensesApp({required this.toggleTheme, super.key});

  final List<Register> sampleRegisters = [
    Register(
      ValueFormatter(100.0),
      'Groceries',
      'Food',
      DateTime(2025, 1, 1),
      description: 'Weekly grocery shopping',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(250.0),
      'Electricity Bill',
      'Utilities',
      DateTime(2025, 1, 1),
      description: 'Payment for the electricity bill of January',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(50.0),
      'Coffee Shop',
      'Food',
      DateTime(2025, 1, 1),
      description: 'Coffee and snacks with friends',
      payment: 0, // Others
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(500.0),
      'Laptop Purchase',
      'Electronics',
      DateTime(2025, 1, 1),
      description: 'Bought a new laptop',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(120.0),
      'Gym Membership',
      'Health',
      DateTime(2025, 1, 2),
      description: 'Monthly subscription for the gym',
      payment: 4, // Digital Wallet
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'Dinner with Family',
      'Food',
      DateTime(2025, 1, 2),
      description: 'Family dinner at a restaurant',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(90.0),
      'Movie Tickets',
      'Entertainment',
      DateTime(2025, 1, 2),
      description: 'Tickets for a movie',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Fuel',
      'Transport',
      DateTime(2025, 1, 2),
      description: 'Fuel for the car',
      payment: 5, // Check
      coin: 9, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(80.0),
      'Books',
      'Education',
      DateTime(2025, 3, 9),
      description: 'Bought some educational books',
      payment: 0, // Others
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Internet Bill',
      'Utilities',
      DateTime(2025, 3, 10),
      description: 'Payment for internet services',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Internet Bill',
      'Utilities',
      DateTime(2024, 12, 31),
      description: 'Payment for internet services',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Electricity Bill',
      'Utilities',
      DateTime(2025, 1, 12),
      description: 'Electricity payment for January',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'Groceries',
      'Shopping',
      DateTime(2025, 1, 13),
      description: 'Monthly grocery shopping',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(50.0),
      'Coffee Shop',
      'Leisure',
      DateTime(2025, 1, 14),
      description: 'Coffee with friends',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(500.0),
      'Laptop Purchase',
      'Electronics',
      DateTime(2025, 1, 15),
      description: 'New laptop for work',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(120.0),
      'Gym Membership',
      'Health',
      DateTime(2025, 1, 25),
      description: 'Monthly membership fee',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(80.0),
      'Books',
      'Education',
      DateTime(2025, 1, 5),
      description: 'Purchased study materials',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(250.0),
      'Dinner with Family',
      'Leisure',
      DateTime(2025, 1, 18),
      description: 'Family dinner at a restaurant',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(90.0),
      'Movie Tickets',
      'Leisure',
      DateTime(2025, 1, 12),
      description: 'Cinema with friends',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'Home Renovation',
      'Home',
      DateTime(2025, 1, 3),
      description: 'Bought materials for renovation',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Fuel',
      'Transport',
      DateTime(2025, 1, 22),
      description: 'Car refueling',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Groceries',
      'Shopping',
      DateTime(2025, 1, 2),
      description: 'Grocery shopping for the week',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(600.0),
      'TV Purchase',
      'Electronics',
      DateTime(2025, 1, 9),
      description: 'Bought a new television',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(50.0),
      'Subscription',
      'Entertainment',
      DateTime(2025, 1, 11),
      description: 'Monthly streaming subscription',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(700.0),
      'Vacation Booking',
      'Travel',
      DateTime(2025, 1, 6),
      description: 'Paid for family vacation',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'School Fees',
      'Education',
      DateTime(2025, 1, 14),
      description: 'Paid for school semester',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Maintenance',
      'Transport',
      DateTime(2025, 1, 16),
      description: 'Car servicing',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(400.0),
      'Medical Bills',
      'Health',
      DateTime(2025, 1, 28),
      description: 'Paid for health check-up',
      payment: 3, // Bank Transfer
      coin: 10, // BRL (Real)
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(250.0),
      'Appliance Repair',
      'Home',
      DateTime(2025, 1, 19),
      description: 'Repaired washing machine',
      payment: 2, // Card
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Gifts',
      'Special Occasion',
      DateTime(2025, 1, 4),
      description: 'Bought gifts for family',
      payment: 1, // Cash
      coin: 10, // BRL (Real)
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Internet Bill',
      'Utilities',
      DateTime(2024, 12, 30),
      description: 'Payment for internet services',
      payment: 3,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Electricity Bill',
      'Utilities',
      DateTime(2025, 1, 15),
      description: 'Electricity payment for January',
      payment: 1,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'Groceries',
      'Shopping',
      DateTime(2025, 2, 10),
      description: 'Monthly grocery shopping',
      payment: 2,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(50.0),
      'Coffee Shop',
      'Leisure',
      DateTime(2023, 11, 8),
      description: 'Coffee with friends',
      payment: 1,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(500.0),
      'Laptop Purchase',
      'Electronics',
      DateTime(2023, 9, 20),
      description: 'New laptop for work',
      payment: 2,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(120.0),
      'Gym Membership',
      'Health',
      DateTime(2024, 3, 25),
      description: 'Monthly membership fee',
      payment: 1,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(80.0),
      'Books',
      'Education',
      DateTime(2022, 5, 5),
      description: 'Purchased study materials',
      payment: 2,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(250.0),
      'Dinner with Family',
      'Leisure',
      DateTime(2023, 7, 18),
      description: 'Family dinner at a restaurant',
      payment: 1,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(90.0),
      'Movie Tickets',
      'Leisure',
      DateTime(2024, 6, 12),
      description: 'Cinema with friends',
      payment: 1,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'Home Renovation',
      'Home',
      DateTime(2025, 4, 3),
      description: 'Bought materials for renovation',
      payment: 3,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Fuel',
      'Transport',
      DateTime(2025, 5, 22),
      description: 'Car refueling',
      payment: 2,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Groceries',
      'Shopping',
      DateTime(2024, 1, 2),
      description: 'Grocery shopping for the week',
      payment: 1,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(600.0),
      'TV Purchase',
      'Electronics',
      DateTime(2023, 10, 9),
      description: 'Bought a new television',
      payment: 2,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(50.0),
      'Subscription',
      'Entertainment',
      DateTime(2024, 8, 11),
      description: 'Monthly streaming subscription',
      payment: 2,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(700.0),
      'Vacation Booking',
      'Travel',
      DateTime(2022, 12, 6),
      description: 'Paid for family vacation',
      payment: 3,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(300.0),
      'School Fees',
      'Education',
      DateTime(2023, 2, 14),
      description: 'Paid for school semester',
      payment: 1,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(200.0),
      'Maintenance',
      'Transport',
      DateTime(2023, 5, 16),
      description: 'Car servicing',
      payment: 3,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(400.0),
      'Medical Bills',
      'Health',
      DateTime(2024, 9, 28),
      description: 'Paid for health check-up',
      payment: 3,
      coin: 10,
      status: true,
      toAdd: true,
    ),
    Register(
      ValueFormatter(250.0),
      'Appliance Repair',
      'Home',
      DateTime(2024, 10, 19),
      description: 'Repaired washing machine',
      payment: 2,
      coin: 10,
      status: false,
      toAdd: true,
    ),
    Register(
      ValueFormatter(150.0),
      'Gifts',
      'Special Occasion',
      DateTime(2022, 7, 4),
      description: 'Bought gifts for family',
      payment: 1,
      coin: 10,
      status: false,
      toAdd: true,
    ),
  ];

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _budgetFocusNode = FocusNode();
  final FocusNode _searchFocusNode = FocusNode();

  final String _budgetLabelText = 'Budget';
  final String _budgetHintText = '1.800.00';

  final String _searchLabelText = 'Search';
  final String _searchHintText = 'Groceries';

  final Map<String, String?> _validFields = {
    'Budget': null,
    'Search': null,
  };

  int _selectedFilter = 0;

  List<Register> expenses = [...Register.getRegistrar];
  List<Register> mainExpenses = [
    ...Register.byValue.reversed
  ]; // Resolver Depois

  VoidCallback get toggleTheme => widget.toggleTheme;

  double get budget =>
      double.tryParse(
        _budgetController.text
            .replaceAllMapped(RegExp(r'\.(?=.*\.)'), (match) => ''),
      ) ??
      0.0;

  String _inputAmountFormatter(String input) {
    input = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (input.isNotEmpty) {
      input = input.padLeft(3, '0');
      input =
          '${input.substring(0, input.length - 2)}.${input.substring(input.length - 2)}';

      List<String> inputSplit = input.split('.');

      String integer = (inputSplit[0].startsWith('0') && input.length > 4)
          ? inputSplit[0].replaceFirst('0', '')
          : inputSplit[0];

      String decimal =
          (inputSplit.length > 1) ? inputSplit[1].padRight(2, '0') : '00';

      integer = integer.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (Match match) => '${match[1]}.',
      );

      if (integer == '0' && decimal == '00') {
        return '';
      } else {
        return '$integer.$decimal';
      }
    } else {
      return '';
    }
  }

  void _openModalRegisterForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegisterForm();
      },
    ).then((onValue) {
      _updateExpenses();
    });
  }

  void _selectFilterType() {
    setState(() {
      _selectedFilter = ++_selectedFilter % 6;

      switch (_selectedFilter) {
        case 0:
          Register.onIndexSort();
          break;
        case 1:
          Register.onIndexSort(ascendant: false);
          break;
        case 2:
          Register.onDateSort();
          break;
        case 3:
          Register.onDateSort(ascendant: false);
          break;
        case 4:
          Register.onValueSort();
          break;
        case 5:
          Register.onValueSort(ascendant: false);
          break;
        default:
          Register.onIndexSort();
          break;
      }
    });

    _updateExpenses();
  }

  void _updateExpenses() {
    setState(() {
      expenses = [...Register.getRegistrar];
      mainExpenses = [...Register.byValue.reversed];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.brightness_5
                  : Icons.brightness_2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.5),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _budgetController,
                      focusNode: _budgetFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        errorText: _validFields[_budgetLabelText],
                        labelText: _budgetLabelText,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 14,
                        ),
                        hintText: _budgetHintText,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: _budgetController.text.isNotEmpty
                              ? Colors.green
                              : Colors.blueAccent,
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withValues(alpha: 0.1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _budgetController.text = _inputAmountFormatter(value);
                        });
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          _budgetController.text = _inputAmountFormatter(value);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Dashboard(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: 600,
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mainExpenses.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return RegisterCard(
                      mainExpenses[index],
                      _updateExpenses,
                      budget: budget,
                    );
                  },
                ),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              shadowColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              child: SizedBox(
                width: 300,
                height: 40,
                child: TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    errorText: _validFields[_searchLabelText],
                    labelText: _searchLabelText,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 14,
                    ),
                    hintText: _searchHintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: _searchController.text.isNotEmpty
                          ? Colors.blueAccent
                          : Colors.blueGrey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: _selectFilterType,
                      icon: Icon(
                        Icons.sort,
                        color: _searchController.text.isNotEmpty
                            ? Colors.blueAccent
                            : Colors.blueGrey,
                      ),
                    ),
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withValues(alpha: 0.1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchController.text = value;
                      expenses = [...Register.searchFilter(value)];
                    });
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      _searchController.text = value;
                      expenses = [...Register.searchFilter(value)];
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 800,
              height: 500,
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return RegisterCard(
                    expenses[index],
                    _updateExpenses,
                    longCard: true,
                    mainAxis: false,
                    badge: false,
                    budget: budget,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModalRegisterForm(context),
        tooltip: 'open',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
