// import 'package:agriconnect/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class FarmerCropDetailScreen extends StatefulWidget {
//   final int cropId;

//   const FarmerCropDetailScreen({Key? key, required this.cropId})
//       : super(key: key);

//   @override
//   _FarmerCropDetailScreenState createState() => _FarmerCropDetailScreenState();
// }

// class _FarmerCropDetailScreenState extends State<FarmerCropDetailScreen> {
//   bool _isEditing = false;
//   bool _isLoading = true;
//   Map<String, dynamic>? _cropData;
//   late TextEditingController _priceController;
//   late TextEditingController _quantityController;

//   @override
//   void initState() {
//     super.initState();
//     _priceController = TextEditingController();
//     _quantityController = TextEditingController();
//     _fetchCropDetails();
//   }

//   Future<void> _fetchCropDetails() async {
//     final url =
//         Uri.parse("http://152.67.10.128:5280/api/crops/${widget.cropId}");

//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         setState(() {
//           _cropData = data;
//           _priceController.text = data["price"].toString();
//           _quantityController.text = data["quantity"].toString();
//           _isLoading = false;
//         });
//       } else {
//         _showSnackbar(
//             "Failed to load crop details. Status: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showSnackbar("Error: $e");
//     }
//   }

//   Future<void> _updateCropDetails() async {
//     if (_cropData == null) return;

//     final url =
//         Uri.parse("http://152.67.10.128:5280/api/crops/Edit/${widget.cropId}");

//     final Map<String, dynamic> updatedData = {
//       "name": _cropData!["name"],
//       "category": _cropData!["category"],
//       "price": int.tryParse(_priceController.text) ?? _cropData!["price"],
//       "quantity":
//           int.tryParse(_quantityController.text) ?? _cropData!["quantity"],
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(updatedData),
//       );

//       if (response.statusCode == 200) {
//         _showSnackbar("Crop details updated successfully!");
//         setState(() {
//           _isEditing = false;
//         });
//         _fetchCropDetails(); // Fetch updated data
//       } else {
//         _showSnackbar(
//             "Failed to update crop details. Status: ${response.statusCode}");
//       }
//     } catch (e) {
//       _showSnackbar("Error: $e");
//     }
//   }

//   void _showSnackbar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_cropData?["name"] ?? "Loading..."),
//         actions: [
//           if (!_isLoading)
//             IconButton(
//               icon: Icon(_isEditing ? Icons.save : Icons.edit),
//               onPressed: () {
//                 if (_isEditing) {
//                   _updateCropDetails();
//                 } else {
//                   setState(() {
//                     _isEditing = true;
//                   });
//                 }
//               },
//             ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                    height: 300,
//                       width: double.infinity,
//                       color: MyColors.primaryColor,
//                       child: Column(
//                         children: [
//                         Row(
//                           children: [
//                                  Text(_cropData?["name"] ?? "Loading..."),
//                           if (!_isLoading)
//             IconButton(
//               icon: Icon(_isEditing ? Icons.save : Icons.edit),
//               onPressed: () {
//                 if (_isEditing) {
//                   _updateCropDetails();
//                 } else {
//                   setState(() {
//                     _isEditing = true;
//                   });
//                 }
//               },
//             ),
//                           ],
//                         ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             child: ClipRRect(
//                                                 borderRadius: BorderRadius.circular(15),
//                                                 child: Image.network(
//                             _cropData!["imageUrl"],
//                             width: 250,
//                             height: 250,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return const Icon(Icons.image, size: 100);
//                             },
//                                                 ),
//                                               ),
//                           ),
//                         ],
//                       ) ,
//                   ),
                 
                 
//                    SizedBox(height: 20),
//                   // Crop Details
//                    Text(
//                      _cropData!["name"],
//                 style: GoogleFonts.inter(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                   // Text(
//                   //   _cropData!["name"],
//                   //   style: const TextStyle(
//                   //       fontSize: 24, fontWeight: FontWeight.bold),
//                   // ),
//                   const SizedBox(height: 10),
//                    Text(
//                 'Category: ${_cropData!["category"]}',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                   // Text(
//                   //   "Category: ${_cropData!["category"]}",
//                   //   style: const TextStyle(fontSize: 18),
//                   // ),
//                   const SizedBox(height: 10),

//                   // Editable Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                        Text(
//                 'Price: Rs. ',
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                       // const Text(
//                       //   "Price: Rs. ",
//                       //   style: TextStyle(
//                       //       fontSize: 18, fontWeight: FontWeight.bold),
//                       // ),
//                       _isEditing
//                           ? SizedBox(
//                               width: 80,
//                               child: TextField(
//                                 controller: _priceController,
//                                 keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             )
//                           // : Text(
//                           //     "Rs. ${_cropData!["price"]}",
//                           //     style: const TextStyle(
//                           //         fontSize: 18, fontWeight: FontWeight.bold),
//                           //   ),

//                             :Text(
//                   "Rs. ${_cropData!["price"]}",
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   // Editable Quantity
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [

//                       Text(
//                   "Quantity: ",
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                       // const Text(
//                       //   "Quantity: ",
//                       //   style: TextStyle(fontSize: 18),
//                       // ),
//                       _isEditing
//                           ? SizedBox(
//                               width: 80,
//                               child: TextField(
//                                 controller: _quantityController,
//                                 keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             )
//                           // : Text(
//                           //     "${_cropData!["quantity"]}",
//                           //     style: const TextStyle(fontSize: 18),
//                           //   ),

//                               :Text(
//                    "${_cropData!["quantity"]}",
//                 style: GoogleFonts.inter(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: MyColors.profileColor,
//                 ),
//               ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _priceController.dispose();
//     _quantityController.dispose();
//     super.dispose();
//   }
// }


import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Component/inputField.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerCropDetailScreen extends StatefulWidget {
  final int cropId;

  const FarmerCropDetailScreen({Key? key, required this.cropId})
      : super(key: key);

  @override
  _FarmerCropDetailScreenState createState() => _FarmerCropDetailScreenState();
}

class _FarmerCropDetailScreenState extends State<FarmerCropDetailScreen> {
  bool _isEditing = false;
  bool _isLoading = true;
  Map<String, dynamic>? _cropData;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _fetchCropDetails();
  }

  Future<void> _fetchCropDetails() async {
    final url =
        Uri.parse("http://152.67.10.128:5280/api/crops/${widget.cropId}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _cropData = data;
          _priceController.text = data["price"].toString();
          _quantityController.text = data["quantity"].toString();
          _isLoading = false;
        });
      } else {
        _showSnackbar(
            "Failed to load crop details. Status: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackbar("Error: $e");
    }
  }

  Future<void> _updateCropDetails() async {
    if (_cropData == null) return;

    final url =
        Uri.parse("http://152.67.10.128:5280/api/crops/Edit/${widget.cropId}");

    final Map<String, dynamic> updatedData = {
      "name": _cropData!["name"],
      "category": _cropData!["category"],
      "price": int.tryParse(_priceController.text) ?? _cropData!["price"],
      "quantity":
          int.tryParse(_quantityController.text) ?? _cropData!["quantity"],
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        _showSnackbar("Crop details updated successfully!");
        setState(() {
          _isEditing = false;
        });
        _fetchCropDetails(); // Fetch updated data
      } else {
        _showSnackbar(
            "Failed to update crop details. Status: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackbar("Error: $e");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_cropData?["name"] ?? "Loading..."),
      //   actions: [
      //     if (!_isLoading)
      //       IconButton(
      //         icon: Icon(_isEditing ? Icons.save : Icons.edit),
      //         onPressed: () {
      //           if (_isEditing) {
      //             _updateCropDetails();
      //           } else {
      //             setState(() {
      //               _isEditing = true;
      //             });
      //           }
      //         },
      //       ),
      //   ],
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                Stack(
  children: [
   
Stack(
  children: [
    // Top container with background color and centered title
    Container(
      height: 200,
      width: double.infinity,
      color: MyColors.primaryColor,
      child:  Stack(
        children: [
          // Back Icon on the left
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FarmerMain()));
              },
              child: Icon(
                Icons.arrow_back,
                color: MyColors.backgroundScaffoldColor,
              ),
            ),
          ),

          // Centered title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                _cropData!["name"],
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: MyColors.backgroundScaffoldColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    // Avatar image with edit icon overlay
    Container(
      margin: EdgeInsets.only(top: 50),
      child: Center(
        child: Stack(
          children: [
            // Avatar
          Stack(
  children: [
 Container(
  margin: const EdgeInsets.only(top: 25),
  width: 250,
  height: 250,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12), // small rounded corners
    child: Image.network(
      _cropData!["imageUrl"],
      width: 250,
      height: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image, size: 100);
      },
    ),
  ),
),

   
    
  ],
)

            // Edit icon at bottom right of avatar
         
          ],
        ),
      ),
    ),
  ],
)



    // Profile Avatar
    
  ],
),
                  const SizedBox(height: 15),
                    // Text(
                    //   username,
                    //   style: GoogleFonts.inter(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w700,
                    //     color: MyColors.primaryColor
                    //   ),
                    // ),
                    Text(
                      _cropData!["name"], 
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 26,
                      height:  0.9,
                      // fontWeight: FontWeight.bold,
                      color: MyColors.profileColor,
                      // color: MyColors.secondaryColor,
                    ),
                  ),
                   Text(
                         "Category: ${_cropData!["category"]}",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyColors.profileColor
                      ),
                    ),

                                          _isEditing
                          ? SizedBox(
                              width: 80,
                              child: TextField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                            :Text(
                  "Price: ${_cropData!["price"]} PKR",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: MyColors.profileColor,
                ),
              ),
                    //  Text(
                    //  "Price: Rs. ${_cropData!["price"]}",
                    //                        style: GoogleFonts.inter(
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.bold,
                    //   color: MyColors.profileColor
                    //                        ),
                    //                      ),
                                         SizedBox(width: 10),
                                         // Icon(Icons.location_on, color: MyColors.profileColor),


                                           _isEditing
                          ? SizedBox(
                              width: 80,
                              child: TextField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                        

                              :Text(
                   "Quantity: ${_cropData!["quantity"]}",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: MyColors.profileColor,
                ),
              ),
                  //      Text(
                  //    "Quanity: ${_cropData!["quantity"]}",
                  //                          style: GoogleFonts.inter(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //     color: MyColors.profileColor
                  //                          ),
                  //                        ),
                  // // Text(
                  //   roleName,
                  //   style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  // ),
                  //  Text(
                  //     roleName,
                  //     style: GoogleFonts.inter(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: MyColors.profileColor
                  //     ),
                  //   ),
               
                 
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Chip(
                      //   label: Text(
                      //     isActive ? "Active" : "Deactivated",
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      //   backgroundColor: isActive ? Colors.green : Colors.red,
                      // ),
          
                    ],
                  ),
                   Row(
                     children: [
                       Expanded(
                         child: Container(
                            margin: EdgeInsets.only(top: 12,left: 12),
                                        
                           child: CustomButton(
                              radius: CustomSize().customWidth(context) / 28,
                              height: CustomSize().customHeight(context) / 12,
                              width: CustomSize().customWidth(context) ,
                              title: "Edit Crops",
                              
                              loading: false,
                              color: MyColors.primaryColor,
                              onTap: () {
                           showDialog(
                             context: context,
                             builder: (context) {
                               return AlertDialog(
                                 title:    Text(
                            "Edit Crop Details",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black
                            ),
                          ),
                                
                                 content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     MyTextField(
                                       _priceController,
                                       hintText: "Enter price",
                                       prefixIcon: Icons.attach_money,
                                       keyboardType: TextInputType.number,
                                     ),
                                     const SizedBox(height: 10),
                                     MyTextField(
                                       _quantityController,
                                       hintText: "Enter quantity",
                                       prefixIcon: Icons.inventory_2,
                                       keyboardType: TextInputType.number,
                                     ),
                                      const SizedBox(height: 20),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         // Cancel Button
                                         Expanded(
                                           child: Container(
                          margin: const EdgeInsets.only(top: 12,),
                          child: CustomButton(
                            radius: CustomSize().customWidth(context) / 28,
                            height: CustomSize().customHeight(context) / 18,
                            width: CustomSize().customWidth(context) ,
                            title: "Cancel",
                            loading: false,
                            color:MyColors.profileColor,
                            onTap: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                          ),
                                           ),
                                         ),
                                          const SizedBox(width: 10),
                                         // Save Button
                                         Expanded(
                                           child: Container(
                          margin: const EdgeInsets.only(top: 12,),
                          child: CustomButton(
                            radius: CustomSize().customWidth(context) / 28,
                            height: CustomSize().customHeight(context) / 18,
                            width: CustomSize().customWidth(context) ,
                            title: "Save",
                            loading: false,
                            color: MyColors.primaryColor,
                            onTap: () {
                              
                            _updateCropDetails().then((_) {
                                Navigator.of(context).pop();
                              });
                                           
                            },
                          ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                                
                               );
                             },
                           );
                         },
                         
                         
                            ),
                         ),
                       ),

                        Expanded(child: 
                       Container(
                          margin: EdgeInsets.only(top: 12,left: 10,right: 12),
               
                         child: CustomButton(
                            radius: CustomSize().customWidth(context) / 28,
                            height: CustomSize().customHeight(context) / 12,
                            width: CustomSize().customWidth(context) ,
                            title: "Delete Crops",
                            
                            loading: false,
                            color:  Colors.red,
                            onTap: () {
                            
                            },
                          ),
                       ),),
                     ],
                   ),
                  const SizedBox(height: 20),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   elevation: 3,
                  //   child: ListTile(
                  //     leading: const Icon(Icons.email, color: Colors.blue),
                  //     title: Text(email),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   elevation: 3,
                  //   child: ListTile(
                  //     leading: const Icon(Icons.phone, color: Colors.green),
                  //     title: Text(phoneNumber),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   elevation: 3,
                  //   child: ListTile(
                  //     leading: const Icon(Icons.location_on, color: Colors.red),
                  //     title: Text(address),
                  //   ),
                  // ),
                ],
              ),
            )
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}



