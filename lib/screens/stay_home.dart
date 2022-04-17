import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StayHome extends StatefulWidget {
  @override
  _StayHomeState createState() => _StayHomeState();
}

class _StayHomeState extends State<StayHome> {
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
              textTop: "Stay",
              textBottom: "at Home",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Details",
                      style: kTitleTextstyle,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '       Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Precautions",
                      style: kTitleTextstyle,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '     Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks. Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
