// import 'package:agriconnect/Component/customButton.dart';
// import 'package:agriconnect/Component/customSize.dart';
// import 'package:agriconnect/Controllers/LoginController.dart';
// import 'package:agriconnect/Views/Common/profile_screen.dart';
// import 'package:agriconnect/Views/Farmer/AddCrop.dart';
// import 'package:agriconnect/Views/Farmer/detailcrops.dart';
// import 'package:agriconnect/Views/Farmer/histoty_order.dart';
// import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
// import 'package:agriconnect/Views/chatting/contact.dart';
// import 'package:agriconnect/chatbot_screen.dart';
// import 'package:agriconnect/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:agriconnect/Views/Farmer/Complete_order.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // UserController: Handles user data (username, imageUrl)
// class UserController {
//   String? imageUrl;
//   String? username;

//   Future<void> loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     imageUrl = prefs.getString('imageUrl');
//     username = prefs.getString('username');
//   }
// }

// // CropController: Handles crops data
// class CropController {
//   List<dynamic> crops = [];
//   List<dynamic> filteredCrops = [];
//   bool isLoading = true;
//   int? userId;
//   String searchQuery = "";
//   String? selectedCategory;

//   Future<void> fetchCrops() async {
//     if (userId == null) {
//       print("User ID is null");
//       isLoading = false;
//       return;
//     }

//     final String apiUrl = "http://152.67.10.128:5280/api/crops/farmer/$userId";
//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         if (jsonData.containsKey("\$values")) {
//           crops = jsonData["\$values"];
//           filteredCrops = crops;
//           isLoading = false;
//         } else {
//           print("API response doesn't contain \$values");
//           isLoading = false;
//         }
//       } else {
//         print("Failed to load crops. Status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         throw Exception("Failed to load crops");
//       }
//     } catch (error) {
//       print("Error fetching crops: $error");
//       isLoading = false;
//     }
//   }

//   void filterCrops() {
//     filteredCrops = crops.where((crop) {
//       bool matchesSearch =
//           crop["name"].toLowerCase().contains(searchQuery.toLowerCase());
//       bool matchesCategory =
//           selectedCategory == null || crop["category"] == selectedCategory;
//       return matchesSearch && matchesCategory;
//     }).toList();
//   }
// }

// class CropListScreen extends StatefulWidget {
//   @override
//   _CropListScreenState createState() => _CropListScreenState();
// }

// class _CropListScreenState extends State<CropListScreen> {
//   final UserController _userController = UserController();
//   final CropController _cropController = CropController();
//   String? imageUrl;
//   String? username;
//   String? phoneno;
//   @override
//   // Future<void> initState() async {
//   //   super.initState();
//   //   _loadUserData();
//   //   _loadUserId();
//   //   final prefs = await SharedPreferences.getInstance();
//   //   phoneno = prefs.getString('phoneNumber') ?? '';
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _initialize(); // Call async tasks separately
//   }

//   Future<void> _initialize() async {
//     await _loadUserData();
//     await _loadUserId();
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       phoneno = prefs.getString('phoneno');
//     });
//   }

//   Future<void> _loadUserData() async {
//     await _userController.loadUserData();
//     setState(() {
//       imageUrl = _userController.imageUrl;
//       username = _userController.username;
//     });
//   }

//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _cropController.userId = prefs.getInt('userId');
//     });
//     if (_cropController.userId != null) {
//       _cropController.fetchCrops();
//     } else {
//       setState(() {
//         _cropController.isLoading = false;
//       });
//     }
//   }

//   void _onSearchChanged(String query) {
//     setState(() {
//       _cropController.searchQuery = query;
//     });
//     _cropController.filterCrops();
//   }

//   void _onCategorySelected(String? category) {
//     setState(() {
//       _cropController.selectedCategory =
//           category == _cropController.selectedCategory ? null : category;
//     });
//     _cropController.filterCrops();
//   }

//   void _navigateToCropDetail(dynamic crop) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FarmerCropDetailScreen(
//           cropId: crop["cropId"],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       drawer: _buildDrawer(context),
//       body: _cropController.isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//               backgroundColor: MyColors.primaryColor,
//             ))
//           : _cropController.userId == null
//               ? const Center(child: Text("User ID not found"))
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ListView(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Good morning",
//                                 style: GoogleFonts.inter(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey[600]),
//                               ),
//                               Text(
//                                 username ?? "",
//                                 style: GoogleFonts.inter(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w600,
//                                     color: MyColors.black),
//                               ),
//                             ],
//                           ),
//                           if (imageUrl != null)
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(imageUrl!),
//                               radius: 24,
//                             ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12, bottom: 12),
//                         child: TextField(
//                           cursorColor: MyColors.primaryColor,
//                           onChanged: _onSearchChanged,
//                           decoration: InputDecoration(
//                             // labelText: "Search Crops",
//                             hintText: "Search Crops",
//                             prefixIcon: Icon(Icons.search,
//                                 color: MyColors.primaryColor),

//                             filled: true,
//                             fillColor: Colors.white, // Background color
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.circular(12), // Rounded borders
//                               borderSide: BorderSide(
//                                   color: MyColors.primaryColor, width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide:
//                                   BorderSide(color: MyColors.grey, width: 1.5),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                   color: MyColors.primaryColor, width: 2),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 15),
//                             // prefixIcon: const Icon(Icons.search),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5.0, vertical: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _categoryButton("Fruit", Icons.apple),
//                             _categoryButton("Vegetable", Icons.eco),
//                             _categoryButton("Cereal", Icons.grain),
//                           ],
//                         ),
//                       ),
//                       _cropController.filteredCrops.isNotEmpty
//                           ? Row(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(top: 8, bottom: 8),
//                                   child: Text(
//                                     "Available Crops",
//                                     style: GoogleFonts.inter(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                       Expanded(
//                         child: _cropController.filteredCrops.isEmpty
//                             ? Center(
//                                 child:
//                                     //  Text("No crops found")
//                                     Text(
//                                   "No crops found",
//                                   style: GoogleFonts.inter(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.black),
//                                 ),
//                               )
//                             : GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   childAspectRatio: 0.75,
//                                   crossAxisSpacing: 16.0,
//                                   mainAxisSpacing: 16.0,
//                                 ),
//                                 itemCount: _cropController.filteredCrops.length,
//                                 itemBuilder: (context, index) {
//                                   final crop =
//                                       _cropController.filteredCrops[index];
//                                   return GestureDetector(
//                                     onTap: () => _navigateToCropDetail(crop),
//                                     child: Card(
//                                       elevation: 4,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.2),
//                                               spreadRadius: 1,
//                                               blurRadius: 3,
//                                               offset: const Offset(0, 2),
//                                             ),
//                                           ],
//                                         ),
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Stack(
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius:
//                                                         const BorderRadius
//                                                             .vertical(
//                                                       top:
//                                                           Radius.circular(15.0),
//                                                     ),
//                                                     child: Image.network(
//                                                       crop["imageUrl"],
//                                                       width: double.infinity,
//                                                       height: 150,
//                                                       fit: BoxFit.cover,
//                                                       errorBuilder: (context,
//                                                           error, stackTrace) {
//                                                         return const SizedBox(
//                                                           width:
//                                                               double.infinity,
//                                                           height: 150,
//                                                           child: Icon(
//                                                               Icons.image,
//                                                               size: 100),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     top: 8.0,
//                                                     right: 8.0,
//                                                     child: Container(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                           horizontal: 8.0,
//                                                           vertical: 4.0),
//                                                       decoration: BoxDecoration(
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8.0),
//                                                       ),
//                                                       child: Text(
//                                                         'View',
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: MyColors
//                                                               .backgroundScaffoldColor,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       crop["name"],
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         color: MyColors.black,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(height: 4),
//                                                     Text(
//                                                       'Quantity: ${crop["quantity"]}',
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         color: Colors.grey[600],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _categoryButton(String category, IconData icon) {
//     bool isSelected = _cropController.selectedCategory == category;
//     return GestureDetector(
//       onTap: () => _onCategorySelected(category),
//       child: Card(
//         color: isSelected ? MyColors.primaryColor : Colors.white,
//         elevation: 4,
//         child: Container(
//           width: 110,
//           height: 110,
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black54,
//                 )
//               ],
//               color: isSelected ? MyColors.primaryColor : Colors.white,
//               borderRadius: BorderRadius.circular(25)),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(width: 1, color: Colors.black26)),
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: isSelected
//                       ? MyColors.backgroundScaffoldColor
//                       : Colors.white,
//                   child: Icon(icon, size: 30, color: MyColors.primaryColor),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               Text(
//                 category,
//                 style: GoogleFonts.inter(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: isSelected ? Colors.white : Colors.black),
//               ),
//               // Text(category),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColor,
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage:
//                     imageUrl != null ? NetworkImage(imageUrl!) : null,
//                 child: imageUrl == null ? const Icon(Icons.person) : null,
//               ),
//               accountName: Text(
//                 username ?? 'N/A',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: MyColors.backgroundScaffoldColor,
//                 ),
//               ),
//               accountEmail: Text(
//                 "${username ?? 'user'}@gmail.com",
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: MyColors.backgroundScaffoldColor,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: Text("Home", style: _drawerTextStyle()),
//               onTap: () => setState(() {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => FarmerMain()),
//                 );
//               }),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: Text("Profile", style: _drawerTextStyle()),
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.crop),
//               title: Text("Add Crop", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddCrop()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: Text("Confirms Orders", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => FarmerOrdersScreen()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: Text("Completed Orders", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => FarmerHistotyOrder()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.message),
//               title: Text("Messages", style: _drawerTextStyle()),
//               onTap: () async {
//                 print('Phone number is: $phoneno');
//                 final prefs = await SharedPreferences.getInstance();
//                 print(prefs);
//                 Get.to(ContactsScreen(phone: phoneno!));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.smart_toy),
//               title: Text("ChatBot", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChatBotScreen()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: Text("Settings", style: _drawerTextStyle()),
//               onTap: () {},
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 8, top: 24),
//               child: CustomButton(
//                 radius: CustomSize().customWidth(context) / 10,
//                 height: CustomSize().customHeight(context) / 15,
//                 width: CustomSize().customWidth(context) / 2,
//                 title: "Logout",
//                 loading: false,
//                 color: MyColors.primaryColor,
//                 onTap: () => LoginController().logout(context),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   TextStyle _drawerTextStyle() => GoogleFonts.inter(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: MyColors.black,
//       );
// }



// import 'package:agriconnect/Component/customButton.dart';
// import 'package:agriconnect/Component/customSize.dart';
// import 'package:agriconnect/Controllers/LoginController.dart';
// import 'package:agriconnect/Views/Common/profile_screen.dart';
// import 'package:agriconnect/Views/Farmer/AddCrop.dart';
// import 'package:agriconnect/Views/Farmer/detailcrops.dart';
// import 'package:agriconnect/Views/Farmer/histoty_order.dart';
// import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
// import 'package:agriconnect/Views/chatting/contact.dart';
// import 'package:agriconnect/chatbot_screen.dart';
// import 'package:agriconnect/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:agriconnect/Views/Farmer/Complete_order.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // UserController: Handles user data (username, imageUrl)
// class UserController {
//   String? imageUrl;
//   String? username;

//   Future<void> loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     imageUrl = prefs.getString('imageUrl');
//     username = prefs.getString('username');
//   }
// }

// // CropController: Handles crops data
// class CropController {
//   List<dynamic> crops = [];
//   List<dynamic> filteredCrops = [];
//   bool isLoading = true;
//   int? userId;
//   String searchQuery = "";
//   String? selectedCategory;

//   Future<void> fetchCrops() async {
//     if (userId == null) {
//       print("User ID is null");
//       isLoading = false;
//       return;
//     }

//     final String apiUrl = "http://152.67.10.128:5280/api/crops/farmer/$userId";
//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         if (jsonData.containsKey("\$values")) {
//           crops = jsonData["\$values"];
//           filteredCrops = crops;
//           isLoading = false;
//         } else {
//           print("API response doesn't contain \$values");
//           isLoading = false;
//         }
//       } else {
//         print("Failed to load crops. Status code: ${response.statusCode}");
//         print("Response body: ${response.body}");
//         throw Exception("Failed to load crops");
//       }
//     } catch (error) {
//       print("Error fetching crops: $error");
//       isLoading = false;
//     }
//   }

//   void filterCrops() {
//     filteredCrops = crops.where((crop) {
//       bool matchesSearch =
//           crop["name"].toLowerCase().contains(searchQuery.toLowerCase());
//       bool matchesCategory =
//           selectedCategory == null || crop["category"] == selectedCategory;
//       return matchesSearch && matchesCategory;
//     }).toList();
//   }
// }

// class CropListScreen extends StatefulWidget {
//   @override
//   _CropListScreenState createState() => _CropListScreenState();
// }

// class _CropListScreenState extends State<CropListScreen> {
//   final UserController _userController = UserController();
//   final CropController _cropController = CropController();
//   String? imageUrl;
//   String? username;
//   var phoneno;
//   @override
//   // Future<void> initState() async {
//   //   super.initState();
//   //   _loadUserData();
//   //   _loadUserId();
//   //   final prefs = await SharedPreferences.getInstance();
//   //   phoneno = prefs.getString('phoneNumber') ?? '';
//   // }

  
// @override
// void initState() {
//   super.initState();
//   _initialize(); // Call async tasks separately
// }

// Future<void> _initialize() async {
//   await _loadUserData();
//   await _loadUserId();
//   final prefs = await SharedPreferences.getInstance();
//   setState(() {
//     phoneno = prefs.getString('phoneNumber') ?? '';
//   });
// }

//   Future<void> _loadUserData() async {
//     await _userController.loadUserData();
//     setState(() {
//       imageUrl = _userController.imageUrl;
//       username = _userController.username;
//     });
//   }

//   Future<void> _loadUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _cropController.userId = prefs.getInt('userId');
//     });
//     if (_cropController.userId != null) {
//       _cropController.fetchCrops();
//     } else {
//       setState(() {
//         _cropController.isLoading = false;
//       });
//     }
//   }

//   void _onSearchChanged(String query) {
//     setState(() {
//       _cropController.searchQuery = query;
//     });
//     _cropController.filterCrops();
//   }

//   void _onCategorySelected(String? category) {
//     setState(() {
//       _cropController.selectedCategory =
//           category == _cropController.selectedCategory ? null : category;
//     });
//     _cropController.filterCrops();
//   }

//   void _navigateToCropDetail(dynamic crop) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FarmerCropDetailScreen(
//           cropId: crop["cropId"],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       drawer: _buildDrawer(context),
//       body: _cropController.isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//               backgroundColor: MyColors.primaryColor,
//             ))
//           : _cropController.userId == null
//               ? const Center(child: Text("User ID not found"))
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: ListView(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Good morning",
//                                 style: GoogleFonts.inter(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey[600]),
//                               ),
//                               Text(
//                                 username ?? "",
//                                 style: GoogleFonts.inter(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w600,
//                                     color: MyColors.black),
//                               ),
//                             ],
//                           ),
//                           if (imageUrl != null)
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(imageUrl!),
//                               radius: 24,
//                             ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12, bottom: 12),
//                         child: TextField(
//                           cursorColor: MyColors.primaryColor,
//                           onChanged: _onSearchChanged,
//                           decoration: InputDecoration(
//                             // labelText: "Search Crops",
//                             hintText: "Search Crops",
//                             prefixIcon: Icon(Icons.search,
//                                 color: MyColors.primaryColor),

//                             filled: true,
//                             fillColor: Colors.white, // Background color
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.circular(12), // Rounded borders
//                               borderSide: BorderSide(
//                                   color: MyColors.primaryColor, width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide:
//                                   BorderSide(color: MyColors.grey, width: 1.5),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                   color: MyColors.primaryColor, width: 2),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 15),
//                             // prefixIcon: const Icon(Icons.search),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 5.0, vertical: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _categoryButton("Fruit", Icons.apple),
//                             _categoryButton("Vegetable", Icons.eco),
//                             _categoryButton("Cereal", Icons.grain),
//                           ],
//                         ),
//                       ),
//                       _cropController.filteredCrops.isNotEmpty
//                           ? Row(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(top: 8, bottom: 8),
//                                   child: Text(
//                                     "Available Crops",
//                                     style: GoogleFonts.inter(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Container(),
//                       Expanded(
//                         child: _cropController.filteredCrops.isEmpty
//                             ? Center(
//                                 child:
//                                     //  Text("No crops found")
//                                     Text(
//                                   "No crops found",
//                                   style: GoogleFonts.inter(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.black),
//                                 ),
//                               )
//                             : GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   childAspectRatio: 0.75,
//                                   crossAxisSpacing: 16.0,
//                                   mainAxisSpacing: 16.0,
//                                 ),
//                                 itemCount: _cropController.filteredCrops.length,
//                                 itemBuilder: (context, index) {
//                                   final crop =
//                                       _cropController.filteredCrops[index];
//                                   return GestureDetector(
//                                     onTap: () => _navigateToCropDetail(crop),
//                                     child: Card(
//                                       elevation: 4,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.2),
//                                               spreadRadius: 1,
//                                               blurRadius: 3,
//                                               offset: const Offset(0, 2),
//                                             ),
//                                           ],
//                                         ),
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Stack(
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius:
//                                                         const BorderRadius
//                                                             .vertical(
//                                                       top:
//                                                           Radius.circular(15.0),
//                                                     ),
//                                                     child: Image.network(
//                                                       crop["imageUrl"],
//                                                       width: double.infinity,
//                                                       height: 150,
//                                                       fit: BoxFit.cover,
//                                                       errorBuilder: (context,
//                                                           error, stackTrace) {
//                                                         return const SizedBox(
//                                                           width:
//                                                               double.infinity,
//                                                           height: 150,
//                                                           child: Icon(
//                                                               Icons.image,
//                                                               size: 100),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     top: 8.0,
//                                                     right: 8.0,
//                                                     child: Container(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                           horizontal: 8.0,
//                                                           vertical: 4.0),
//                                                       decoration: BoxDecoration(
//                                                         color: MyColors
//                                                             .primaryColor,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8.0),
//                                                       ),
//                                                       child: Text(
//                                                         'View',
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: MyColors
//                                                               .backgroundScaffoldColor,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       crop["name"],
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         color: MyColors.black,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(height: 4),
//                                                     Text(
//                                                       'Quantity: ${crop["quantity"]}',
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 12,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         color: Colors.grey[600],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _categoryButton(String category, IconData icon) {
//     bool isSelected = _cropController.selectedCategory == category;
//     return GestureDetector(
//       onTap: () => _onCategorySelected(category),
//       child: Card(
//         color: isSelected ? MyColors.primaryColor : Colors.white,
//         elevation: 4,
//         child: Container(
//           width: 110,
//           height: 110,
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black54,
//                 )
//               ],
//               color: isSelected ? MyColors.primaryColor : Colors.white,
//               borderRadius: BorderRadius.circular(25)),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(width: 1, color: Colors.black26)),
//                 child: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: isSelected
//                       ? MyColors.backgroundScaffoldColor
//                       : Colors.white,
//                   child: Icon(icon, size: 30, color: MyColors.primaryColor),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               Text(
//                 category,
//                 style: GoogleFonts.inter(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: isSelected ? Colors.white : Colors.black),
//               ),
//               // Text(category),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColor,
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage:
//                     imageUrl != null ? NetworkImage(imageUrl!) : null,
//                 child: imageUrl == null ? const Icon(Icons.person) : null,
//               ),
//               accountName: Text(
//                 username ?? 'N/A',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: MyColors.backgroundScaffoldColor,
//                 ),
//               ),
//               accountEmail: Text(
//                 "${username ?? 'user'}@gmail.com",
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: MyColors.backgroundScaffoldColor,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: Text("Home", style: _drawerTextStyle()),
//               onTap: () => setState(() {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => FarmerMain()),
//                 );
//               }),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: Text("Profile", style: _drawerTextStyle()),
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.crop),
//               title: Text("Add Crop", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddCrop()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: Text("Confirms Orders", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => FarmerOrdersScreen()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_cart),
//               title: Text("Completed Orders", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => FarmerHistotyOrder()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.message),
//               title: Text("Messages", style: _drawerTextStyle()),
//               onTap: () {
//                 Get.to(ContactsScreen(phone: phoneno));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.smart_toy),
//               title: Text("ChatBot", style: _drawerTextStyle()),
//               onTap: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChatBotScreen()),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: Text("Settings", style: _drawerTextStyle()),
//               onTap: () {},
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 8, top: 24),
//               child: CustomButton(
//                 radius: CustomSize().customWidth(context) / 10,
//                 height: CustomSize().customHeight(context) / 15,
//                 width: CustomSize().customWidth(context) / 2,
//                 title: "Logout",
//                 loading: false,
//                 color: MyColors.primaryColor,
//                 onTap: () => LoginController().logout(context),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   TextStyle _drawerTextStyle() => GoogleFonts.inter(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: MyColors.black,
//       );
// }



// Complete CropListScreen.dart

import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Controllers/LoginController.dart';
import 'package:agriconnect/Views/Common/profile_screen.dart';
import 'package:agriconnect/Views/Farmer/AddCrop.dart';
import 'package:agriconnect/Views/Farmer/Complete_order.dart';
import 'package:agriconnect/Views/Farmer/detailcrops.dart';
import 'package:agriconnect/Views/Farmer/histoty_order.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:agriconnect/Views/chatting/contact.dart';
import 'package:agriconnect/chatbot_screen.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// UserController
class UserController {
  String? imageUrl;
  String? username;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    imageUrl = prefs.getString('imageUrl');
    username = prefs.getString('username');
  }
}

// CropController
class CropController {
  List<dynamic> crops = [];
  List<dynamic> filteredCrops = [];
  bool isLoading = true;
  int? userId;
  String searchQuery = "";
  String? selectedCategory;

  Future<void> fetchCrops() async {
    if (userId == null) {
      isLoading = false;
      return;
    }

    final String apiUrl = "http://152.67.10.128:5280/api/crops/farmer/$userId";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData.containsKey("\$values")) {
          crops = jsonData["\$values"];
          filteredCrops = crops;
        }
      }
    } catch (error) {
      print("Error: $error");
    }
    isLoading = false;
  }

  void filterCrops() {
    filteredCrops = crops.where((crop) {
      final matchesSearch = crop["name"].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == null || crop["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}

// UI
class CropListScreen extends StatefulWidget {
  final String? imageUrl;
  final String? username;
  final String? userId;

  const CropListScreen({this.imageUrl, this.username, this.userId});

  @override
  State<CropListScreen> createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
  final CropController _cropController = CropController();
  var phoneno;
  String? imageUrl;
  String? username;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    phoneno = prefs.getString('phoneNumber') ?? '';

    
    imageUrl = prefs.getString('imageUrl');
    username = prefs.getString('username');
    _cropController.userId = prefs.getInt('userId');
    await _cropController.fetchCrops();
    setState(() {});
  }

  void _onSearchChanged(String query) {
    setState(() {
      _cropController.searchQuery = query;
      _cropController.filterCrops();
    });
  }

  void _onCategorySelected(String? category) {
    setState(() {
      _cropController.selectedCategory = (_cropController.selectedCategory == category) ? null : category;
      _cropController.filterCrops();
    });
  }

  void _navigateToCropDetail(dynamic crop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerCropDetailScreen(cropId: crop["cropId"]),
      ),
    );
  }

  Widget _categoryButton(String category, IconData icon) {
    bool isSelected = _cropController.selectedCategory == category;
    return GestureDetector(
      onTap: () => _onCategorySelected(category),
      child: Card(
        color: isSelected ? MyColors.primaryColor : Colors.white,
        elevation: 4,
        child: Container(
          width: 110,
          height: 110,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                )
              ],
              color: isSelected ? MyColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.black26)),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: isSelected
                      ? MyColors.backgroundScaffoldColor
                      : Colors.white,
                  child: Icon(icon, size: 30, color: MyColors.primaryColor),
                ),
              ),
              const SizedBox(height: 5),

              Text(
                category,
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.black),
              ),
              // Text(category),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.backgroundScaffoldColor,
       appBar: AppBar(
      backgroundColor: Colors.transparent,

       ),
      drawer: _buildDrawer(context),
      body: _cropController.isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: MyColors.primaryColor,
            ))
          : _cropController.userId == null
              ? const Center(child: Text("User ID not found"))
              : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good morning",
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600]),
                              ),
                              Text(
                                username ?? "",
                                style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.primaryColor),
                              ),
                            ],
                          ),
                          if (imageUrl != null)
                            CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl!),
                              radius: 24,
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: TextField(
                          cursorColor: MyColors.primaryColor,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            // labelText: "Search Crops",
                            hintText: "Search Crops",
                            prefixIcon: Icon(Icons.search,
                                color: MyColors.primaryColor),

                            filled: true,
                            fillColor: Colors.white, // Background color
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded borders
                              borderSide: BorderSide(
                                  color: MyColors.primaryColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: MyColors.grey, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: MyColors.primaryColor, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            // prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _categoryButton("Fruit", Icons.apple),
                              _categoryButton("Vegetable", Icons.eco),
                              _categoryButton("Cereal", Icons.grain),
                            ],
                          ),
                        ),
                      ),
                      _cropController.filteredCrops.isNotEmpty
                          ? Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    "Available Crops",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Expanded(
                        child: _cropController.filteredCrops.isEmpty
                            ? Center(
                                child:
                                    //  Text("No crops found")
                                    Text(
                                  "No crops found",
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                                itemCount: _cropController.filteredCrops.length,
                                itemBuilder: (context, index) {
                                  final crop =
                                      _cropController.filteredCrops[index];
                                  return GestureDetector(
                                    onTap: () => _navigateToCropDetail(crop),
                                    child: Card(
                                      elevation: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top:
                                                          Radius.circular(15.0),
                                                    ),
                                                    child: Image.network(
                                                      crop["imageUrl"],
                                                      width: double.infinity,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 150,
                                                          child: Icon(
                                                              Icons.image,
                                                              size: 100),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 8.0,
                                                    right: 8.0,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0),
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Text(
                                                        'View',
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: MyColors
                                                              .backgroundScaffoldColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      crop["name"],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: MyColors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Quantity: ${crop["quantity"]}',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
            ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null ? const Icon(Icons.person) : null,
              ),
              accountName: Text(
                username ?? 'N/A',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.backgroundScaffoldColor,
                ),
              ),
              accountEmail: Text(
                "${username ?? 'user'}@gmail.com",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.backgroundScaffoldColor,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text("Home", style: _drawerTextStyle()),
              onTap: () => setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerMain()),
                );
              }),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Profile", style: _drawerTextStyle()),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.crop),
              title: Text("Add Crop", style: _drawerTextStyle()),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddCrop()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text("Confirms Orders", style: _drawerTextStyle()),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FarmerOrdersScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text("Completed Orders", style: _drawerTextStyle()),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FarmerHistotyOrder()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: Text("Messages", style: _drawerTextStyle()),
              onTap: () {
                Get.to(ContactsScreen(phone: phoneno));
              },
            ),
            ListTile(
              leading: Icon(Icons.smart_toy),
              title: Text("ChatBot", style: _drawerTextStyle()),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text("Settings", style: _drawerTextStyle()),
              onTap: () {},
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, top: 24),
              child: CustomButton(
                radius: CustomSize().customWidth(context) / 10,
                height: CustomSize().customHeight(context) / 15,
                width: CustomSize().customWidth(context) / 2,
                title: "Logout",
                loading: false,
                color: MyColors.primaryColor,
                onTap: () => LoginController().logout(context),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  TextStyle _drawerTextStyle() => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MyColors.black,
      );
}