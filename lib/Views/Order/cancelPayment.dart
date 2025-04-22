// import 'package:agriconnect/constants/colors.dart';
// import 'package:flutter/material.dart';

// class OrderConfirmationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image (Replace with your asset)
//           Image.asset(
//             'assets/bg8.png', // Replace with your image path
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Center(
//             child: SingleChildScrollView( // To handle potential overflow on smaller screens
//               padding: const EdgeInsets.all(32.0),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       // Relevant Visual (Replace with your asset or widget)
//                       Image.asset(
//                         'assets/success.png', // Replace with your visual
//                         height: 120,
//                       ),
//                       const SizedBox(height: 24),
//                       Text(
//                         'Congratulations!',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).primaryColor, // Use your theme color
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Your order has been placed successfully.',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 32),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Navigate to the next screen (e.g., order tracking)
//                             Navigator.pop(context); // Example: Go back
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: MyColors.primaryColor, // Use your accent color
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child: Text(
//                             'Track Your Order', // Customize the button text
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderCancellationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/bg8.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Oops Payment Cancelled 😪',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: 300, // Adjust width as needed
                    height: 450, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                        image: AssetImage('assets/cancel.png'), // Your success image
                        fit: BoxFit.cover,
                        opacity: 0.7, // Adjust opacity
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: SizedBox(
                    width: 200, // Match button width to card
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Get.off(BuyerMain());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Continue Buying 🙂',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}