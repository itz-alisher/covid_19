import 'package:covid_19/constant.dart';
import 'package:covid_19/screens/face_mask.dart';
import 'package:covid_19/screens/hands_wash.dart';
import 'package:covid_19/screens/stay_home.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'covid_api.dart';
import 'main.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Get to know",
              textBottom: "About Covid-19.",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SymptomCard(
                          image: "assets/images/headache.png",
                          title: "Headache",
                          isActive: true,
                        ),
                        SymptomCard(
                          image: "assets/images/caugh.png",
                          title: "Caugh",
                        ),
                        SymptomCard(
                          image: "assets/images/fever.png",
                          title: "Fever",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Prevention", style: kTitleTextstyle),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                    "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                    image: "assets/images/wear_mask.png",
                    title: "Wear face mask",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>FaceMask()),
                      );
                    },
                  ),
                  PreventCard(
                    text:
                    "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                    image: "assets/images/wash_hands.png",
                    title: "Wash your hands",
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>WashHands()),
                      );
                    },
                  ),
                  PreventCard(
                    text:
                    "The fewer people you’re around, the lower your chance of infection. When you stay home, you help stop the spread to others, too. Try to stay out of crowded places.",
                    image: "assets/images/wash_hands.png",
                    title: "Stay at Home",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>StayHome()),
                      );
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
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
                  Icons.accessibility, color: Colors.blue,
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
        ],
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? text;
  final Function()? onPressed;
  const PreventCard({
    Key? key,
    this.image,
    this.title,
    this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image!),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title!,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text!,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      // child: SvgPicture.asset("assets/icons/forward.svg"),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String? image;
  final String? title;
  final bool? isActive;
  const SymptomCard({
    Key? key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive!
              ? BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: kActiveShadowColor,
          )
              : BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 6,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image!, height: 90),
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}