import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/custonNeedbuttonwidgets.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';

class HostSexLifeScreen extends StatefulWidget {
  const HostSexLifeScreen({super.key});

  @override
  State<HostSexLifeScreen> createState() => _HostSexLifeScreenState();
}

class _HostSexLifeScreenState extends State<HostSexLifeScreen> {
  List<Map<String, dynamic>> describeSexLife = [
    {"label": "Asexual", "isSelected": false},
    {"label": "Novice", "isSelected": false},
    {"label": "Vanilla", "isSelected": false},
    {"label": "Vanilla with a twist", "isSelected": false},
    {"label": "light Kinky", "isSelected": false},
    {"label": "Extreme kink", "isSelected": false},
    {"label": "Sex addict", "isSelected": false},
  ];
  List<Map<String, dynamic>> curiousSexLife = [
    {"label": "sexting, sex toys", "isSelected": false},
    {"label": "Anal", "isSelected": false},
    {"label": "oral", "isSelected": false},
    {"label": "anilingus", "isSelected": false},
    {"label": "Abrasion", "isSelected": false},
    {"label": "Light bondage", "isSelected": false},
    {"label": "Edging", "isSelected": false},
    {"label": "Japanese bondage", "isSelected": false},
    {"label": "voyueristic", "isSelected": false},
    {"label": "exibitionist", "isSelected": false},
    {"label": "Abrasion", "isSelected": false},
    {"label": "sex furniture", "isSelected": false},
    {"label": "food play", "isSelected": false},
    {"label": "golden showers", "isSelected": false},
    {"label": "scat play", "isSelected": false},
  ];
  List<Map<String, dynamic>> sexDontwant = [
    {"label": "sexting, sex toys", "isSelected": false},
    {"label": "Anal", "isSelected": false},
    {"label": "oral", "isSelected": false},
    {"label": "anilingus", "isSelected": false},
    {"label": "Abrasion", "isSelected": false},
    {"label": "Light bondage", "isSelected": false},
    {"label": "Edging", "isSelected": false},
    {"label": "Japanese bondage", "isSelected": false},
    {"label": "voyueristic", "isSelected": false},
    {"label": "exibitionist", "isSelected": false},
    {"label": "Abrasion", "isSelected": false},
    {"label": "sex furniture", "isSelected": false},
    {"label": "food play", "isSelected": false},
    {"label": "golden showers", "isSelected": false},
    {"label": "scat play", "isSelected": false},
  ];


  List<String> userdescribedSexLifeselectedItems = [];
  List<String> usercuriousSexLifeselectedItems = [];
  List<String> usersexDontWantselectedItems = [];

// Dexcribed method start here

  void _toggleDescribedSelection(int index) {
    setState(() {
      describeSexLife[index]['isSelected'] = !describeSexLife[index]['isSelected'];
      if (describeSexLife[index]['isSelected']) {
        userdescribedSexLifeselectedItems.add(describeSexLife[index]['label']);
      } else {
        userdescribedSexLifeselectedItems.remove(describeSexLife[index]['label']);
      }
    });
  }
  // Curious method start here

  void _toggleCuriousSexLifeSelection(int index) {
    setState(() {
      curiousSexLife[index]['isSelected'] = !curiousSexLife[index]['isSelected'];
      if (curiousSexLife[index]['isSelected']) {
        usercuriousSexLifeselectedItems.add(curiousSexLife[index]['label']);
      } else {
        usercuriousSexLifeselectedItems.remove(describeSexLife[index]['label']);
      }
    });
  }

  // SexDont want method here

  void _toggleSexDontWantSelection(int index) {
    setState(() {
      sexDontwant[index]['isSelected'] = !sexDontwant[index]['isSelected'];
      if (sexDontwant[index]['isSelected']) {
        usersexDontWantselectedItems.add(sexDontwant[index]['label']);
      } else {
        usersexDontWantselectedItems.remove(sexDontwant[index]['label']);
      }
    });
  }

  // Describe widget here

  Widget _buildGriddecribedsexLife() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: describeSexLife.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleDescribedSelection(describeSexLife.indexOf(item)),
            );
          }).toList(),
        );
      },
    );
  }

  // Curious widgets start here
  Widget _buildGridcurioussexLife() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: curiousSexLife.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleCuriousSexLifeSelection(curiousSexLife.indexOf(item)),
            );
          }).toList(),
        );
      },
    );
  }

  // SexDont Want widgets start here

  Widget _buildGridsexdontWant() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: sexDontwant.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleSexDontWantSelection(sexDontwant.indexOf(item)),
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
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 12,),),
        title: Text('Sex Life',style: GoogleFonts.inter(
            fontSize: 15.25,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000)
        ),),
        backgroundColor: Color(0xffFFFFFF),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Describe your Sex life:',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                _buildGriddecribedsexLife(),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sex you are curious about:',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                _buildGridcurioussexLife(),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sex You DONT Want:',
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                _buildGridsexdontWant(),
                SizedBox(height: 40,),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CustomElevatedButton(
                    onPressed: () {
                print(userdescribedSexLifeselectedItems.toString());
                    },
                    label: "Submited",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
