import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/custonNeedbuttonwidgets.dart'; // Import your CustomNeedButton
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HostSnackListScreen extends StatefulWidget {
  const HostSnackListScreen({super.key});

  @override
  State<HostSnackListScreen> createState() => _HostSnackListScreenState();
}

class _HostSnackListScreenState extends State<HostSnackListScreen> {
  List<Map<String, dynamic>> snacks = [];
  List<Map<String, dynamic>> filteredSnacks = [];
  List<Map<String, dynamic>> selectedSnacks = [];
  bool isLoading = true;
  bool showList = false;

  @override
  void initState() {
    super.initState();
    fetchSnackList();
    fetchSelectedSnacks();  // Fetch selected snacks from the API
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Fetching the snack list from API
  Future<void> fetchSnackList() async {
    try {
      final token = await getToken();
      if (token == null) {
        print('No token found. User might not be logged in.');
        return;
      }

      final response = await http.get(
        Uri.parse('https://hacker.devssh.xyz/host/v1/about/snack_list/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("this is first api data $responseData");

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('snack_options')) {
          final snackOptions = responseData['snack_options'] as List;

          if (mounted) {
            setState(() {
              snacks = snackOptions
                  .map((item) => {
                'name': item['name'].toString(),
                'id': item['id'].toString(),
              })
                  .toList();
              filteredSnacks = List.from(snacks); // Initialize filtered list
              isLoading = false;
            });
          }
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Fetch selected snacks from the API
  Future<void> fetchSelectedSnacks() async {
    try {
      final token = await getToken();
      if (token == null) {
        print('No token found. User might not be logged in.');
        return;
      }

      final response = await http.get(
        Uri.parse('https://hacker.devssh.xyz/host/v1/add_about/snack_list/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("this is selected snack data $responseData");

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final selectedSnackOptions = responseData['data'] as List;

          setState(() {
            selectedSnacks = selectedSnackOptions
                .map((item) => {
              'name': item['name'].toString(),
              'id': item['id'].toString(),
            })
                .toList();
          });
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Failed to fetch selected snacks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching selected snacks: $e');
    }
  }

  // Searching through the snack list
  void searchSnacks(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredSnacks = List.from(snacks);
        showList = false;
      });
    } else {
      final results = snacks.where((item) {
        return item['name']
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredSnacks = results;
        showList = true;
      });
    }
  }

  // Toggling snack selection
  void toggleSnack(Map<String, dynamic> snack) {
    setState(() {
      if (selectedSnacks.any((s) => s['id'] == snack['id'])) {
        selectedSnacks.removeWhere((s) => s['id'] == snack['id']);
      } else {
        selectedSnacks.add(snack);
      }
    });

    // Optionally, save selected snacks and post them if necessary
    saveSelectedSnacks();
    postSelectedSnacks();
  }

  // Saving selected snacks to SharedPreferences
  Future<void> saveSelectedSnacks() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedSnackIds = selectedSnacks.map((e) => e['id'].toString()).toList();
    final selectedSnackNames = selectedSnacks.map((e) => e['name'].toString()).toList();

    await prefs.setStringList('selected_snacks_ids', selectedSnackIds);
    await prefs.setStringList('selected_snacks_names', selectedSnackNames);

    print('Selected snacks saved to SharedPreferences.');
  }

  // Posting selected snacks (as an example)
  Future<void> postSelectedSnacks() async {
    try {
      final token = await getToken();
      if (token == null) {
        print('No token found. User might not be logged in.');
        return;
      }

      List<String> selectedIds = selectedSnacks.map((e) => e['id'].toString()).toList();
      final Map<String, dynamic> requestBody = {
        'answer_ids': selectedIds,
      };

      final response = await http.post(
        Uri.parse('https://hacker.devssh.xyz/host/v1/add_about/add_snack_list/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print("this response body ${response.body}");

      if (response.statusCode == 201) {
        print('Snacks successfully posted!');
      } else {
        print('Failed to post selected snacks. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error posting selected snacks: $e');
    }
  }

  // Build the snack list with the CustomNeedButton
  Widget _buildSnackList() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: filteredSnacks.map((snack) {
        return CustomNeedButton(
          label: snack['name'],
          isSelected: selectedSnacks.any((s) => s['id'] == snack['id']),
          onPressed: () => toggleSnack(snack),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 12),
        ),
        title: Text(
          'Snack List',
          style: GoogleFonts.inter(
            fontSize: 15.25,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How do you manage your craving?',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    searchSnacks(value);
                  },
                  onTap: () {
                    setState(() {
                      showList = true;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Color(0xffF3F2F7),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.rubik(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Color(0xffF3F2F7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Color(0xffF3F2F7)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (showList) ...[
                _buildSnackList(),  // Use the wrap here
              ],
              SizedBox(height: 10,),
              // Displaying the selected snacks using CustomNeedButton
              if (selectedSnacks.isNotEmpty) ...[
                Text(
                  'Selected Snacks:',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedSnacks.map((snack) {
                    return CustomNeedButton(
                      label: snack['name'],
                      isSelected: true,
                      onPressed: () => toggleSnack(snack),
                    );
                  }).toList(),
                ),
              ],

            ],
          ),
        ),
      ),
    );
  }
}
