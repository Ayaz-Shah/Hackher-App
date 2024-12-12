import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';

class HostRelationshipForm extends StatefulWidget {
  @override
  _HostRelationshipFormState createState() => _HostRelationshipFormState();
}

class _HostRelationshipFormState extends State<HostRelationshipForm> {
  String? selectedRelationship;
  final List<String> relationships = ['Husband', 'Wife', 'Mother', 'Other'];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leading:  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 12,),),
        title: Text('Relationship Types',style: GoogleFonts.inter(
            fontSize: 15.25,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000)
        ),),
        backgroundColor: Color(0xffFFFFFF),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: selectedRelationship.toString(),
                  hintStyle: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff000000)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  fillColor: Color(0xffF3F2F7),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 10), // Adjust padding
                ),
                value: selectedRelationship,
                items: relationships.map((String relationship) {
                  return DropdownMenuItem<String>(
                    value: relationship,
                    child: Text(relationship),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRelationship = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff000000)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  fillColor: Color(0xffF3F2F7),
                  filled: true,
                  contentPadding: EdgeInsets.only(bottom: 17,left: 10), // Adjust padding
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: otherController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Other",
                  hintStyle: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff000000)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0
                      )
                  ),
                  fillColor: Color(0xffF3F2F7),
                  filled: true,
                  contentPadding: EdgeInsets.only(bottom: 17,left: 10), // Adjust padding
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 350,),
              Center(
                child: Container(
                  width: 225,
                  height: 45,
                  child: CustomElevatedButton(
                    onPressed: () {
                      // Handle form submission
                      print('Relationship: $selectedRelationship');
                      print('Email: ${emailController.text}');
                      if (selectedRelationship == 'Other') {
                        print('Other: ${otherController.text}');
                      }
                    },
                    label: "Send",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

