import 'package:currency_converter/functions/fetchrates.dart';
import 'package:flutter/material.dart';

class AnytoAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnytoAny({Key? key, required this.currencies, required this.rates})
      : super(key: key);

  @override
  State<AnytoAny> createState() => _AnytoAnyState();
}

class _AnytoAnyState extends State<AnytoAny> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'INR';
  String dropdownValue2 = 'USD';
  String answer = 'Converted currency will be shown here';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Any to Any Currency',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(height: 10),
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade400,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                SizedBox(height: 10),
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade400,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ],
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer = amountController.text +
                        dropdownValue1 +
                        ' = ' +
                        convertany(
                            widget.rates, amountController.text, dropdownValue1,dropdownValue2) +
                        ' ' +
                        dropdownValue2;
                  });
                },
                child: Text('Convert'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(answer),
            )
          ],
        ),
      ),
    );
  }
}
