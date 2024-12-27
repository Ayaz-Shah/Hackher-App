import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackher/hostScreens/widgets/hostCustomButtonwidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HostWishListScreen extends StatefulWidget {
  const HostWishListScreen({super.key});

  @override
  State<HostWishListScreen> createState() => _HostWishListScreenState();
}

class _HostWishListScreenState extends State<HostWishListScreen> {
  final List<TextEditingController> _controllers = [];
  final String apiUrlGet = 'https://hacker.devssh.xyz/host/v1/wish/list_get/';
  final String apiUrlPost = 'https://hacker.devssh.xyz/host/v1/wish/list_add/';
  final String apiUrlDelete = 'https://hacker.devssh.xyz/host/v1/wish/list_delete/';
  bool isLoading = true;

  /// Fetch the authentication token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Fetch links from API and update the UI
  Future<void> _fetchLinks() async {
    setState(() {
      isLoading = true;
    });

    final token = await getToken();
    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrlGet),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] != null && data['data'] is Map<String, dynamic>) {
          final Map<String, dynamic> dataContent = data['data'];

          if (dataContent['links'] != null && dataContent['links'] is List) {
            final List<dynamic> linksList = dataContent['links'];

            setState(() {
              _controllers.clear();
              for (var link in linksList) {
                if (link is String) {
                  _controllers.add(TextEditingController(text: link));
                }
              }
            });
          } else {
            Fluttertoast.showToast(
              msg: "No links found.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          // Fluttertoast.showToast(
          //   msg: "Unexpected data format.",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        }
      } else {
        // Fluttertoast.showToast(
        //   msg: "No Links Available",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: "Error: $e",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Delete a link using the API
  Future<void> _deleteLink(String link, int index) async {
    final token = await getToken();
    if (token == null) {
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse(apiUrlDelete),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'links': link}),
      );

      if (response.statusCode == 200) {
        _submitLinks();
        Fluttertoast.showToast(
          msg: "Link deleted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Color(0xff216D8A),
        );

        setState(() {
          _controllers.removeAt(index);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Failed to delete link: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  /// Submit new links to the API
  Future<void> _submitLinks() async {
    final token = await getToken();

    if (token == null) {
      Fluttertoast.showToast(
        msg: "Error: User is not logged in.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    List<String> linksToAdd = [];

    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {
        linksToAdd.add(controller.text);
      }
    }

    if (linksToAdd.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(apiUrlPost),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({'links': linksToAdd}),
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Links added successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.green,
          );
          _fetchLinks(); // Refresh the list after successful addition
        } else {
          Fluttertoast.showToast(
            msg: "Failed to add links.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please fill the text.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLinks(); // Fetch links on screen load
  }

  void _addNewLinkField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
          'Wish List',
          style: GoogleFonts.inter(
            fontSize: 15.25,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add links of things you like, love and want!',
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              // Render dynamic text fields (show fetched links first)
              Column(
                children: _controllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'https://wishlistitem.com',
                        hintStyle: GoogleFonts.rubik(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteLink(controller.text, index);
                          },
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // "Add link +" button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addNewLinkField,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xff216D8A),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    "Add link +",
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff216D8A),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              // Submit button
              Container(
                height: 45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: CustomElevatedButton(
                  padding: EdgeInsets.only(bottom: 2),
                  onPressed: () {
                    _submitLinks();
                  },
                  label: "Submit",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
