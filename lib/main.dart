import 'package:covid_19/constant.dart';
import 'package:covid_19/screens/post_screen.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'covid_api.dart';
import 'info_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBakcgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
          ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  final now = DateTime.now();
  late String dateTime = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text('Pakistan Current Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Case Update\n",
                          style: kTitleTextstyle,
                        ),
                        TextSpan(
                          text: "$dateTime",
                          style: TextStyle(
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>InfoScreen(),
                        ),
                      );
                    },
                    child: Text("See details",
                      style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: kShadowColor,
                  ),
                ],
              ),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('covid_status').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Counter(
                                color: kInfectedColor,
                                // number: 1046,
                                number: document['infected'],
                                title: "Infected",
                              ),
                              Counter(
                                color: kDeathColor,
                                number: document['deaths'],
                                title: "Deaths",
                              ),
                              Counter(
                                color: kRecovercolor,
                                number: document['recovered'],
                                title: "Recovered",
                              ),
                            ],
                          // leading: Text(document['deaths']),
                          // title: new Text(document['infected']),
                          // subtitle: new Text(document['recovered']),
                        );
                      }).toList(),
                    );
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Counter(
                    //       color: kInfectedColor,
                    //       number: 1046,
                    //       title: "Infected",
                    //     ),
                    //     Counter(
                    //       color: kDeathColor,
                    //       number: 87,
                    //       title: "Deaths",
                    //     ),
                    //     Counter(
                    //       color: kRecovercolor,
                    //       number: 46,
                    //       title: "Recovered",
                    //     ),
                    //   ],
                    // ),
                  }
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  buildHelpCard(context),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  Icons.home, color: Colors.blue,
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
                  Icons.accessibility, color: Colors.black54,
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
                  Icons.search, color: Colors.black54,
                ),
              )
          ),
          BottomNavigationBarItem(
              label: 'Post',
              icon: IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>ImageUploads(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.post_add, color: Colors.black54,
                ),
              )
          ),
        ],
      ),
    );
  }
  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5586c6),
                  Color(0xFF1270ea),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 1166 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

}
