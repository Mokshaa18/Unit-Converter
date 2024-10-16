// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class UnitConverterApp extends StatefulWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  _UnitConverterAppState createState() => _UnitConverterAppState();
}

class _UnitConverterAppState extends State<UnitConverterApp> {
  double _inputValue = 0.0;
  String _convertedValue = '';

  String _selectedCategory = 'Weight';
  String _fromUnit = 'Grams';
  String _toUnit = 'Kilograms';

  final Map<String, Map<String, double>> _conversionFactors = {
    'Weight': {
      'Milligrams': 0.001,
      'Grams': 1.0,
      'Kilograms': 1000.0,
      'Pounds': 453.592,
      'Tons': 1000000.0,
    },
    'Length': {
      'Millimeters': 0.001,
      'Centimeters': 0.01,
      'Meters': 1.0,
      'Kilometers': 1000.0,
      'Miles': 1609.34,
    },
    'Temperature': {
      'Celsius': 1.0,
      'Fahrenheit': 1.8,
      'Kelvin': 273.15,
    },
    'Volume': {
      'Milliliters': 0.001,
      'Liters': 1.0,
      'Gallons': 4.54609,
    },
  };

  final List<String> _categories = ['Weight', 'Length', 'Temperature', 'Volume'];

 // Function for unit conversion
  void _convert() {
    double convertedValue = 0.0;

    if (_selectedCategory == 'Temperature') {
      // Handle temperature conversions with specific formulas
      if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
        convertedValue = (_inputValue * 9 / 5) + 32;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
        convertedValue = (_inputValue - 32) * 5 / 9;
      } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
        convertedValue = _inputValue + 273.15;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
        convertedValue = _inputValue - 273.15;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
        convertedValue = (_inputValue - 32) * 5 / 9 + 273.15;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
        convertedValue = (_inputValue - 273.15) * 9 / 5 + 32;
      }
    } else {
      // Handle all other categories (Weight, Length, Volume, etc.)
      double conversionFactorFrom = _conversionFactors[_selectedCategory]![_fromUnit]!;
      double conversionFactorTo = _conversionFactors[_selectedCategory]![_toUnit]!;

      // Perform conversion using the general formula
      convertedValue = _inputValue * (conversionFactorFrom / conversionFactorTo);
    }

    // Update the state with the converted value
    setState(() {
      _convertedValue = convertedValue.toStringAsFixed(6); // Show up to 6 decimal places
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text(
          'Unit Converter',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.brown,
        toolbarHeight: 80.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Category Dropdown using DropdownButton2
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'Select Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  items: _categories
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Center(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                      _fromUnit = _conversionFactors[_selectedCategory]!.keys.first;
                      _toUnit = _conversionFactors[_selectedCategory]!.keys.last;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown.shade100,
                    ),
                    maxHeight: 200,
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35.0),

            // Input field for the value to convert
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter value',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.number,
              cursorColor: Colors.white30,
              onChanged: (String value) {
                _inputValue = double.tryParse(value) ?? 0.0;
              },
            ),


            const SizedBox(height: 30.0),

  Row(
  children: [
    Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Select From Unit',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          items: _conversionFactors[_selectedCategory]!.keys
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Center(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: _fromUnit,
          onChanged: (String? newValue) {
            setState(() {
              _fromUnit = newValue!;
            });
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.brown.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.brown.shade100,
            ),
            maxHeight: 200,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
          ),
        ),
      ),
    ),


    const SizedBox(width: 16.0),  


    Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Select To Unit',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          items: _conversionFactors[_selectedCategory]!.keys
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Center(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: _toUnit,
          onChanged: (String? newValue) {
            setState(() {
              _toUnit = newValue!;
            });
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.brown.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.brown.shade100,
            ),
            maxHeight: 200,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
          ),
        ),
      ),
    ),
  ],
),

            const SizedBox(height: 30.0),

            // Convert Button
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text(
                'Convert',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20.0),

            // Converted Value 
            if (_convertedValue.isNotEmpty)
              Card(
                color: Colors.white38,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Converted Value: $_convertedValue $_toUnit',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
