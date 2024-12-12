import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/custonNeedbuttonwidgets.dart';
import 'widgets/hostCustomButtonwidgets.dart';

class HostTouchPointScreen extends StatefulWidget {
  @override
  _HostTouchPointScreenState createState() => _HostTouchPointScreenState();
}

class _HostTouchPointScreenState extends State<HostTouchPointScreen> {
  final TextEditingController otherController = TextEditingController();
  List<Map<String, dynamic>> touchPoint = [
    {"label": "Don’t like to be touched", "isSelected": false},
    {"label": "Feet & Toes", "isSelected": false},
    {"label": "Ankles and calves", "isSelected": false},
    {"label": "Thighs", "isSelected": false},
    {"label": "Lower back", "isSelected": false},
    {"label": "Upper back", "isSelected": false},
    {"label": "Neck & Shoulders", "isSelected": false},
    {"label": "Head & scalp", "isSelected": false},
    {"label": "Face", "isSelected": false},
    {"label": "Arms", "isSelected": false},
    {"label": "Hands", "isSelected": false},
    {"label": "Abdomen", "isSelected": false},
  ];

  List<String> usertouchPointselectedItems = [];

  void _toggleTouchPointSelection(int index) {
    setState(() {
      touchPoint[index]['isSelected'] = !touchPoint[index]['isSelected'];
      if (touchPoint[index]['isSelected']) {
        usertouchPointselectedItems.add(touchPoint[index]['label']);
      } else {
        usertouchPointselectedItems.remove(touchPoint[index]['label']);
      }
    });
  }

  Widget _buildGridtouchPoint() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: touchPoint.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleTouchPointSelection(touchPoint.indexOf(item)),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 12,
          ),
        ),
        title: Text(
          'Touch Points',
          style: GoogleFonts.inter(
              fontSize: 15.25,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000)),
        ),
        backgroundColor: Color(0xffFFFFFF),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Where you prefer to be massaged & touched',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),
            ),
            SizedBox(height: 10,),
            _buildGridtouchPoint(),
            SizedBox(height: 350,),
            Container(
              height: 45,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: CustomElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                label: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
