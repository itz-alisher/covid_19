import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WashHands extends StatefulWidget {
  @override
  _WashHandsState createState() => _WashHandsState();
}

class _WashHandsState extends State<WashHands> {
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
              textTop: "Wash",
              textBottom: "Your Hands",
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

// class SymptomCard extends StatelessWidget {
//   final String? image;
//   final String? title;
//   final bool? isActive;
//   const SymptomCard({
//     Key? key,
//     this.image,
//     this.title,
//     this.isActive = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//         boxShadow: [
//           isActive!
//               ? BoxShadow(
//             offset: Offset(0, 10),
//             blurRadius: 20,
//             color: kActiveShadowColor,
//           )
//               : BoxShadow(
//             offset: Offset(0, 3),
//             blurRadius: 6,
//             color: kShadowColor,
//           ),
//         ],
//       ),
//       child: Column(
//         children: <Widget>[
//           Image.asset(image!, height: 90),
//           Text(
//             title!,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }