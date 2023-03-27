import 'package:currency_converter/functions/fetchrates.dart';
import 'package:flutter/material.dart';

class UsdtoAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdtoAny({Key? key, required this.currencies, required this.rates})
      : super(key: key);

  @override
  State<UsdtoAny> createState() => _UsdtoAnyState();
}

class _UsdtoAnyState extends State<UsdtoAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownvalue = 'INR';
  String answer = 'Converted Currency will be shown here';

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
            Text('USD to Any Currency',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(height: 10),
            TextFormField(
              key: ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                  value: dropdownvalue,
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
                      dropdownvalue = newValue!;
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
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer = usdController.text +
                            ' USD =' +
                            convertusd(widget.rates, usdController.text,
                                dropdownvalue) +
                            ' ' +
                            dropdownvalue;
                      });
                    },
                    child: Text('Convert'),
                  ),
                ),
                SizedBox(height: 10),
              ],
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
