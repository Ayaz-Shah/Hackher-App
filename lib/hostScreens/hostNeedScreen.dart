import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/custonNeedbuttonwidgets.dart';
import 'widgets/hostCustomButtonwidgets.dart';

class HostNeedsScreen extends StatefulWidget {
  @override
  _HostNeedsScreenState createState() => _HostNeedsScreenState();
}

class _HostNeedsScreenState extends State<HostNeedsScreen> {
  final TextEditingController otherController = TextEditingController();
  double _sliderValue = 0.5;
  List<Map<String, dynamic>> userNeeds = [
    {"label": "Space", "isSelected": false},
    {"label": "Quiet", "isSelected": false},
    {"label": "Hugs", "isSelected": false},
    {"label": "Attention and doting", "isSelected": false},
    {"label": "Quality time", "isSelected": false},
    {"label": "Help with a task", "isSelected": false},
    {"label": "Domestic work help", "isSelected": false},
    {"label": "a break from kids", "isSelected": false},
    {"label": "To plan & Dream", "isSelected": false},
    {"label": "To cry", "isSelected": false},
    {"label": "To laugh", "isSelected": false},
    {"label": "Adventure", "isSelected": false},
    {"label": "A date night", "isSelected": false},
    {"label": "Quiet company", "isSelected": false},
    {"label": "Quiet company", "isSelected": false},
    {"label": "non-sexual touch", "isSelected": false},
    {"label": "a massage", "isSelected": false},
    {"label": "a listening ear", "isSelected": false},
    {"label": "Need Sexual affection", "isSelected": false},
    {"label": "Need penetrative sex", "isSelected": false},
    {"label": "Need oral sex", "isSelected": false},
    {"label": "Want no sex", "isSelected": false},
    {"label": "Want mutual masturbation", "isSelected": false},
  ];

  List<String> userNeedsselectedItems = [];

  void _toggleUserNeedsSelection(int index) {
    setState(() {
      userNeeds[index]['isSelected'] = !userNeeds[index]['isSelected'];
      if (userNeeds[index]['isSelected']) {
        userNeedsselectedItems.add(userNeeds[index]['label']);
      } else {
        userNeedsselectedItems.remove(userNeeds[index]['label']);
      }
    });
  }

  Widget _buildGriduserNeeds() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: userNeeds.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleUserNeedsSelection(userNeeds.indexOf(item)),
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
          'Relationship Types',
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
            _buildGriduserNeeds(),
        SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: TextFormField(
                    controller: otherController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Other",
                      hintStyle: GoogleFonts.rubik(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff000000),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      fillColor: Color(0xffF3F2F7),
                      filled: true,
                      contentPadding: EdgeInsets.only(bottom: 17, left: 10),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'What is your sex drive today?',
                  style: GoogleFonts.inter(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: (_sliderValue * 100).toStringAsFixed(0) + '%',
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                      activeColor: Colors.orange,
                      inactiveColor: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff09AFF5),
                          ),
                        ),
                        Text(
                          'Neutral',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFF0000),
                          ),
                        ),
                        Text(
                          'Yes',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFF0000),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: (_sliderValue * MediaQuery.of(context).size.width) - 15, // Adjust the left position based on slider value
                      child: Image.asset(
                        'assets/assets/icons/Fire.png', // Update with your asset path
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CustomElevatedButton(
                    onPressed: () {
                      // Handle form submission
                    },
                    label: "Complete",
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
