import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_19/widgets/counter.dart';
import 'constant.dart';
import 'info_screen.dart';
import 'main.dart';

void main() => runApp(Covid19());

class Covid19 extends StatefulWidget {
  @override
  _Covid19State createState() => _Covid19State();
}

class _Covid19State extends State<Covid19> {
  bool _isLoading = false;
  List<Data> data = []; // No error
  TextEditingController countryController = TextEditingController();

  Future<List<Data>> fetchData(String countryName) async {
    setState(() {
      _isLoading = true;
    });

    //https://api.covid19api.com/live/country/india/status/confirmed
    final response = await http.get(Uri.parse('https://api.covid19api.com/live/country/$countryName/status/confirmed'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      // Transform json into object

      var items = json.decode(response.body);

      items.forEach((item) {
        data.add(Data.fromJson(item));
      });
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('CoronaVirus Tracker')),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a Country'),
                        controller: countryController,
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.blue,
                        onPressed: () {
                          fetchData(countryController.text).then((newData) {
                            setState(() {
                              data = newData;
                              _isLoading = false;
                            });
                          });
                        }),
                  ],
                ),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  :
              //The search item appear here
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Case Update\n",
                                  style: kTitleTextstyle,
                                ),
                                TextSpan(
                                  text: data[index].date,
                                  style: TextStyle(
                                    color: kTextLightColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Counter(
                                color: kInfectedColor,
                                number: data[index].confirmed,
                                title: "Infected",
                              ),
                              Counter(
                                color: kDeathColor,
                                number: data[index].deaths,
                                title: "Deaths",
                              ),
                              Counter(
                                color: kRecovercolor,
                                number: data[index].recovered,
                                title: "Recovered",
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
            ],
          ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: 'Home',
                icon: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>HomeScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.home, color: Colors.black54,
                  ),
                )
            ),
            BottomNavigationBarItem(
                label: 'Symptoms',
                icon: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>InfoScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.accessibility, color: Colors.black45,
                  ),
                )
            ),
            BottomNavigationBarItem(
                label: 'Search',
                icon: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>Covid19(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search, color: Colors.blue,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Data {
  final int? confirmed;
  final int? deaths;
  final int? recovered;
  final String? date;

  Data({this.confirmed, this.deaths, this.recovered, this.date});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        confirmed: json['Confirmed'],
        deaths: json['Deaths'],
        recovered: json['Recovered'],
        date: json['Date'],
    );
  }
}