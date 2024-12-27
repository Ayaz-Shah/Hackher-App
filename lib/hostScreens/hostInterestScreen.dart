import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/hostAnimal&petsScreen.dart';
import 'package:hackher/hostScreens/widgets/hostCustomInterestButtonwidgets.dart';

class HostInterestScreen extends StatefulWidget {
  const HostInterestScreen({super.key});

  @override
  State<HostInterestScreen> createState() => _HostInterestScreenState();
}

class _HostInterestScreenState extends State<HostInterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
        ),
        title: Text(
          'Interests',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        backgroundColor: Color(0xffFFFFFF),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3, // 3 buttons per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
            children: [
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Animal-&-Pets.png', // Replace with actual image path
                label: 'Animal & Pets',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HostAnimalAndPetsScreen()));
                  print('Animal & Pets button pressed!');
                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Books-&-Literature.png', // Replace with actual image path
                label: 'Books & Literature',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Business-Finance-&-Economics.png', // Replace with actual image path
                label: 'Business, Finance\n& Economics',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Children-&-Parenting.png', // Replace with actual image path
                label: 'Children & Parenting',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Education-&-Learning.png', // Replace with actual image path
                label: 'Education & Learning',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Fashion-&-Style.png', // Replace with actual image path
                label: 'Fashion & Style',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Food-&-Drink.png', // Replace with actual image path
                label: 'Food & Drink',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Games-Puzzles-&-Play.png', // Replace with actual image path
                label: 'Games, Puzzles\n& Play',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-History-&-Philosophy.png', // Replace with actual image path
                label: 'History &\nPhilosophy',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Holidays-&-Celebrations.png', // Replace with actual image path
                label: 'Holidays\n& Celebrations',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Home-&-Garden.png', // Replace with actual image path
                label: 'Home & Garden',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Music-&-Audio.png', // Replace with actual image path
                label: 'Music & Audio',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Performing-Arts.png', // Replace with actual image path
                label: 'Performing Arts',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Relationships-Friends-&-Family.png', // Replace with actual image path
                label: 'Relationships,\nFriends & Family',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Science-&-Tech.png', // Replace with actual image path
                label: 'Science & Tech',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Sports.png', // Replace with actual image path
                label: 'Sports',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-TV-&-Movies.png', // Replace with actual image path
                label: 'TV & Movies',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/Travel-&-Leisure-Activities.png', // Replace with actual image path
                label: 'Travel & Leisure\nActivities',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Vehicles-&-Transportation.png', // Replace with actual image path
                label: 'Vehicles &\nTransportation',
                onTap: () {

                },
              ),
              CustomImageButton(
                imageAsset: 'assets/assets/host_icons/interests/host-Visual-Arts-Architecture-&-Crafts.png', // Replace with actual image path
                label: 'Visual Arts,\nArchitecture\n& Crafts',
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
