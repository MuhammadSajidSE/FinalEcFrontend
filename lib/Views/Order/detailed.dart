// import 'package:agriconnect/Controllers/orderController.dart';
// import 'package:agriconnect/Views/Order/shoppingCard.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CropDetailScreen extends StatefulWidget {
//   final String name;
//   final String category;
//   final String imageUrl;
//   final int price;
//   final int quantity;
//   final int farmerId;
//   final int cropid;

//   CropDetailScreen({
//     required this.name,
//     required this.category,
//     required this.imageUrl,
//     required this.price,
//     required this.quantity,
//     required this.farmerId,
//     required this.cropid,
//   });

//   @override
//   _CropDetailScreenState createState() => _CropDetailScreenState();
// }

// class _CropDetailScreenState extends State<CropDetailScreen> {
//   final TextEditingController _quantityController = TextEditingController();
//   final OrderController _orderController = OrderController();

//   void addtocard() async {
//     int enteredQuantity = int.tryParse(_quantityController.text) ?? 0;
//     if (enteredQuantity > 0) {
//       bool success =
//           await _orderController.createOrder(widget.cropid, enteredQuantity);
//       if (success) {
//         _showPopup("Added to cart successfully!", true);
//         Future.delayed(Duration(seconds: 2), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ShoppingScreen()),
//           );
//         });
//       } else {
//         _showPopup("Failed to add to cart. Try again!", false);
//       }
//     } else {
//       _showPopup("Please enter a valid quantity.", false);
//     }
//   }

//   // Function to show popup
//   void _showPopup(String message, bool isSuccess) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(
//               isSuccess ? Icons.check_circle : Icons.error,
//               color: isSuccess ? Colors.green : Colors.red,
//             ),
//             SizedBox(width: 10),
//             Text(isSuccess ? "Success" : "Error"),
//           ],
//         ),
//         content: Text(message, style: TextStyle(fontSize: 16)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("OK", style: TextStyle(color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       appBar: AppBar(
//         title: Text(widget.name, style: GoogleFonts.poppins(fontSize: 20)),
//         backgroundColor: Colors.green[700],
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Crop Image
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(widget.imageUrl,
//                     height: 250, fit: BoxFit.cover),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Crop Details
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.name,
//                         style: GoogleFonts.poppins(
//                             fontSize: 22, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 8),
//                     Text('Category: ${widget.category}',
//                         style: GoogleFonts.poppins(fontSize: 18)),
//                     Text('Price: Rs.${widget.price} per kg',
//                         style: GoogleFonts.poppins(
//                             fontSize: 18, color: Colors.green[800])),
//                     Text('Quantity Available: ${widget.quantity} kg',
//                         style: GoogleFonts.poppins(
//                             fontSize: 18, color: Colors.orange[700])),
//                     Text('Farmer ID: ${widget.farmerId}',
//                         style: GoogleFonts.poppins(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Quantity Input
//             TextField(
//               controller: _quantityController,
//               keyboardType: TextInputType.number,
//               style: GoogleFonts.poppins(fontSize: 18),
//               decoration: InputDecoration(
//                 labelText: "Enter Quantity",
//                 labelStyle: GoogleFonts.poppins(color: Colors.green[800]),
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 prefixIcon: Icon(Icons.shopping_cart, color: Colors.green),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             SizedBox(height: 20),

//             // Add to Cart Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   backgroundColor: Colors.green[700],
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 onPressed: () => addtocard(),
//                 child: Text("Add to Cart",
//                     style:
//                         GoogleFonts.poppins(fontRSize: 18, color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:agriconnect/Controllers/orderController.dart';
import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
import 'package:agriconnect/Views/Order/shoppingCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CropDetailScreen extends StatefulWidget {
  final String name;
  final String category;
  final String imageUrl;
  final int price;
  final int quantity;
  final int farmerId;
  final int cropid;

  CropDetailScreen({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.farmerId,
    required this.cropid,
  });

  @override
  _CropDetailScreenState createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
  int selectedQuantity = 1;
  final OrderController _orderController = OrderController();

  void addtocart() async {
    if (selectedQuantity > 0) {
      bool success =
          await _orderController.createOrder(widget.cropid, selectedQuantity);
      if (success) {
        _showPopup("Added to cart successfully!", true);
        Get.find<ShoppingController>().fetchCartItems();

        Future.delayed(Duration(seconds: 2), () {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => ShoppingScreen()),
          // );
        Get.off(BuyerMain());
        });
      } else {
        _showPopup("Failed to add to cart. Try again!", false);
      }
    } else {
      _showPopup("Please select a valid quantity.", false);
    }
  }

  void _showPopup(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            SizedBox(width: 10),
            Text(isSuccess ? "Success" : "Error"),
          ],
        ),
        content: Text(message, style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Column(
        children: [
          // Green Header
          Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      widget.imageUrl,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Rs. ${widget.price}",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.green[700])),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(" 4.5", style: GoogleFonts.poppins(fontSize: 16)),
                      SizedBox(width: 12),
                      Icon(Icons.timer, color: Colors.grey, size: 20),
                      Text(" 10min", style: GoogleFonts.poppins(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Available: ${widget.quantity} kg",
                          style: GoogleFonts.poppins(fontSize: 16)),
                      Spacer(),
                      Text("Farmer ID: ${widget.farmerId}",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    children: [
                      Text("Quantity",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon:
                                  Icon(Icons.remove, color: Colors.green[800]),
                              onPressed: () {
                                setState(() {
                                  if (selectedQuantity > 1) selectedQuantity--;
                                });
                              },
                            ),
                            Text('$selectedQuantity',
                                style: GoogleFonts.poppins(fontSize: 18)),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green[800]),
                              onPressed: () {
                                setState(() {
                                  selectedQuantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Description
                  Text("About crop",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu sem in odio condimentum volutpat...",
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => addtocart(),
                      child: Text("Add to cart",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
