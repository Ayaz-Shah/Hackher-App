import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class HostDashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Insights",
                     textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff090A0A),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_alert)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "It’s Progesterone week!",
                    style: GoogleFonts.inter(
                      fontSize: 13.59,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff090A0A),
                    ),
                  ),
                ],
              ),
            ),
      SizedBox(height: 10,),
      Container(
        height: 100,
        width:double.infinity,
        color: Color(0xffFFE7F0),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffE7407D),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Your Current Needs?",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios, // Replace this with your desired icon
                    size: 20, // Set the size of the icon
                    color: Color(0xffFFFFFF), // Set the color of the icon
                  ),
                ],
              ),
            ),
          )
        ),
      ),

      //       SizedBox(height: 8),
      //       Text(
      //         "It's Progesterone week!",
      //         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      //       ),
      //       SizedBox(height: 16),
      //       ElevatedButton.icon(
      //         onPressed: () {},
      //         icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
      //         label: Text(
      //           "Your Current Needs?",
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.pink,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10)),
      //           padding: EdgeInsets.symmetric(vertical: 16),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      //       // SizedBox(height: 24),
            // Calendar Section
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: TableCalendar(
            //     firstDay: DateTime.utc(2022, 1, 1),
            //     lastDay: DateTime.utc(2030, 12, 31),
            //     focusedDay: DateTime.now(),
            //     calendarStyle: CalendarStyle(
            //       todayDecoration: BoxDecoration(
            //         color: Colors.pink,
            //         shape: BoxShape.circle,
            //       ),
            //       selectedDecoration: BoxDecoration(
            //         color: Colors.green,
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //     headerStyle: HeaderStyle(), // Hide the header
            //   ),
            // ),
            // SizedBox(height: 16),
            // Buttons Section
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       _buildCategoryButton("Interests", Icons.star),
            //       _buildCategoryButton("Sex Life", Icons.favorite),
            //       _buildCategoryButton("Symptoms", Icons.local_hospital),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       _buildCategoryButton("Snack List", Icons.food_bank),
            //       _buildCategoryButton("Wishlist", Icons.card_giftcard),
            //       _buildCategoryButton("Special Days", Icons.event),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera_alt),
//             label: 'Camera',
//           ),
//         ],
//         currentIndex: 0,
//         selectedItemColor: Colors.pink,
//         unselectedItemColor: Colors.grey,
//       ),
//     );
//   }
//
//   Widget _buildCategoryButton(String label, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           height: 60,
//           width: 60,
//           decoration: BoxDecoration(
//             color: Colors.pink[50],
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: Colors.pink),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, color: Colors.black),
//         ),