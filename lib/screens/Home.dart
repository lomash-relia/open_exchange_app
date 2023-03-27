import 'package:currency_converter/components/UsdtoAny.dart';
import 'package:currency_converter/components/AnytoAny.dart';
import 'package:currency_converter/functions/fetchrates.dart';
import 'package:currency_converter/models/ratesModel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Open Exchange Service'),
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/money_background.png'),
            fit: BoxFit.cover,
            opacity: 0.5,
          )
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context,currSnapshot){
                      if(currSnapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UsdtoAny(
                            currencies:currSnapshot.data!,
                            rates:snapshot.data!.rates,
                          ),
                          AnytoAny(
                              currencies:currSnapshot.data!,
                              rates:snapshot.data!.rates
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      )
    );
  }
}
