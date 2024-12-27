import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/hostInterestScreen.dart';
import 'package:hackher/hostScreens/hostNeedScreen.dart';
import 'package:hackher/hostScreens/hostSexlifeScreen.dart';
import 'package:hackher/hostScreens/hostSymptomReliefScreen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'hostProfileScreen.dart';
import 'hostSnackListScreen.dart';
import 'hstWishlistScreen.dart';
import 'widgets/hostCustomInterestButtonwidgets.dart';

class HostDashBoardScreen extends StatefulWidget {
  @override
  _HostDashBoardScreenState createState() => _HostDashBoardScreenState();
}

class _HostDashBoardScreenState extends State<HostDashBoardScreen> {
  DateTime _focusedDay = DateTime.now(); // Current focused day
  DateTime? _selectedDay; // Selected day in the calendar

  int _selectedIndex = 0; // For Bottom Navigation Bar

  // Handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) { // If Profile tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HostProfileScreen()),
      );
    }
  }

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
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_alert)),
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
            SizedBox(height: 10),
            Container(
              height: 100,
              width: double.infinity,
              color: Color(0xffFFE7F0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HostNeedsScreen()),
                    );
                  },
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
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Color(0xffFFFFFF),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Calendar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay; // Update focused day
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // GridView Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevents GridView scrolling
                crossAxisCount: 3, // 3 columns
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_Interests_icon.png',
                    label: 'Interests',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HostInterestScreen()),
                      );
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_sex_life_icon.png',
                    label: 'Sex Life',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HostSexLifeScreen()),
                      );
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_symptoms relief_icon.png',
                    label: 'Symptoms Relief',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HostSymptomReliefScreen()),
                      );
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_snack list_icon.png',
                    label: 'Snack List',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HostSnackListScreen()),
                      );
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_wishlist_icon.png',
                    label: 'Wish List',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>HostWishListScreen() ),
                      );
                    },
                  ),
                  CustomImageButton(
                    imageAsset: 'assets/assets/guest_icons/guest_special _days.png',
                    label: 'Special Days',
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF2E6F8E),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 26, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
