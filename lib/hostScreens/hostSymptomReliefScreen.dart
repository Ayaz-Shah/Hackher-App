import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';
import 'package:hackher/hostScreens/widgets/symptomReliedDropDownboxWidgets.dart';

class HostSymptomReliefScreen extends StatefulWidget {
  const HostSymptomReliefScreen({super.key});

  @override
  State<HostSymptomReliefScreen> createState() => _HostSymptomReliefScreenState();
}

class _HostSymptomReliefScreenState extends State<HostSymptomReliefScreen> {
  TextEditingController bloatingController = TextEditingController();
  TextEditingController breasttendernessController = TextEditingController();
  TextEditingController analcrampsController  = TextEditingController();
  TextEditingController headachesandMigrainController = TextEditingController();
  TextEditingController jointpainController  = TextEditingController();
  TextEditingController backpainController = TextEditingController();
  TextEditingController acneController = TextEditingController();
  TextEditingController diarrheaorConstipationController = TextEditingController();
  TextEditingController  fatigueController = TextEditingController();
  TextEditingController foodCravingsController = TextEditingController();


  @override
  void dispose() {
    // Clean up controllers when they are no longer needed
    bloatingController.dispose();
    breasttendernessController.dispose();
    analcrampsController.dispose();
    headachesandMigrainController.dispose();
    jointpainController.dispose();
    backpainController.dispose();
    acneController.dispose();
    diarrheaorConstipationController.dispose();
    fatigueController.dispose();
    foodCravingsController.dispose();
    super.dispose();
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
          'Symptom Relief',
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
              'Symptom: Bloating',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'Water pills',],
              customReliefController: bloatingController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Breast tenderness',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'sports bra',],
              customReliefController:breasttendernessController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Anal cramps',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'sports bra',],
              customReliefController:analcrampsController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Headaches/Migrain',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'sports bra',],
              customReliefController:headachesandMigrainController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Joint pain',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'Rx',],
              customReliefController: jointpainController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Back pain',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'sports bra',],
              customReliefController: backpainController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Acne',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'sports bra',],
              customReliefController: acneController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Diarrhea or Constipation',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'drink fluids',],
              customReliefController: diarrheaorConstipationController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Fatigue',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'caffeine',],
              customReliefController: fatigueController,  // Pass controller here
            ),
            SizedBox(height: 10,),
            Text(
              'Symptom: Food Cravings',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
            ),
            Text(
              'Relief:',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff000000)),
            ),
            SymptomReliefDropdown(
              options: ['none', 'indulge',],
              customReliefController: foodCravingsController,  // Pass controller here
            ),
            SizedBox(height: 20,),
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
