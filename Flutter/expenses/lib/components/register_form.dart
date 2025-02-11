import 'package:expenses/models/value_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/register.dart';

class RegisterForm extends StatefulWidget {
  static final String title = 'Expense Register';

  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _labelFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  DateTime _selectedDate = DateTime.now();
  int _selectedPaymentMethod = 0;
  int _selectedCoinType = 0;

  final int _maxNameLength = 50;
  final int _maxLabelLength = 30;
  final int _maxDescriptionLength = 200;
  final int _firstDate = 1999;
  final double _minAmount = 0.0;
  final String _deafultLabelInput = 'All';
  final String _dateFormat = 'yyyy/MM/dd';
  final String _deafultDescriptionInput = '';

  final String _nameLabelText = 'Name';
  final String _labelLabelText = 'Label';
  final String _amountLabelText = 'Amount';
  final String _dateLabelText = 'Date';
  final String _descriptionLabelText = 'Description';

  final String _nameHintText = 'Groceries';
  final String _labelHintText = 'Food';
  final String _amountHintText = '150.00';
  final String _dateHintText = DateFormat('yyyy/MM/dd').format(DateTime.now());
  final String _descriptionHintText =
      'Monthly grocery shopping including fruits, vegetables, and snacks...';

  final Map<String, String?> _validFields = {
    'Name': null,
    'Label': null,
    'Amount': null,
    'Date': null,
    'Description': null,
  };

  String get title => RegisterForm.title;

  double get _amount =>
      double.tryParse(
        _amountController.text
            .replaceAllMapped(RegExp(r'\.(?=.*\.)'), (match) => ''),
      ) ??
      _minAmount;

  String get _label => _labelController.text.isEmpty
      ? _deafultLabelInput
      : _labelController.text;

  String get _description => _descriptionController.text.isEmpty
      ? _deafultDescriptionInput
      : _descriptionController.text;

  void _close(BuildContext context) => Navigator.of(context).pop();

  String? _validateField(TextEditingController controller, String labelField) {
    setState(
      () {
        _validFields[labelField] = controller.text.isEmpty
            ? 'The $labelField field is required'
            : null;
      },
    );
    return _validFields[labelField];
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      setState(
        () {
          Register(
            ValueFormatter(_amount),
            _nameController.text,
            _label,
            _selectedDate,
            description: _description,
            payment: _selectedPaymentMethod,
            coin: _selectedCoinType,
            status: true,
            toAdd: true,
          );
        },
      );

      _close(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: _dateController.text.isEmpty
          ? _selectedDate
          : DateFormat(_dateFormat).parse(_dateController.text),
      firstDate: DateTime(_firstDate),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate != null) {
          setState(
            () {
              _selectedDate = pickedDate;
              _dateController.text = DateFormat(_dateFormat).format(pickedDate);
            },
          );
        }
      },
    );
  }

  String _inputDateFormatter(String input) {
    input = input.replaceAll(RegExp(r'[^0-9]'), '');

    if (input.length > 8) {
      input = input.substring(0, 8);
    }

    if (input.length >= 4) {
      input = '${input.substring(0, 4)}/${input.substring(4)}';
    }

    if (input.length >= 7) {
      input = '${input.substring(0, 7)}/${input.substring(7)}';
    }

    if (input.endsWith('/')) {
      input = input.substring(0, input.length - 1);
    }

    return input;
  }

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(15),
        content: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Title(
                      color: Colors.black,
                      title: title,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 500,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 600,
                      width: double.maxFinite,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              textInputAction: TextInputAction.next,
                              maxLength: _maxNameLength,
                              decoration: InputDecoration(
                                errorText: _validFields[_nameLabelText],
                                counterText: '',
                                labelText: _nameLabelText,
                                hintText: _nameHintText,
                                prefixIcon: Icon(Icons.receipt_long),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) => _validateField(
                                _nameController,
                                _nameLabelText,
                              ),
                              onFieldSubmitted: (value) {
                                _validateField(
                                  _nameController,
                                  _nameLabelText,
                                );
                                FocusScope.of(context)
                                    .requestFocus(_labelFocusNode);
                              },
                              validator: (value) => _validateField(
                                _nameController,
                                _nameLabelText,
                              ),
                            ),
                            TextFormField(
                              controller: _labelController,
                              focusNode: _labelFocusNode,
                              textInputAction: TextInputAction.next,
                              maxLength: _maxLabelLength,
                              decoration: InputDecoration(
                                errorText: _validFields[_labelLabelText],
                                counterText: '',
                                labelText: _labelLabelText,
                                hintText: _labelHintText,
                                prefixIcon: Icon(Icons.label),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _labelController.text = value;
                                });
                              },
                              onFieldSubmitted: (value) {
                                setState(() {
                                  _labelController.text = value;
                                });

                                FocusScope.of(context)
                                    .requestFocus(_amountFocusNode);
                              },
                            ),
                            TextFormField(
                              controller: _amountController,
                              focusNode: _amountFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                errorText: _validFields[_labelLabelText],
                                labelText: _amountLabelText,
                                hintText: _amountHintText,
                                prefixIcon: Icon(
                                    (Register.coinTypes[_selectedCoinType]
                                        ?['Icon'] as IconData)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _amountController.text =
                                      _inputAmountFormatter(value);
                                });

                                _validateField(
                                  _amountController,
                                  _amountLabelText,
                                );
                              },
                              onFieldSubmitted: (value) {
                                _validateField(
                                  _amountController,
                                  _amountLabelText,
                                );

                                FocusScope.of(context)
                                    .requestFocus(_dateFocusNode);
                              },
                              validator: (value) => _validateField(
                                _amountController,
                                _amountLabelText,
                              ),
                            ),
                            TextFormField(
                              controller: _dateController,
                              focusNode: _dateFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorText: _validFields[_dateLabelText],
                                labelText: _dateLabelText,
                                hintText: _dateHintText,
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _dateController.text =
                                      _inputDateFormatter(value);
                                });

                                _validateField(
                                  _dateController,
                                  _dateLabelText,
                                );
                              },
                              onFieldSubmitted: (value) {
                                setState(() {
                                  _dateController.text = DateFormat(_dateFormat)
                                      .format(_selectedDate);
                                });

                                _validateField(
                                  _dateController,
                                  _dateLabelText,
                                );

                                FocusScope.of(context)
                                    .requestFocus(_descriptionFocusNode);
                              },
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              focusNode: _descriptionFocusNode,
                              textInputAction: TextInputAction.next,
                              maxLines: 4,
                              maxLength: _maxDescriptionLength,
                              decoration: InputDecoration(
                                errorText: _validFields[_descriptionLabelText],
                                labelText: _descriptionLabelText,
                                hintText: _descriptionHintText,
                                prefixIcon: Icon(Icons.comment),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _descriptionController.text = value;
                                });
                              },
                              onFieldSubmitted: (value) {
                                setState(() {
                                  _descriptionController.text = value;
                                });

                                FocusScope.of(context)
                                    .requestFocus(_descriptionFocusNode);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Methods: ${Register.paymentMethods[_selectedPaymentMethod]?['Name']}',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Register.paymentMethods.length,
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    return CheckboxMenuButton(
                                      value: _selectedPaymentMethod == index,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _selectedPaymentMethod =
                                              value! ? index : 0;
                                        });
                                      },
                                      child: Icon(
                                          (Register.paymentMethods[index]
                                              ?['Icon'] as IconData)),
                                    );
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Types Coins: ${Register.coinTypes[_selectedCoinType]?['Name']}',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Register.coinTypes.length,
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    return CheckboxMenuButton(
                                      value: _selectedCoinType == index,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _selectedCoinType =
                                              value! ? index : 0;
                                        });
                                      },
                                      child: Icon((Register.coinTypes[index]
                                          ?['Icon'] as IconData)),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      mini: true,
                      onPressed: () => _close(context),
                      child: Icon(Icons.close),
                    ),
                    FloatingActionButton(
                      mini: true,
                      onPressed: () => _register(),
                      child: Icon(Icons.check),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
