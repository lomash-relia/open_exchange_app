import 'package:currency_converter/models/allcurrencies.dart';
import 'package:currency_converter/models/ratesModel.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchrates() async {
  var response = await http.get(
      Uri.parse('https://openexchangerates.org/api/latest.json?app_id=' + key));
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> fetchcurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final allcurrencies = allCurrenciesFromJson(response.body);
  return allcurrencies;
}

String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
      ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
          .toString();
  return output;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();
  return output;
}
