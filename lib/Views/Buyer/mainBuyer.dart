// // // // import 'package:agriconnect/Controllers/LoginController.dart';
// // // // import 'package:agriconnect/Controllers/buyerController.dart';
// // // // import 'package:agriconnect/Models/CropModel.dart';
// // // // import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
// // // // import 'package:agriconnect/Views/Buyer/complete_order.dart';
// // // // import 'package:agriconnect/Views/Buyer/history_order.dart';
// // // // import 'package:agriconnect/Views/Common/profile_screen.dart';
// // // // import 'package:agriconnect/Views/Order/detailed.dart';
// // // // import 'package:agriconnect/Views/Order/shoppingCard.dart';
// // // // import 'package:agriconnect/constants/colors.dart';
// // // // import 'package:flutter/foundation.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'dart:convert';
// // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // class BuyerMain extends StatefulWidget {
// // // //   BuyerMain({Key? key}) : super(key: key);

// // // //   @override
// // // //   _BuyerMainState createState() => _BuyerMainState();
// // // // }

// // // // class _BuyerMainState extends State<BuyerMain> {
// // // //   final BuyerController _controller = BuyerController();
// // // //   List<Crop> crops = [];
// // // //   List<Crop> filteredCrops = [];
// // // //   bool isLoading = true;
// // // //   String? imageUrl;
// // // //   String? username;
// // // //   int? userId;
// // // //   String? roleName;
// // // //   String categoryFilter = "";
// // // //   String nameFilter = "";
// // // //   int _selectedIndex = 0;
// // // //   List<String> categories = [];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     fetchCrops();
// // // //     _loadUserData();
// // // //   }

// // // //   Future<void> _loadUserData() async {
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     setState(() {
// // // //       username = prefs.getString('username');
// // // //       imageUrl = prefs.getString('imageUrl');
// // // //       userId = prefs.getInt('userId');
// // // //       roleName = prefs.getString('roleName');
// // // //     });
// // // //   }

// // // //   Future<void> fetchCrops() async {
// // // //     final url = Uri.parse('http://152.67.10.128:5280/api/Order/Available-crop');
// // // //     try {
// // // //       final response = await http.get(url);
// // // //       if (response.statusCode == 200) {
// // // //         final Map<String, dynamic> data = json.decode(response.body);
// // // //         final List<dynamic> values = data['\$values'];
// // // //         setState(() {
// // // //           crops = values.map((crop) => Crop.fromJson(crop)).toList();
// // // //           filteredCrops = crops;
// // // //           isLoading = false;
// // // //           categories = crops.map((crop) => crop.category).toSet().toList();
// // // //           categories.add("All"); // Add "All" option to categories
// // // //         });
// // // //       } else {
// // // //         throw Exception('Failed to load crops');
// // // //       }
// // // //     } catch (e) {
// // // //       print('Error fetching crops: $e');
// // // //       setState(() {
// // // //         isLoading = false;
// // // //       });
// // // //     }
// // // //   }

// // // //   void _filterCrops() {
// // // //     setState(() {
// // // //       filteredCrops = crops.where((crop) {
// // // //         final categoryMatch = categoryFilter.isEmpty ||
// // // //             crop.category.toLowerCase().contains(categoryFilter.toLowerCase());
// // // //         final nameMatch = nameFilter.isEmpty ||
// // // //             crop.name.toLowerCase().contains(nameFilter.toLowerCase());
// // // //         return categoryMatch && nameMatch;
// // // //       }).toList();
// // // //     });
// // // //   }

// // // //   Widget _buildHomeScreen() {
// // // //     return Column(
// // // //       children: [
// // // //         Padding(
// // // //           padding: const EdgeInsets.all(8.0),
// // // //           child:
// // // //           // Row(
// // // //           //   children: [
// // // //           //     Expanded(
// // // //           //       child: TextField(
// // // //           //         decoration: InputDecoration(labelText: 'Category'),
// // // //           //         onChanged: (value) {
// // // //           //           categoryFilter = value;
// // // //           //           _filterCrops();
// // // //           //         },
// // // //           //       ),
// // // //           //     ),
// // // //           //     SizedBox(width: 8),
// // // //           //     Expanded(
// // // //           //       child: TextField(
// // // //           //         decoration: InputDecoration(labelText: 'Name'),
// // // //           //         onChanged: (value) {
// // // //           //           nameFilter = value;
// // // //           //           _filterCrops();
// // // //           //         },
// // // //           //       ),
// // // //           //     ),
// // // //           //   ],
// // // //           // ),
// // // // //           Row(
// // // // //   children: [
// // // // //     Expanded(
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.only(right: 8.0), // Adds spacing between TextFields
// // // // //         child: TextField(
// // // // //           decoration: InputDecoration(
// // // // //             labelText: 'Category',
// // // // //             labelStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500), // Custom label style
// // // // //             hintText: 'Enter category',
// // // // //             hintStyle: TextStyle(color: Colors.grey[500]), // Custom hint style
// // // // //             filled: true,
// // // // //             fillColor: Colors.white, // Background color for the TextField
// // // // //             contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0), // Padding inside the TextField
// // // // //             border: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0), // Rounded corners
// // // // //               borderSide: BorderSide(color: Colors.grey, width: 1.0), // Border styling
// // // // //             ),
// // // // //             focusedBorder: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               borderSide: BorderSide(color: MyColors.primaryColor, width: 2.0), // Focused border color
// // // // //             ),
// // // // //             enabledBorder: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0), // Default border
// // // // //             ),
// // // // //           ),
// // // // //           onChanged: (value) {
// // // // //             categoryFilter = value;
// // // // //             _filterCrops();
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //     ),
// // // // //     SizedBox(width: 8),
// // // // //     Expanded(
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.only(left: 8.0), // Adds spacing between TextFields
// // // // //         child: TextField(
// // // // //           decoration: InputDecoration(
// // // // //             labelText: 'Name',
// // // // //             labelStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500), // Custom label style
// // // // //             hintText: 'Enter crop name',
// // // // //             hintStyle: TextStyle(color: Colors.grey[500]), // Custom hint style
// // // // //             filled: true,
// // // // //             fillColor: Colors.white, // Background color for the TextField
// // // // //             contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0), // Padding inside the TextField
// // // // //             border: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0), // Rounded corners
// // // // //               borderSide: BorderSide(color: Colors.grey, width: 1.0), // Border styling
// // // // //             ),
// // // // //             focusedBorder: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               borderSide: BorderSide(color: MyColors.primaryColor, width: 2.0), // Focused border color
// // // // //             ),
// // // // //             enabledBorder: OutlineInputBorder(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0), // Default border
// // // // //             ),
// // // // //           ),
// // // // //           onChanged: (value) {
// // // // //             nameFilter = value;
// // // // //             _filterCrops();
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //     ),
// // // // //   ],
// // // // // ),
// // // //   Row(
// // // //           children: [
// // // //             // Search bar for name
// // // //             Expanded(
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.only(right: 8.0,left: 12),
// // // //                 child: TextField(
// // // //                   decoration: InputDecoration(
// // // //                     labelText: 'Search by Name',
// // // //                     labelStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500),
// // // //                     hintText: 'Enter crop name',
// // // //                     hintStyle: TextStyle(color: Colors.grey[500]),
// // // //                     filled: true,
// // // //                     fillColor: Colors.white,
// // // //                     contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
// // // //                     border: OutlineInputBorder(
// // // //                       borderRadius: BorderRadius.circular(12.0),
// // // //                       borderSide: BorderSide(color: Colors.grey, width: 1.0),
// // // //                     ),
// // // //                     focusedBorder: OutlineInputBorder(
// // // //                       borderRadius: BorderRadius.circular(12.0),
// // // //                       borderSide: BorderSide(color: Colors.blue, width: 2.0),
// // // //                     ),
// // // //                   ),
// // // //                   onChanged: (value) {
// // // //                     setState(() {
// // // //                       nameFilter = value;
// // // //                     });
// // // //                     _filterCrops();
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             // Filter Icon
// // // //             IconButton(
// // // //               icon: Icon(Icons.filter_list,color: MyColors.primaryColor,size: 35,),
// // // //               onPressed: () {
// // // //                 _showCategoryFilterDialog();
// // // //               },
// // // //             ),
// // // //           ],
// // // //         )
// // // //         ),
// // // //         // Expanded(
// // // //         //   child: isLoading
// // // //         //       ? Center(child: CircularProgressIndicator())
// // // //         //       : GridView.builder(
// // // //         //           padding: const EdgeInsets.all(8.0),
// // // //         //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // // //         //             crossAxisCount: 1,
// // // //         //             crossAxisSpacing: 10,
// // // //         //             mainAxisSpacing: 10,
// // // //         //             childAspectRatio: 0.8,
// // // //         //           ),
// // // //         //           itemCount: filteredCrops.length,
// // // //         //           itemBuilder: (context, index) {
// // // //         //             return CropCard(crop: filteredCrops[index]);
// // // //         //           },
// // // //         //         ),
// // // //         // ),
// // // //         Expanded(
// // // //   child: isLoading
// // // //       ? Center(child: CircularProgressIndicator())
// // // //       : ListView.builder(
// // // //           padding: const EdgeInsets.all(8.0),
// // // //           itemCount: filteredCrops.length,
// // // //           itemBuilder: (context, index) {
// // // //             return Padding(
// // // //               padding: const EdgeInsets.only(top: 13),
// // // //               child: CropCard(crop: filteredCrops[index]),
// // // //             );
// // // //           },
// // // //         ),
// // // // ),

// // // //       ],
// // // //     );
// // // //   }

// // // //   void _showCategoryFilterDialog() {

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         return AlertDialog(
// // // //           backgroundColor: MyColors.backgroundScaffoldColor,
// // // //           title: Text("Select Category",style: TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w900),),
// // // //           content: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: categories.map((category) {
// // // //               return RadioListTile<String>(
// // // //                 value: category,
// // // //                 groupValue: categoryFilter,
// // // //                 onChanged: (value) {
// // // //                   setState(() {
// // // //                     categoryFilter = value!;
// // // //                     if(categoryFilter == "All"){
// // // //                       categoryFilter = "";
// // // //                     }
// // // //                   });
// // // //                   _filterCrops();
// // // //                   Navigator.pop(context); // Close the dialog after selecting
// // // //                 },
// // // //                 title: Text(category),
// // // //               );
// // // //             }).toList(),
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 Navigator.pop(context); // Close the dialog
// // // //               },
// // // //               child: Text("Cancel"),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   Widget _buildProfileScreen() {
// // // //     return ProfileScreen();
// // // //   }

// // // //   Widget _buildshopingscrenn() {
// // // //     return ShoppingScreen();
// // // //   }

// // // //   // Widget _buildShoppingScreen() {
// // // //   //   return Center(child: Text('Shopping Cart Screen'));
// // // //   // }

// // // //   void _onItemTapped(int index) {
// // // //     setState(() {
// // // //       _selectedIndex = index;
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: MyColors.backgroundScaffoldColor,
// // // //       appBar: AppBar(
// // // //         backgroundColor: MyColors.backgroundScaffoldColor,
// // // //       //   title: const Text('Buyer Main Page'),
// // // //         actions: [
// // // //           if (imageUrl != null)
// // // //             Padding(
// // // //               padding: const EdgeInsets.only(right: 8.0),
// // // //               child: CircleAvatar(
// // // //                 backgroundImage: NetworkImage(imageUrl!),
// // // //                 radius: 20,
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //       //  appBar: AppBar(
// // // //         // title: Container(
// // // //         //   margin: EdgeInsets.only(top: 4),
// // // //         //   child: Text(
// // // //         //     "Abhi Buy Kare  Sasta and taza fasal",
// // // //         //     maxLines: 2,
// // // //         //     textAlign: TextAlign.center,
// // // //         //     style: TextStyle(
// // // //         //       fontFamily: 'Gilroy',
// // // //         //       fontSize: 24,
// // // //         //       height: 1,
// // // //         //       // fontWeight: FontWeight.bold,
// // // //         //       color: MyColors.primaryColor,
// // // //         //       // color: MyColors.secondaryColor,
// // // //         //     ),
// // // //         //   ),
// // // //         // ),

// // // //         // Text('Buyer Main Page'),
// // // //       //   actions: [
// // // //       //     if (imageUrl != null)
// // // //       //       Padding(
// // // //       //         padding: const EdgeInsets.only(right: 8.0,top: 10),
// // // //       //         child: Container(
// // // //       //           margin: EdgeInsets.only(top: 4),
// // // //       //           child: CircleAvatar(
// // // //       //             backgroundImage: NetworkImage(imageUrl!),
// // // //       //             radius: 30,
// // // //       //           ),
// // // //       //         ),
// // // //       //       ),
// // // //       //   ],
// // // //       // ),
// // // //       drawer: Drawer(
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.only(top: 10.0),
// // // //           child: Column(
// // // //             children: [
// // // //               UserAccountsDrawerHeader(
// // // //                 currentAccountPicture: CircleAvatar(
// // // //                   backgroundImage:
// // // //                       imageUrl != null ? NetworkImage(imageUrl!) : null,
// // // //                   child: imageUrl == null ? const Icon(Icons.person) : null,
// // // //                 ),
// // // //                 accountName: Text('${username}'),
// // // //                 accountEmail: Text('${userId}'),
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.home),
// // // //                 title: const Text('Home'),
// // // //                 onTap: () => _onItemTapped(0),
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.person),
// // // //                 title: const Text('Profile'),
// // // //                 onTap: () => _onItemTapped(1),
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.shopping_cart),
// // // //                 title: const Text('Cart'),
// // // //                 onTap: () => _onItemTapped(2),
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.logout),
// // // //                 title: const Text('Logout'),
// // // //                 onTap: () {
// // // //                   LoginController().logout(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.shopping_cart_rounded),
// // // //                 title: const Text('Ordered'),
// // // //                 onTap: () {
// // // //                   Navigator.pushReplacement(
// // // //                     context,
// // // //                     MaterialPageRoute(
// // // //                         builder: (context) => ConfirmedOrdersScreen()),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.money),
// // // //                 title: const Text('Transection'),
// // // //                 onTap: () {
// // // //                   Navigator.pushReplacement(
// // // //                     context,
// // // //                     MaterialPageRoute(
// // // //                         builder: (context) => TransactionScreen(userId: userId!)),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 leading: const Icon(Icons.money),
// // // //                 title: const Text('History Order'),
// // // //                 onTap: () {
// // // //                   Navigator.pushReplacement(
// // // //                     context,
// // // //                     MaterialPageRoute(
// // // //                         builder: (context) => HistoryOrder()),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       body: IndexedStack(
// // // //         index: _selectedIndex,
// // // //         children: [
// // // //           _buildHomeScreen(),
// // // //           _buildProfileScreen(),
// // // //           ShoppingScreen(),
// // // //         ],
// // // //       ),
// // // //       bottomNavigationBar: BottomNavigationBar(
// // // //         currentIndex: _selectedIndex,
// // // //         onTap: (index) {
// // // //           if (index == 2) {
// // // //             // Assuming ShoppingScreen is at index 2
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(builder: (context) => ShoppingScreen()),
// // // //             );
// // // //           } else {
// // // //             setState(() {
// // // //               _selectedIndex = index;
// // // //             });
// // // //           }
// // // //         },
// // // //         items: [
// // // //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// // // //           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
// // // //           BottomNavigationBarItem(
// // // //               icon: Icon(Icons.shopping_cart), label: 'Cart'),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class CropCard extends StatelessWidget {
// // // //   final Crop crop;

// // // //   CropCard({required this.crop});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 4),
// // // //       child: GestureDetector(
// // // //         onTap: () {
// // // //           Navigator.push(
// // // //             context,
// // // //             MaterialPageRoute(
// // // //               builder: (context) => CropDetailScreen(
// // // //                 name: crop.name,
// // // //                 category: crop.category,
// // // //                 imageUrl: crop.imageUrl,
// // // //                 price: crop.price,
// // // //                 quantity: crop.quantity,
// // // //                 farmerId: crop.farmerId,
// // // //                 cropid: crop.cropId,
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //         child: Container(
// // // //           decoration: BoxDecoration(
// // // //             borderRadius: BorderRadius.circular(20),
// // // //             color: Colors.white,
// // // //             boxShadow: [
// // // //               BoxShadow(
// // // //                 color: MyColors.primaryColor.withOpacity(0.5),
// // // //                 spreadRadius: 1,
// // // //                 blurRadius: 1,
// // // //                 offset: Offset(3, 2), // changes position of shadow
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           child: Card(
// // // //             color: Colors.white,
// // // //             // shadowColor: MyColors.primaryColor,
// // // //             // elevation: 10,
// // // //             // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // // //             child: Row(
// // // //               mainAxisSize: MainAxisSize.min, // Makes the Row take only as much space as needed
// // // //               crossAxisAlignment: CrossAxisAlignment.start, // Aligns content at the start
// // // //               children: [
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(8.0),
// // // //             child: Container(
// // // //               height: 75,
// // // //               width: 75,
// // // //               decoration: BoxDecoration(
// // // //                 border: Border.all(color: MyColors.primaryColor, width: 1),
// // // //                 borderRadius: BorderRadius.all(Radius.circular(15)),
// // // //                 color: Colors.white, // Background color of the container
// // // //               ),
// // // //               child: ClipRRect(
// // // //                 borderRadius: BorderRadius.all(Radius.circular(15)),
// // // //                 child: Image.network(
// // // //                   crop.imageUrl,
// // // //                   width: 60, // Set a fixed width
// // // //                   height: 60, // Set a fixed height for the image
// // // //                   fit: BoxFit.cover,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Padding(
// // // //                 padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 22),
// // // //                 child: Text(
// // // //                   crop.name,
// // // //                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //               ),
// // // //               Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // // //                 child: Text(
// // // //                   'Price: ${crop.price} per kg',
// // // //                   style: TextStyle(fontSize: 17, color: MyColors.primaryColor,fontWeight: FontWeight.bold),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         )

// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:agriconnect/Controllers/LoginController.dart';
// // // import 'package:agriconnect/Controllers/buyerController.dart';
// // // import 'package:agriconnect/Models/CropModel.dart';
// // // import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
// // // import 'package:agriconnect/Views/Buyer/complete_order.dart';
// // // import 'package:agriconnect/Views/Buyer/history_order.dart';
// // // import 'package:agriconnect/Views/Common/profile_screen.dart';
// // // import 'package:agriconnect/Views/Order/detailed.dart';
// // // import 'package:agriconnect/Views/Order/shoppingCard.dart';
// // // import 'package:agriconnect/constants/colors.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class BuyerMain extends StatefulWidget {
// // //   BuyerMain({Key? key}) : super(key: key);

// // //   @override
// // //   _BuyerMainState createState() => _BuyerMainState();
// // // }

// // // class _BuyerMainState extends State<BuyerMain> {
// // //   final BuyerController _controller = BuyerController();
// // //   List<Crop> crops = [];
// // //   List<Crop> filteredCrops = [];
// // //   bool isLoading = true;
// // //   String? imageUrl;
// // //   String? username;
// // //   int? userId;
// // //   String? roleName;
// // //   String categoryFilter = "";
// // //   String nameFilter = "";
// // //   int _selectedIndex = 0;
// // //   List<String> categories = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchCrops();
// // //     _loadUserData();
// // //   }

// // //   Future<void> _loadUserData() async {
// // //     final prefs = await SharedPreferences.getInstance();
// // //     setState(() {
// // //       username = prefs.getString('username');
// // //       imageUrl = prefs.getString('imageUrl');
// // //       userId = prefs.getInt('userId');
// // //       roleName = prefs.getString('roleName');
// // //     });
// // //   }

// // //   Future<void> fetchCrops() async {
// // //     final url = Uri.parse('http://152.67.10.128:5280/api/Order/Available-crop');
// // //     try {
// // //       final response = await http.get(url);
// // //       if (response.statusCode == 200) {
// // //         final Map<String, dynamic> data = json.decode(response.body);
// // //         final List<dynamic> values = data['\$values'];
// // //         setState(() {
// // //           crops = values.map((crop) => Crop.fromJson(crop)).toList();
// // //           filteredCrops = crops;
// // //           isLoading = false;
// // //           categories = crops.map((crop) => crop.category).toSet().toList();
// // //           categories.insert(0, "All"); // Add "All" option at the beginning
// // //         });
// // //       } else {
// // //         throw Exception('Failed to load crops');
// // //       }
// // //     } catch (e) {
// // //       print('Error fetching crops: $e');
// // //       setState(() {
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }

// // //   void _filterCrops() {
// // //     setState(() {
// // //       filteredCrops = crops.where((crop) {
// // //         final categoryMatch = categoryFilter.isEmpty ||
// // //             crop.category.toLowerCase().contains(categoryFilter.toLowerCase());
// // //         final nameMatch = nameFilter.isEmpty ||
// // //             crop.name.toLowerCase().contains(nameFilter.toLowerCase());
// // //         return categoryMatch && nameMatch;
// // //       }).toList();
// // //     });
// // //   }

// // //   Widget _buildHomeScreen() {
// // //     return Column(
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Row(
// // //             children: [
// // //               Expanded(
// // //                 child: TextField(
// // //                   decoration: InputDecoration(
// // //                     hintText: 'Search for crops...',
// // //                     prefixIcon: Icon(Icons.search),
// // //                     border: OutlineInputBorder(
// // //                       borderRadius: BorderRadius.circular(10.0),
// // //                       borderSide: BorderSide(color: Colors.grey[300]!),
// // //                     ),
// // //                     focusedBorder: OutlineInputBorder(
// // //                       borderRadius: BorderRadius.circular(10.0),
// // //                       borderSide: BorderSide(color: MyColors.primaryColor),
// // //                     ),
// // //                     filled: true,
// // //                     fillColor: Colors.white,
// // //                   ),
// // //                   onChanged: (value) {
// // //                     setState(() {
// // //                       nameFilter = value;
// // //                     });
// // //                     _filterCrops();
// // //                   },
// // //                 ),
// // //               ),
// // //               SizedBox(width: 10),
// // //               InkWell(
// // //                 onTap: _showCategoryFilterBottomSheet,
// // //                 child: Container(
// // //                   padding: EdgeInsets.all(10.0),
// // //                   decoration: BoxDecoration(
// // //                     color: MyColors.primaryColor,
// // //                     borderRadius: BorderRadius.circular(10.0),
// // //                   ),
// // //                   child: Icon(Icons.filter_list, color: Colors.white),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //         Expanded(
// // //           child: isLoading
// // //               ? Center(child: CircularProgressIndicator())
// // //               : GridView.builder(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // //                     crossAxisCount: 2,
// // //                     childAspectRatio: 0.75,
// // //                     crossAxisSpacing: 16.0,
// // //                     mainAxisSpacing: 16.0,
// // //                   ),
// // //                   itemCount: filteredCrops.length,
// // //                   itemBuilder: (context, index) {
// // //                     return CropGridCard(crop: filteredCrops[index]);
// // //                   },
// // //                 ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   void _showCategoryFilterBottomSheet() {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return Container(
// // //           padding: EdgeInsets.all(16.0),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 'Filter by Category',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //               ),
// // //               SizedBox(height: 10),
// // //               Expanded(
// // //                 child: ListView.builder(
// // //                   shrinkWrap: true,
// // //                   itemCount: categories.length,
// // //                   itemBuilder: (context, index) {
// // //                     final category = categories[index];
// // //                     return RadioListTile<String>(
// // //                       title: Text(category == "All" ? "All Categories" : category),
// // //                       value: category,
// // //                       groupValue: categoryFilter,
// // //                       onChanged: (value) {
// // //                         setState(() {
// // //                           categoryFilter = value!;
// // //                           if (categoryFilter == "All") {
// // //                             categoryFilter = "";
// // //                           }
// // //                         });
// // //                         _filterCrops();
// // //                         Navigator.pop(context);
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildProfileScreen() {
// // //     return ProfileScreen();
// // //   }

// // //   Widget _buildshopingscrenn() {
// // //     return ShoppingScreen();
// // //   }

// // //   void _onItemTapped(int index) {
// // //     setState(() {
// // //       _selectedIndex = index;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: MyColors.backgroundScaffoldColor,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         title: Text(
// // //           'AgriConnect',
// // //           style: TextStyle(color: MyColors.primaryColor, fontWeight: FontWeight.bold),
// // //         ),
// // //         actions: [
// // //           if (imageUrl != null)
// // //             Padding(
// // //               padding: const EdgeInsets.only(right: 16.0),
// // //               child: CircleAvatar(
// // //                 backgroundImage: NetworkImage(imageUrl!),
// // //                 radius: 20,
// // //               ),
// // //             ),
// // //           IconButton(
// // //             icon: Icon(Icons.shopping_cart_outlined, color: MyColors.primaryColor),
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (context) => ShoppingScreen()),
// // //               );
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       drawer: Drawer(
// // //         child: Padding(
// // //           padding: const EdgeInsets.only(top: 10.0),
// // //           child: Column(
// // //             children: [
// // //               UserAccountsDrawerHeader(
// // //                 decoration: BoxDecoration(
// // //                   color: MyColors.primaryColor.withOpacity(0.8),
// // //                 ),
// // //                 currentAccountPicture: CircleAvatar(
// // //                   backgroundColor: Colors.white,
// // //                   backgroundImage:
// // //                       imageUrl != null ? NetworkImage(imageUrl!) : null,
// // //                   child: imageUrl == null ? const Icon(Icons.person) : null,
// // //                 ),
// // //                 accountName: Text('${username ?? "Guest"}', style: TextStyle(fontWeight: FontWeight.bold)),
// // //                 accountEmail: Text('${userId != null ? "User ID: $userId" : ""}', style: TextStyle(color: Colors.white70)),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.home_outlined),
// // //                 title: const Text('Home'),
// // //                 onTap: () => _onItemTapped(0),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.person_outline),
// // //                 title: const Text('Profile'),
// // //                 onTap: () => _onItemTapped(1),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.shopping_cart_outlined),
// // //                 title: const Text('Cart'),
// // //                 onTap: () => _onItemTapped(2),
// // //               ),
// // //               Divider(),
// // //               ListTile(
// // //                 leading: const Icon(Icons.check_circle_outline),
// // //                 title: const Text('My Orders'),
// // //                 onTap: () {
// // //                   Navigator.pushReplacement(
// // //                     context,
// // //                     MaterialPageRoute(
// // //                         builder: (context) => ConfirmedOrdersScreen()),
// // //                   );
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.swap_horiz_outlined),
// // //                 title: const Text('Transactions'),
// // //                 onTap: () {
// // //                   Navigator.pushReplacement(
// // //                     context,
// // //                     MaterialPageRoute(
// // //                         builder: (context) => TransactionScreen(userId: userId!)),
// // //                   );
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.history_outlined),
// // //                 title: const Text('Order History'),
// // //                 onTap: () {
// // //                   Navigator.pushReplacement(
// // //                     context,
// // //                     MaterialPageRoute(builder: (context) => HistoryOrder()),
// // //                   );
// // //                 },
// // //               ),
// // //               Divider(),
// // //               ListTile(
// // //                 leading: const Icon(Icons.logout),
// // //                 title: const Text('Logout'),
// // //                 onTap: () {
// // //                   LoginController().logout(context);
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //       body: IndexedStack(
// // //         index: _selectedIndex,
// // //         children: [
// // //           _buildHomeScreen(),
// // //           _buildProfileScreen(),
// // //           _buildshopingscrenn(),
// // //         ],
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _selectedIndex,
// // //         selectedItemColor: MyColors.primaryColor,
// // //         unselectedItemColor: Colors.grey,
// // //         onTap: (index) {
// // //           setState(() {
// // //             _selectedIndex = index;
// // //           });
// // //         },
// // //         items: [
// // //           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
// // //           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
// // //           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class CropGridCard extends StatelessWidget {
// // //   final Crop crop;

// // //   CropGridCard({required this.crop});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (context) => CropDetailScreen(
// // //               name: crop.name,
// // //               category: crop.category,
// // //               imageUrl: crop.imageUrl,
// // //               price: crop.price,
// // //               quantity: crop.quantity,
// // //               farmerId: crop.farmerId,
// // //               cropid: crop.cropId,
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //       child: Container(
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(15.0),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.grey.withOpacity(0.2),
// // //               spreadRadius: 1,
// // //               blurRadius: 3,
// // //               offset: Offset(0, 2),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Expanded(
// // //               child: ClipRRect(
// // //                 borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
// // //                 child: Image.network(
// // //                   crop.imageUrl,
// // //                   width: double.infinity,
// // //                   fit: BoxFit.cover,
// // //                   errorBuilder: (context, error, stackTrace) {
// // //                     return Container(
// // //                       color: Colors.grey[200],
// // //                       child: Center(child: Icon(Icons.image_not_supported)),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     crop.name,
// // //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // //                     maxLines: 2,
// // //                     overflow: TextOverflow.ellipsis,
// // //                   ),
// // //                   SizedBox(height: 4),
// // //                   Text(
// // //                     'Category: ${crop.category}',
// // //                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
// // //                   ),
// // //                   SizedBox(height: 8),
// // //                   Text(
// // //                     '\$${crop.price}/kg',
// // //                     style: TextStyle(color: MyColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:agriconnect/Controllers/LoginController.dart';
// // import 'package:agriconnect/Controllers/buyerController.dart';
// // import 'package:agriconnect/Models/CropModel.dart';
// // import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
// // import 'package:agriconnect/Views/Buyer/complete_order.dart';
// // import 'package:agriconnect/Views/Buyer/history_order.dart';
// // import 'package:agriconnect/Views/Common/profile_screen.dart';
// // import 'package:agriconnect/Views/Order/detailed.dart';
// // import 'package:agriconnect/Views/Order/shoppingCard.dart';
// // import 'package:agriconnect/constants/colors.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class BuyerMain extends StatefulWidget {
// //   BuyerMain({Key? key}) : super(key: key);

// //   @override
// //   _BuyerMainState createState() => _BuyerMainState();
// // }

// // class _BuyerMainState extends State<BuyerMain> {
// //   final BuyerController _controller = BuyerController();
// //   List<Crop> crops = [];
// //   List<Crop> filteredCrops = [];
// //   bool isLoading = true;
// //   String? imageUrl;
// //   String? username = "Guest"; // Default username
// //   int? userId;
// //   String? roleName;
// //   String categoryFilter = "";
// //   String nameFilter = "";
// //   int _selectedIndex = 0;
// //   List<String> categories = [];
// //   final TextEditingController _searchController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchCrops();
// //     _loadUserData();
// //   }

// //   Future<void> _loadUserData() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     setState(() {
// //       username = prefs.getString('username') ?? "Guest";
// //       imageUrl = prefs.getString('imageUrl');
// //       userId = prefs.getInt('userId');
// //       roleName = prefs.getString('roleName');
// //     });
// //   }

// //   Future<void> fetchCrops() async {
// //     final url = Uri.parse('http://152.67.10.128:5280/api/Order/Available-crop');
// //     try {
// //       final response = await http.get(url);
// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> data = json.decode(response.body);
// //         final List<dynamic> values = data['\$values'];
// //         setState(() {
// //           crops = values.map((crop) => Crop.fromJson(crop)).toList();
// //           filteredCrops = crops;
// //           isLoading = false;
// //           categories = crops.map((crop) => crop.category).toSet().toList();
// //           categories.insert(0, "All"); // Add "All" option at the beginning
// //         });
// //       } else {
// //         throw Exception('Failed to load crops');
// //       }
// //     } catch (e) {
// //       print('Error fetching crops: $e');
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   void _filterCrops() {
// //     setState(() {
// //       filteredCrops = crops.where((crop) {
// //         final categoryMatch = categoryFilter.isEmpty ||
// //             crop.category.toLowerCase().contains(categoryFilter.toLowerCase());
// //         final nameMatch = nameFilter.isEmpty ||
// //             crop.name.toLowerCase().contains(nameFilter.toLowerCase());
// //         return categoryMatch && nameMatch;
// //       }).toList();
// //     });
// //   }

// //   Widget _buildHomeScreen() {
// //     return Scaffold(
// //         extendBodyBehindAppBar: true,
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent, // Transparent AppBar
// //           elevation: 0,
// //           title: Text('AgriConnect'),
// //         ),
// //         body: Container(
// //           height: MediaQuery.of(context).size.height,
// //           width: MediaQuery.of(context).size.width,
// //           decoration: BoxDecoration(
// //             image: DecorationImage(
// //               image: AssetImage('assets/bg6.png'),
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           child: SafeArea(
// //             child: SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text('Good morning',
// //                                 style: TextStyle(
// //                                     color: Colors.grey[600], fontSize: 14)),
// //                             Text(username!,
// //                                 style: TextStyle(
// //                                     fontSize: 22, fontWeight: FontWeight.bold)),
// //                           ],
// //                         ),
// //                         if (imageUrl != null)
// //                           CircleAvatar(
// //                             backgroundImage: NetworkImage(imageUrl!),
// //                             radius: 24,
// //                           ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 16),
// //                     // TextField(
// //                     //   controller: _searchController,
// //                     //   decoration: InputDecoration(
// //                     //     hintText: 'Search for crops',
// //                     //     prefixIcon: Icon(Icons.search, color: Colors.grey),
// //                     //     border: OutlineInputBorder(
// //                     //       borderRadius: BorderRadius.circular(12.0),
// //                     //       borderSide: BorderSide.none,
// //                     //     ),
// //                     //     filled: true,
// //                     //     fillColor: Colors.grey[200],
// //                     //   ),
// //                     //   onChanged: (value) {
// //                     //     setState(() {
// //                     //       nameFilter = value;
// //                     //     });
// //                     //     _filterCrops();
// //                     //   },
// //                     // ),
// //                     Padding(
// //                       padding: const EdgeInsets.all(16.0),
// //                       child: Row(
// //                         children: [
// //                           Expanded(
// //                             child: TextField(
// //                               controller: _searchController,
// //                               decoration: InputDecoration(
// //                                 hintText: 'Search for crops',
// //                                 prefixIcon:
// //                                     Icon(Icons.search, color: Colors.grey),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12.0),
// //                                   borderSide: BorderSide.none,
// //                                 ),
// //                                 filled: true,
// //                                 fillColor: Colors.grey[200],
// //                               ),
// //                               onChanged: (value) {
// //                                 setState(() {
// //                                   nameFilter = value;
// //                                 });
// //                                 _filterCrops();
// //                               },
// //                             ),
// //                           ),
// //                           SizedBox(width: 10),
// //                           InkWell(
// //                             onTap: _showCategoryFilterBottomSheet,
// //                             child: Container(
// //                               padding: EdgeInsets.all(10.0),
// //                               decoration: BoxDecoration(
// //                                 color: MyColors.primaryColor,
// //                                 borderRadius: BorderRadius.circular(10.0),
// //                               ),
// //                               child:
// //                                   Icon(Icons.filter_list, color: Colors.white),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     SizedBox(height: 24),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text('Available Crops',
// //                             style: TextStyle(
// //                                 fontSize: 18, fontWeight: FontWeight.bold)),
// //                         // You might want to add a "View All" button here if you have many crops
// //                       ],
// //                     ),
// //                     SizedBox(height: 16),
// //                     isLoading
// //                         ? Center(child: CircularProgressIndicator())
// //                         : GridView.builder(
// //                             shrinkWrap: true,
// //                             physics:
// //                                 NeverScrollableScrollPhysics(), // To disable scrolling of GridView within SingleChildScrollView
// //                             gridDelegate:
// //                                 SliverGridDelegateWithFixedCrossAxisCount(
// //                               crossAxisCount: 2,
// //                               childAspectRatio: 0.75,
// //                               crossAxisSpacing: 16.0,
// //                               mainAxisSpacing: 16.0,
// //                             ),
// //                             itemCount: filteredCrops.length,
// //                             itemBuilder: (context, index) {
// //                               return CropGridCard(crop: filteredCrops[index]);
// //                             },
// //                           ),
// //                     // You can add more sections here like "Featured Crops" or "Categories"
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ));
// //   }

// //   void _showCategoryFilterBottomSheet() {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return Container(
// //           padding: EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Filter by Category',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 10),
// //               Expanded(
// //                 child: ListView.builder(
// //                   shrinkWrap: true,
// //                   itemCount: categories.length,
// //                   itemBuilder: (context, index) {
// //                     final category = categories[index];
// //                     return RadioListTile<String>(
// //                       title:
// //                           Text(category == "All" ? "All Categories" : category),
// //                       value: category,
// //                       groupValue: categoryFilter,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           categoryFilter = value!;
// //                           if (categoryFilter == "All") {
// //                             categoryFilter = "";
// //                           }
// //                         });
// //                         _filterCrops();
// //                         Navigator.pop(context);
// //                       },
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildProfileScreen() {
// //     return ProfileScreen();
// //   }

// //   Widget _buildshopingscrenn() {
// //     return ShoppingScreen();
// //   }

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         iconTheme: IconThemeData(color: Colors.black), // optional
// //         elevation: 0,
// //       ),
// //       backgroundColor: Colors.white,
// //       drawer: Drawer(
// //         child: Padding(
// //           padding: const EdgeInsets.only(top: 10.0),
// //           child: Column(
// //             children: [
// //               UserAccountsDrawerHeader(
// //                 currentAccountPicture: CircleAvatar(
// //                   backgroundImage:
// //                       imageUrl != null ? NetworkImage(imageUrl!) : null,
// //                   child: imageUrl == null ? const Icon(Icons.person) : null,
// //                 ),
// //                 accountName: Text('${username}'),
// //                 accountEmail: Text('${userId}'),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.home),
// //                 title: const Text('Home'),
// //                 onTap: () => _onItemTapped(0),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.person),
// //                 title: const Text('Profile'),
// //                 onTap: () => _onItemTapped(1),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.shopping_cart),
// //                 title: const Text('Cart'),
// //                 onTap: () => _onItemTapped(2),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.logout),
// //                 title: const Text('Logout'),
// //                 onTap: () {
// //                   LoginController().logout(context);
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.shopping_cart_rounded),
// //                 title: const Text('Ordered'),
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => ConfirmedOrdersScreen()),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.money),
// //                 title: const Text('Transection'),
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) =>
// //                             TransactionScreen(userId: userId!)),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.money),
// //                 title: const Text('History Order'),
// //                 onTap: () {
// //                   Navigator.pushReplacement(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => HistoryOrder()),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       body: IndexedStack(
// //         index: _selectedIndex,
// //         children: [
// //           _buildHomeScreen(),
// //           _buildProfileScreen(),
// //           _buildshopingscrenn(),
// //         ],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: MyColors.primaryColor,
// //         unselectedItemColor: Colors.grey,
// //         showSelectedLabels: false,
// //         showUnselectedLabels: false,
// //         type: BottomNavigationBarType.fixed,
// //         items: <BottomNavigationBarItem>[
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home_outlined),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.favorite_border),
// //             label: 'Wishlist',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Container(
// //               padding: EdgeInsets.all(8.0),
// //               decoration: BoxDecoration(
// //                 color: MyColors.primaryColor,
// //                 borderRadius: BorderRadius.circular(10.0),
// //               ),
// //               child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
// //             ),
// //             label: 'Cart',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.notifications_outlined),
// //             label: 'Notifications',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.person_outline),
// //             label: 'Profile',
// //           ),
// //         ],
// //         onTap: (index) {
// //           setState(() {
// //             _selectedIndex = index;
// //             if (index == 2) {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => ShoppingScreen()),
// //               );
// //             }
// //           });
// //         },
// //       ),
// //     );
// //   }
// // }

// // class CropGridCard extends StatelessWidget {
// //   final Crop crop;

// //   CropGridCard({required this.crop});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => CropDetailScreen(
// //               name: crop.name,
// //               category: crop.category,
// //               imageUrl: crop.imageUrl,
// //               price: crop.price,
// //               quantity: crop.quantity,
// //               farmerId: crop.farmerId,
// //               cropid: crop.cropId,
// //             ),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(15.0),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.2),
// //               spreadRadius: 1,
// //               blurRadius: 3,
// //               offset: Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Expanded(
// //               child: Stack(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius:
// //                         BorderRadius.vertical(top: Radius.circular(15.0)),
// //                     child: Image.network(
// //                       crop.imageUrl,
// //                       width: double.infinity,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (context, error, stackTrace) {
// //                         return Container(
// //                           color: Colors.grey[200],
// //                           child: Center(child: Icon(Icons.image_not_supported)),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   Positioned(
// //                     top: 8.0,
// //                     right: 8.0,
// //                     child: Container(
// //                       padding:
// //                           EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
// //                       decoration: BoxDecoration(
// //                         color: MyColors.primaryColor,
// //                         borderRadius: BorderRadius.circular(8.0),
// //                       ),
// //                       child: Text(
// //                         '\$${crop.price}/kg',
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     crop.name,
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   SizedBox(height: 4),
// //                   Text(
// //                     'Category: ${crop.category}',
// //                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:agriconnect/Controllers/LoginController.dart';
// import 'package:agriconnect/Controllers/buyerController.dart';
// import 'package:agriconnect/Models/CropModel.dart';
// import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
// import 'package:agriconnect/Views/Buyer/complete_order.dart';
// import 'package:agriconnect/Views/Buyer/history_order.dart';
// import 'package:agriconnect/Views/Common/profile_screen.dart';
// import 'package:agriconnect/Views/Order/detailed.dart';
// import 'package:agriconnect/Views/Order/shoppingCard.dart';
// import 'package:agriconnect/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class BuyerMain extends StatefulWidget {
//   BuyerMain({Key? key}) : super(key: key);

//   @override
//   _BuyerMainState createState() => _BuyerMainState();
// }

// class _BuyerMainState extends State<BuyerMain> {
//   final BuyerController _controller = BuyerController();
//   List<Crop> crops = [];
//   List<Crop> filteredCrops = [];
//   bool isLoading = true;
//   String? imageUrl;
//   String? username = "Guest"; // Default username
//   int? userId;
//   String? roleName;
//   String categoryFilter = "";
//   String nameFilter = "";
//   int _selectedIndex = 0;
//   List<String> categories = [];
//   final TextEditingController _searchController = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     fetchCrops();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       username = prefs.getString('username') ?? "Guest";
//       imageUrl = prefs.getString('imageUrl');
//       userId = prefs.getInt('userId');
//       roleName = prefs.getString('roleName');
//     });
//   }

//   Future<void> fetchCrops() async {
//     final url = Uri.parse('http://152.67.10.128:5280/api/Order/Available-crop');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final List<dynamic> values = data['\$values'];
//         setState(() {
//           crops = values.map((crop) => Crop.fromJson(crop)).toList();
//           filteredCrops = crops;
//           isLoading = false;
//           categories = crops.map((crop) => crop.category).toSet().toList();
//           categories.insert(0, "All"); // Add "All" option at the beginning
//         });
//       } else {
//         throw Exception('Failed to load crops');
//       }
//     } catch (e) {
//       print('Error fetching crops: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _filterCrops() {
//     setState(() {
//       filteredCrops = crops.where((crop) {
//         final categoryMatch = categoryFilter.isEmpty ||
//             crop.category.toLowerCase().contains(categoryFilter.toLowerCase());
//         final nameMatch = nameFilter.isEmpty ||
//             crop.name.toLowerCase().contains(nameFilter.toLowerCase());
//         return categoryMatch && nameMatch;
//       }).toList();
//     });
//   }

//   Widget _buildHomeScreen() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/bg8.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Good morning',
//                             style: TextStyle(
//                                 color: Colors.grey[600], fontSize: 14)),
//                         Text(username!,
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     if (imageUrl != null)
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(imageUrl!),
//                         radius: 24,
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _searchController,
//                           decoration: InputDecoration(
//                             hintText: 'Search for crops',
//                             prefixIcon:
//                                 Icon(Icons.search, color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: BorderSide.none,
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey[200],
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               nameFilter = value;
//                             });
//                             _filterCrops();
//                           },
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       InkWell(
//                         onTap: _showCategoryFilterBottomSheet,
//                         child: Container(
//                           padding: EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: MyColors.primaryColor,
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Icon(Icons.filter_list, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Available Crops',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     // You might want to add a "View All" button here if you have many crops
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : GridView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         // To disable scrolling of GridView within SingleChildScrollView
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: 0.75,
//                           crossAxisSpacing: 16.0,
//                           mainAxisSpacing: 16.0,
//                         ),
//                         itemCount: filteredCrops.length,
//                         itemBuilder: (context, index) {
//                           return CropGridCard(crop: filteredCrops[index]);
//                         },
//                       ),
//                 // You can add more sections here like "Featured Crops" or "Categories"
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCategoryFilterBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Filter by Category',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categories[index];
//                     return RadioListTile<String>(
//                       title:
//                           Text(category == "All" ? "All Categories" : category),
//                       value: category,
//                       groupValue: categoryFilter,
//                       onChanged: (value) {
//                         setState(() {
//                           categoryFilter = value!;
//                           if (categoryFilter == "All") {
//                             categoryFilter = "";
//                           }
//                         });
//                         _filterCrops();
//                         Navigator.pop(context);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfileScreen() {
//     return ProfileScreen();
//   }

//   Widget _buildshopingscrenn() {
//     return ShoppingScreen();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: MyColors.primaryColor),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       drawer: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: Column(
//             children: [
//               UserAccountsDrawerHeader(
//                 currentAccountPicture: CircleAvatar(
//                   backgroundImage:
//                       imageUrl != null ? NetworkImage(imageUrl!) : null,
//                   child: imageUrl == null ? const Icon(Icons.person) : null,
//                 ),
//                 accountName: Text('${username}'),
//                 accountEmail: Text('${userId}'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.home),
//                 title: const Text('Home'),
//                 onTap: () => _onItemTapped(0),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.person),
//                 title: const Text('Profile'),
//                 onTap: () => _onItemTapped(1),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.shopping_cart),
//                 title: const Text('Cart'),
//                 onTap: () => _onItemTapped(2),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.logout),
//                 title: const Text('Logout'),
//                 onTap: () {
//                   LoginController().logout(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.shopping_cart_rounded),
//                 title: const Text('Ordered'),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConfirmedOrdersScreen()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.money),
//                 title: const Text('Transection'),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             TransactionScreen(userId: userId!)),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.money),
//                 title: const Text('History Order'),
//                 onTap: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => HistoryOrder()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           _buildHomeScreen(),
//           _buildshopingscrenn(),
//           _buildProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: MyColors.primaryColor,
//         unselectedItemColor: Colors.grey,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.favorite_border),
//           //   label: 'Wishlist',
//           // ),
//           BottomNavigationBarItem(
//             icon: Container(
//               padding: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColor,
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
//             ),
//             label: 'Cart',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.notifications_outlined),
//           //   label: 'Notifications',
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             // if (index == 2) {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => ShoppingScreen()),
//             //   );
//             // }
//           });
//         },
//       ),
//     );
//   }
// }

// class CropGridCard extends StatelessWidget {
//   final Crop crop;

//   CropGridCard({required this.crop});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CropDetailScreen(
//               name: crop.name,
//               category: crop.category,
//               imageUrl: crop.imageUrl,
//               price: crop.price,
//               quantity: crop.quantity,
//               farmerId: crop.farmerId,
//               cropid: crop.cropId,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(15.0)),
//                     child: Image.network(
//                       crop.imageUrl,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey[200],
//                           child: Center(child: Icon(Icons.image_not_supported)),
//                         );
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     top: 8.0,
//                     right: 8.0,
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                       decoration: BoxDecoration(
//                         color: MyColors.primaryColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Text(
//                         '\$${crop.price}/kg',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     crop.name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Category: ${crop.category}',
//                     style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Controllers/LoginController.dart';
import 'package:agriconnect/Controllers/buyerController.dart';
import 'package:agriconnect/Models/CropModel.dart';
import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
import 'package:agriconnect/Views/Buyer/complete_order.dart';
import 'package:agriconnect/Views/Buyer/history_order.dart';
import 'package:agriconnect/Views/Common/profile_screen.dart';
import 'package:agriconnect/Views/Order/detailed.dart';
import 'package:agriconnect/Views/Order/shoppingCard.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerMain extends StatefulWidget {
  BuyerMain({Key? key}) : super(key: key);

  @override
  _BuyerMainState createState() => _BuyerMainState();
}

class _BuyerMainState extends State<BuyerMain> with TickerProviderStateMixin {
  final BuyerController _controller = BuyerController();
  List<Crop> crops = [];
  List<Crop> filteredCrops = [];
  bool isLoading = true;
  String? imageUrl;
  String? username = "Guest"; // Default username
  int? userId;
  String? roleName;
  String categoryFilter = "";
  String nameFilter = "";
  MotionTabBarController? _motionTabBarController;
  List<String> categories = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchCrops();
    _loadUserData();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3, // Number of tabs
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "Guest";
      imageUrl = prefs.getString('imageUrl');
      userId = prefs.getInt('userId');
      roleName = prefs.getString('roleName');
    });
  }

  Future<void> fetchCrops() async {
    final url = Uri.parse('http://152.67.10.128:5280/api/Order/Available-crop');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> values = data['\$values'];
        setState(() {
          crops = values.map((crop) => Crop.fromJson(crop)).toList();
          filteredCrops = crops;
          isLoading = false;
          categories = crops.map((crop) => crop.category).toSet().toList();
          categories.insert(0, "All"); // Add "All" option at the beginning
        });
      } else {
        throw Exception('Failed to load crops');
      }
    } catch (e) {
      print('Error fetching crops: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterCrops() {
    setState(() {
      filteredCrops = crops.where((crop) {
        final categoryMatch = categoryFilter.isEmpty ||
            crop.category.toLowerCase().contains(categoryFilter.toLowerCase());
        final nameMatch = nameFilter.isEmpty ||
            crop.name.toLowerCase().contains(nameFilter.toLowerCase());
        return categoryMatch && nameMatch;
      }).toList();
    });
  }

  Widget _buildHomeScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg8.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good morning',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14)),
                        Text(username!,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    if (imageUrl != null)
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl!),
                        radius: 24,
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for crops',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onChanged: (value) {
                            setState(() {
                              nameFilter = value;
                            });
                            _filterCrops();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: _showCategoryFilterBottomSheet,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(Icons.filter_list, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Available Crops',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    // You might want to add a "View All" button here if you have many crops
                  ],
                ),
                SizedBox(height: 16),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // To disable scrolling of GridView within SingleChildScrollView
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: filteredCrops.length,
                        itemBuilder: (context, index) {
                          return CropGridCard(crop: filteredCrops[index]);
                        },
                      ),
                // You can add more sections here like "Featured Crops" or "Categories"
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCategoryFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Category',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return RadioListTile<String>(
                      title:
                          Text(category == "All" ? "All Categories" : category),
                      value: category,
                      groupValue: categoryFilter,
                      onChanged: (value) {
                        setState(() {
                          categoryFilter = value!;
                          if (categoryFilter == "All") {
                            categoryFilter = "";
                          }
                        });
                        _filterCrops();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileScreen() {
    return ProfileScreen();
  }

  Widget _buildShoppingScreen() {
    return ShoppingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: MyColors.primaryColor),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          // Wrap the Column with a Container for background image and color
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg8.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    // Style the header background
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
                "${username}.@gmailcom" ?? "N/A",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.backgroundScaffoldColor,
                ),
              ),
                ),
                ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                "Home",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
                  onTap: () => _motionTabBarController!.index = 0,
                ),
                 ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Profile',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
                  onTap: () => _motionTabBarController!.index = 1,
                ),
                ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(
                "Cart",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
                  onTap: () => _motionTabBarController!.index = 2,
                ),
                // ListTile(
                //   leading: const Icon(Icons.logout),
                //   title: const Text('Logout'),
                //   onTap: () {
                //     LoginController().logout(context);
                //   },
                // ),
                ListTile(
              title: Text(
                "Ordered",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
              leading: const Icon(Icons.shopping_cart_rounded),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmedOrdersScreen()),
                    );
                  },
                ),
                ListTile(
              leading: const Icon(Icons.money),
              title: Text(
                "Transaction",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TransactionScreen(userId: userId!)),
                    );
                  },
                ),
                ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                "History Order",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyColors.black,
                ),
              ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryOrder()),
                    );
                  },
                ),
                 Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, top: 24),
                  child: CustomButton(
                    radius: CustomSize().customWidth(context) / 10,
                    height: CustomSize().customHeight(context) / 15,
                    width: CustomSize().customWidth(context) / 2,
                    title: "Logout",
                    loading: false,
                    color: MyColors.primaryColor,
                    onTap: () {
                      LoginController().logout(context);
                    },
                  ),
                ),
              ],
            ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          _buildHomeScreen(),
          _buildProfileScreen(),
          _buildShoppingScreen(),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Home", "Profile", "Cart"],
        icons: const [Icons.home, Icons.person, Icons.shopping_cart],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconSize: 28.0,
        tabIconSelectedSize: 32.0,
        tabSelectedColor: MyColors.primaryColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}

class CropGridCard extends StatelessWidget {
  final Crop crop;

  CropGridCard({required this.crop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropDetailScreen(
              name: crop.name,
              category: crop.category,
              imageUrl: crop.imageUrl,
              price: crop.price,
              quantity: crop.quantity,
              farmerId: crop.farmerId,
              cropid: crop.cropId,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: Image.network(
                      crop.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(child: Icon(Icons.image_not_supported)),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '\$${crop.price}/kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Category: ${crop.category}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
