import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/custonNeedbuttonwidgets.dart';
import 'widgets/hostCustomButtonwidgets.dart';

class HostAnimalAndPetsScreen extends StatefulWidget {
  @override
  _HostAnimalAndPetsScreenState createState() => _HostAnimalAndPetsScreenState();
}

class _HostAnimalAndPetsScreenState extends State<HostAnimalAndPetsScreen> {
  final TextEditingController otherController = TextEditingController();
  List<Map<String, dynamic>> animalandPets = [
    {"label": "Wildlife", "isSelected": false},
    {"label": "Veterinary Medicine", "isSelected": false},
    {"label": "animal competitions", "isSelected": false},
    {"label": "fantasy Animals", "isSelected": false},
    {"label": "Zoos Aquariums", "isSelected": false},
    {"label": "wildlife parks", "isSelected": false},
  ];

  List<String> useranimalandPetsselectedItems = [];

  void _toggleAnimalAndPetsSelection(int index) {
    setState(() {
      animalandPets[index]['isSelected'] = !animalandPets[index]['isSelected'];
      if (animalandPets[index]['isSelected']) {
        useranimalandPetsselectedItems.add(animalandPets[index]['label']);
      } else {
        useranimalandPetsselectedItems.remove(animalandPets[index]['label']);
      }
    });
  }

  Widget _buildGridanimalandPets() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10, // Horizontal spacing between buttons
          runSpacing: 10, // Vertical spacing between lines
          children: animalandPets.map((item) {
            return CustomNeedButton(
              label: item['label'],
              isSelected: item['isSelected'],
              onPressed: () => _toggleAnimalAndPetsSelection(animalandPets.indexOf(item)),
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
          'Animal & Pets',
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
            _buildGridanimalandPets(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: TextFormField(
                controller: otherController,
                maxLines: 6,
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
            SizedBox(height: 350,),
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
