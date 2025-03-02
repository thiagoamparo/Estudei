import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expenses/components/dashboard.dart';
import 'package:expenses/components/register_card.dart';
import 'package:expenses/components/register_form.dart';
import 'package:expenses/models/register.dart';

class ExpensesApp extends StatefulWidget {
  final String title = 'Expenses App';
  final String subTitle = 'Control Your Expenses!';
  final VoidCallback toggleTheme;

  const ExpensesApp({required this.toggleTheme, super.key});

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
  List<Register> mainExpenses =
      [...Register.byValue.take(10)].reversed.toList();

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
      mainExpenses = [...Register.byValue.take(10)].reversed.toList();
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
        child: expenses.isNotEmpty
            ? Column(
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
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
                                _budgetController.text =
                                    _inputAmountFormatter(value);
                              });
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                _budgetController.text =
                                    _inputAmountFormatter(value);
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
                    shadowColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.5),
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
              )
            : Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Image.asset('assets/images/sleeping_koala.png'),
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
