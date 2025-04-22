// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:agriconnect/constants/colors.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class API {
//   static const String baseURL = 'sandbox.payfast.co.za';

//   Future<String> payFastPayment({
//     required String amount,
//     required String item_name,
//   }) async {
//     final queryParameters = {
//       'merchant_id': '10038067', // Replace with your actual merchant ID
//       'merchant_key': 'fiempzztddgyx', // Replace with your actual merchant key
//       'amount': amount,
//       'item_name': item_name,
//       'return_url':
//           'yourapp://payment_success', //?orderId=${YOUR_ORDER_ID}&paymentId=${PAYFAST_ID}',
//       'cancel_url': 'yourapp://payment_cancel', //?orderId=${YOUR_ORDER_ID}',
//       'notify_url': 'https://152.67.10.128:5280/api/payfast/itn',
//     };

//     final uri = Uri.https(baseURL, "/eng/process", queryParameters);
//     return uri.toString();
//   }
// }

// class PaymentViewModel {
//   final API api = API();

//   Future<String> startPayment(String amount, String itemName) async {
//     try {
//       final result = await api.payFastPayment(
//         amount: amount,
//         item_name: itemName,
//       );
//       return result;
//     } catch (e) {
//       debugPrint("Error generating payment link: $e");
//       return "https://example.com/error";
//     }
//   }
// }

// class ShoppingController extends GetxController {
//   final _cartItems = <Map<String, dynamic>>[].obs;
//   final _isLoading = true.obs;
//   final _totalAmount = 0.obs;
//   final PaymentViewModel _paymentViewModel =
//       PaymentViewModel(); // Instantiate PaymentViewModel

//   List<Map<String, dynamic>> get cartItems => _cartItems.toList();
//   bool get isLoading => _isLoading.value;
//   int get totalAmount => _totalAmount.value;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCartItems();
//   }

//   Future<void> fetchCartItems() async {
//     _isLoading.value = true;
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       int? buyerId = await prefs.getInt('userId');

//       if (buyerId == null) {
//         _isLoading.value = false;
//         return;
//       }

//       final url =
//           Uri.parse("http://152.67.10.128:5280/api/Order/buyer/$buyerId");
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         List<dynamic> orders = data["\$values"] ?? [];
//         List<Map<String, dynamic>> fetchedCartItems = [];

//         for (var order in orders) {
//           List<dynamic> crops = order["crops"]["\$values"] ?? [];

//           for (var crop in crops) {
//             if (crop["status"] == "Not Confirmed") {
//               fetchedCartItems.add({
//                 "orderId": order["orderId"],
//                 "orderDate": order["orderDate"],
//                 "cropId": crop["cropId"],
//                 "farmerId": crop["farmerId"],
//                 "amount": crop["amount"],
//                 "quantity": crop["quantity"],
//                 "imageUrl": crop["imageUrl"],
//                 "name": crop["name"],
//                 "category": crop["category"],
//                 "status": crop["status"],
//                 "price": crop["price"],
//               });
//             }
//           }
//         }
//         _cartItems.assignAll(fetchedCartItems);
//         print("Fetched Cart Items: $_cartItems"); // Log fetched data
//         calculateTotalAmount();
//       } else {
//         print("Failed to fetch cart items: ${response.body}");
//       }
//     } catch (e) {
//       print("Error fetching cart: $e");
//     } finally {
//       _isLoading.value = false;
//     }
//   }

//   void calculateTotalAmount() {
//     _totalAmount.value = _cartItems.fold(0, (sum, item) {
//       final amount = item['amount'];
//       if (amount != null && amount is num) {
//         return sum + amount.toInt();
//       } else {
//         print(
//             "Warning: amount is null or not a number for an item. Skipping in total calculation.");
//         return sum;
//       }
//     });
//     print("Calculated Total Amount: ${_totalAmount.value}"); // Log total amount
//   }

//   Future<void> deleteItem(int orderId, int cropId, int index) async {
//     final url = Uri.parse("http://152.67.10.128:5280/api/Order/cancel-order/${orderId}");

//     final Map<String, dynamic> body = {
//       "orderId": orderId,
//       "cropId": cropId,
//     };

//     print("Removing item: ${jsonEncode(body)}");

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         print("Item removed successfully!");
//         _cartItems.removeAt(index);
//         calculateTotalAmount();
//         print(
//             "Updated Cart Items after delete: $_cartItems"); // Log after delete
//         print("Total Amount after delete: ${_totalAmount.value}");
//       } else {
//         print(
//             "Failed to remove item. Status: ${response.statusCode}, Response: ${response.body}");
//       }
//     } catch (e) {
//       print("Error removing item: $e");
//     }
//   }

//   Future<void> updateQuantity(
//       int orderId, int cropId, int newQuantity, int index) async {
//     print(
//         "updateQuantity called for index: $index, orderId: $orderId, cropId: $cropId, newQuantity: $newQuantity");
//     final url = Uri.parse("http://152.67.10.128:5280/api/Order/eidt-order");

//     final Map<String, dynamic> orderData = {
//       "orderId": orderId,
//       "cropId": cropId,
//       "quantity": newQuantity,
//     };

//     print("Updating quantity on server: ${jsonEncode(orderData)}");
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(orderData),
//       );

//       if (response.statusCode == 200) {
//         print("Quantity updated on server successfully!");
//         final price = _cartItems[index]['price'];
//         _cartItems[index]['amount'] = (price != null && price is num)
//             ? price * newQuantity
//             : (_cartItems[index]['amount'] / _cartItems[index]['quantity']) *
//                 newQuantity;

//         _cartItems[index]['quantity'] = newQuantity;
//         calculateTotalAmount();
//         print("Updated Cart Items: $_cartItems"); // Log after update
//         print("Total Amount after update: ${_totalAmount.value}");
//         _cartItems.refresh();
//       } else {
//         print(
//             "Failed to update quantity on server. Status: ${response.statusCode}, Response: ${response.body}");
//       }
//     } catch (e) {
//       print("Error updating quantity: $e");
//     }
//   }

//   void confirmOrder(BuildContext context) async {
//     if (_cartItems.isEmpty) {
//       Get.snackbar("Error", "Your cart is empty!");
//       return;
//     }

//     final totalAmountFormatted = totalAmount.toStringAsFixed(2);
//     const itemName =
//         "Shopping Cart Items"; // Or you can build a more detailed name

//     final paymentUrl =
//         await _paymentViewModel.startPayment(totalAmountFormatted, itemName);

//     if (paymentUrl.contains("example.com/error")) {
//       Get.snackbar(
//           "Payment Error", "Could not initiate payment. Please try again.");
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => WebLauncherPage(url: paymentUrl),
//         ),
//       );
//       print("Redirecting to PayFast: $paymentUrl");
//     }
//   }
// }

// class WebLauncherPage extends StatelessWidget {
//   final String url;

//   const WebLauncherPage({Key? key, required this.url}) : super(key: key);

//   Future<void> _launchUrl(BuildContext context) async {
//     final uri = Uri.parse(url);

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not launch PayFast URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Launch URL after the first frame is rendered
//     WidgetsBinding.instance.addPostFrameCallback((_) => _launchUrl(context));

//     return Scaffold(
//       appBar: AppBar(title: const Text("Redirecting to PayFast")),
//       body: const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
// String formatDate(String? rawDate) {
//     if (rawDate == null || rawDate == 'N/A') {
//       return 'N/A';
//     }
//     try {
//       // Parse the raw date string
//       DateTime dateTime = DateTime.parse(rawDate);
//       String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime.toLocal()); // Using toLocal() to convert to local time

//       return formattedDate;
//     } catch (e) {
//       print('Error parsing date: $e');
//       return 'Invalid Date';
//     }
//   }
// class ShoppingScreen extends StatelessWidget {
//   final ShoppingController controller = Get.put(ShoppingController());

//   ShoppingScreen({super.key});

//   Widget _buildItem(BuildContext context, int index) {
//     final item = controller.cartItems[index];
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.8),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     item['imageUrl'],
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(Icons.image_not_supported, size: 40);
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item['name'],
//                       style:  TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 19,
//                         color: MyColors.primaryColor
//                       ),
//                     ),
//                     // Text(
//                     //   'Price : \$${item['price'] != null ? item['price'].toStringAsFixed(2) : (item['amount'] != null && item['quantity'] != null && item['quantity'] > 0 ? (item['amount'] / item['quantity']).toStringAsFixed(2) : 'N/A')}',
//                     //   style: TextStyle(color: Colors.grey[600]),
//                     // ),
//                     Text(
//                       'Category : ${item['category'] != null ? item['category'] : 'N/A'}',
//                     ),
//                     Obx(() => Text(
//                           'Amount : \$${controller.cartItems[index]['amount']?.toStringAsFixed(2) ?? 'N/A'}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )),
//                     Obx(() => Text(
//                           'Status : ${controller.cartItems[index]['status'] ?? 'N/A'}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )),
//                     Obx(() => Text(
//                           'Order Date : ${formatDate(controller.cartItems[index]['orderDate']) ?? 'N/A'}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       print(
//                           "Add button tapped for index: $index, current quantity: ${item['quantity']}, price: ${item['price']}, amount: ${item['amount']}");
//                       controller.updateQuantity(
//                         item['orderId'],
//                         item['cropId'],
//                         (item['quantity'] as int) + 1,
//                         index,
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child:
//                           const Icon(Icons.add, color: Colors.white, size: 16),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Obx(() => Text(
//                         '${controller.cartItems[index]['quantity']}',
//                         style: const TextStyle(fontWeight: FontWeight.bold))),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (item['quantity'] > 1) {
//                         controller.updateQuantity(
//                           item['orderId'],
//                           item['cropId'],
//                           (item['quantity'] as int) - 1,
//                           index,
//                         );
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(Icons.remove,
//                           color: Colors.white, size: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () {
//                   controller.deleteItem(item['orderId'], item['cropId'], index);
//                 },
//                 child: const Icon(Icons.delete_outline, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(
//           "Shopping Cart",
//           style: TextStyle(
//               color: MyColors.primaryColor, fontWeight: FontWeight.w900),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/bg8.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Obx(() {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (controller.cartItems.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.shopping_cart_outlined,
//                       size: 80, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "Your cart is empty!",
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.cartItems.length,
//                     itemBuilder: _buildItem,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Obx(() => Text(
//                               "Total: \$${controller.totalAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                               textAlign: TextAlign.center,
//                             )),
//                         const SizedBox(height: 16),

import 'dart:convert';
import 'package:agriconnect/Views/Order/cancelPayment.dart';
import 'package:agriconnect/Views/Order/confirmPayment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:agriconnect/constants/colors.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class API {
  static const String baseURL = 'sandbox.payfast.co.za';

  Future<String> payFastPayment({
    required String amount,
    required String item_name,
    required Map<String, dynamic> data,
  }) async {
    final queryParameters = {
      'merchant_id': '10038067', // Replace with your actual merchant ID
      'merchant_key': 'fiempzztddgyx', // Replace with your actual merchant key
      'amount': amount,
      "m_payment_id": "1500",
      'item_name': item_name,
      'item_description': jsonEncode(data),
      // 'return_url':'yourapp://payment_success', //?orderId=${YOUR_ORDER_ID}&paymentId=${PAYFAST_ID}',
      // 'cancel_url': 'yourapp://payment_cancel', //?orderId=${YOUR_ORDER_ID}',
      'return_url':
          'https://example.com/', //?orderId=${YOUR_ORDER_ID}&paymentId=${PAYFAST_ID}',
      'cancel_url': 'https://google.com/', //?orderId=${YOUR_ORDER_ID}',
      'notify_url': 'http://152.67.10.128:5280/api/payfast/itn',
    };

    final uri = Uri.https(baseURL, "/eng/process", queryParameters);
    return uri.toString();
  }
}

class PaymentViewModel {
  final API api = API();

  Future<String> startPayment(
      String amount, String itemName, checkoutInfo) async {
    try {
      final result = await api.payFastPayment(
          amount: amount, item_name: itemName, data: checkoutInfo);
      return result;
    } catch (e) {
      debugPrint("Error generating payment link: $e");
      return "https://example.com/error";
    }
  }
}

class ShoppingController extends GetxController {
  final _cartItems = <Map<String, dynamic>>[].obs;
  final _isLoading = true.obs;
  final _totalAmount = 0.obs;
  final PaymentViewModel _paymentViewModel =
      PaymentViewModel(); // Instantiate PaymentViewModel

  // Global variable
  Map<String, dynamic> checkoutInfo = {"buyerId": null, "data": []};

  Future<void> extractCheckoutInfo(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();
    int? buyerId = prefs.getInt('userId');

    checkoutInfo["buyerId"] = buyerId;

    List<dynamic> orders = response["\$values"] ?? [];
    List<Map<String, dynamic>> filteredData = [];

    for (var order in orders) {
      List<dynamic> crops = order["crops"]["\$values"] ?? [];

      for (var crop in crops) {
        if (crop["status"] == "Not Confirmed") {
          filteredData.add({
            "farmerId": crop["farmerId"],
            "amount": crop["amount"],
            "quantity": crop["quantity"],
            "orderId": order["orderId"],
          });
        }
      }
    }

    checkoutInfo["data"] = filteredData;
  }

  List<Map<String, dynamic>> get cartItems => _cartItems.toList();
  bool get isLoading => _isLoading.value;
  int get totalAmount => _totalAmount.value;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    _isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      int? buyerId = await prefs.getInt('userId');

      if (buyerId == null) {
        _isLoading.value = false;
        return;
      }

      final url =
          Uri.parse("http://152.67.10.128:5280/api/Order/buyer/$buyerId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await extractCheckoutInfo(data);
        print(checkoutInfo);

        List<dynamic> orders = data["\$values"] ?? [];
        List<Map<String, dynamic>> fetchedCartItems = [];

        for (var order in orders) {
          List<dynamic> crops = order["crops"]["\$values"] ?? [];

          for (var crop in crops) {
            if (crop["status"] == "Not Confirmed") {
              fetchedCartItems.add({
                "orderId": order["orderId"],
                "orderDate": order["orderDate"],
                "cropId": crop["cropId"],
                "farmerId": crop["farmerId"],
                "amount": crop["amount"],
                "quantity": crop["quantity"],
                "imageUrl": crop["imageUrl"],
                "name": crop["name"],
                "category": crop["category"],
                "status": crop["status"],
                "price": crop["price"],
              });
            }
          }
        }
        _cartItems.assignAll(fetchedCartItems);
        print("Fetched Cart Items: $_cartItems"); // Log fetched data
        calculateTotalAmount();
      } else {
        print("Failed to fetch cart items: ${response.body}");
      }
    } catch (e) {
      print("Error fetching cart: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  void calculateTotalAmount() {
    _totalAmount.value = _cartItems.fold(0, (sum, item) {
      final amount = item['amount'];
      if (amount != null && amount is num) {
        return sum + amount.toInt();
      } else {
        print(
            "Warning: amount is null or not a number for an item. Skipping in total calculation.");
        return sum;
      }
    });
    print("Calculated Total Amount: ${_totalAmount.value}"); // Log total amount
  }

  Future<void> deleteItem(int orderId, int cropId, int index) async {
    final url = Uri.parse(
        "http://152.67.10.128:5280/api/Order/cancel-order/${orderId}");

    final Map<String, dynamic> body = {
      "orderId": orderId,
      "cropId": cropId,
    };

    print("Removing item: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("Item removed successfully!");
        _cartItems.removeAt(index);
        calculateTotalAmount();
        print(
            "Updated Cart Items after delete: $_cartItems"); // Log after delete
        print("Total Amount after delete: ${_totalAmount.value}");
      } else {
        print(
            "Failed to remove item. Status: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  Future<void> updateQuantity(
      int orderId, int cropId, int newQuantity, int index) async {
    print(
        "updateQuantity called for index: $index, orderId: $orderId, cropId: $cropId, newQuantity: $newQuantity");
    final url = Uri.parse("http://152.67.10.128:5280/api/Order/eidt-order");

    final Map<String, dynamic> orderData = {
      "orderId": orderId,
      "cropId": cropId,
      "quantity": newQuantity,
    };

    print("Updating quantity on server: ${jsonEncode(orderData)}");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        print("Quantity updated on server successfully!");
        final price = _cartItems[index]['price'];
        _cartItems[index]['amount'] = (price != null && price is num)
            ? price * newQuantity
            : (_cartItems[index]['amount'] / _cartItems[index]['quantity']) *
                newQuantity;

        _cartItems[index]['quantity'] = newQuantity;
        calculateTotalAmount();
        print("Updated Cart Items: $_cartItems"); // Log after update
        print("Total Amount after update: ${_totalAmount.value}");
        _cartItems.refresh();
      } else {
        print(
            "Failed to update quantity on server. Status: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  void confirmOrder(BuildContext context) async {
    if (_cartItems.isEmpty) {
      Get.snackbar("Error", "Your cart is empty!");
      return;
    }

    final totalAmountFormatted = totalAmount.toStringAsFixed(2);
    const itemName =
        "Shopping Cart Items"; // Or you can build a more detailed name

    final paymentUrl = await _paymentViewModel.startPayment(
        totalAmountFormatted, itemName, checkoutInfo);

    if (paymentUrl.contains("example.com/error")) {
      Get.snackbar(
          "Payment Error", "Could not initiate payment. Please try again.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebLauncherPage(url: paymentUrl),
        ),
      );
      print("Redirecting to PayFast: $paymentUrl");
    }
  }
}

// class WebLauncherPage extends StatelessWidget {
//   final String url;

//   const WebLauncherPage({Key? key, required this.url}) : super(key: key);

//   Future<void> _launchUrl(BuildContext context) async {
//     final uri = Uri.parse(url);

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not launch PayFast URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Launch URL after the first frame is rendered
//     WidgetsBinding.instance.addPostFrameCallback((_) => _launchUrl(context));

//     return Scaffold(
//       appBar: AppBar(title: const Text("Redirecting to PayFast")),
//       body: const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

class WebLauncherPage extends StatefulWidget {
  final String url;

  const WebLauncherPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebLauncherPage> createState() => _WebLauncherPageState();
}

class _WebLauncherPageState extends State<WebLauncherPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("example.com")) {
              Navigator.pop(context);
              Get.off(OrderConfirmationScreen());
              return NavigationDecision.prevent;
            }
            else if(request.url.contains("google.com")){
              Navigator.pop(context);
              Get.off(OrderCancellationScreen());
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PayFast Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}

String formatDate(String? rawDate) {
  if (rawDate == null || rawDate == 'N/A') {
    return 'N/A';
  }
  try {
    // Parse the raw date string
    DateTime dateTime = DateTime.parse(rawDate);
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm')
        .format(dateTime.toLocal()); // Using toLocal() to convert to local time

    return formattedDate;
  } catch (e) {
    print('Error parsing date: $e');
    return 'Invalid Date';
  }
}

class ShoppingScreen extends StatelessWidget {
  final ShoppingController controller = Get.put(ShoppingController());

  ShoppingScreen({super.key});

  Widget _buildItem(BuildContext context, int index) {
    final item = controller.cartItems[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['imageUrl'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 40);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: MyColors.primaryColor),
                    ),
                    Text(
                      'Category : ${item['category'] != null ? item['category'] : 'N/A'}',
                    ),
                    Obx(() => Text(
                          'Amount : \$${controller.cartItems[index]['amount']?.toStringAsFixed(2) ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Obx(() => Text(
                          'Status : ${controller.cartItems[index]['status'] ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Obx(() => Text(
                          'Order Date : ${formatDate(controller.cartItems[index]['orderDate']) ?? 'N/A'}',
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(
                          "Add button tapped for index: $index, current quantity: ${item['quantity']}, price: ${item['price']}, amount: ${item['amount']}");
                      controller.updateQuantity(
                        item['orderId'],
                        item['cropId'],
                        (item['quantity'] as int) + 1,
                        index,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Obx(() => Text(
                        '${controller.cartItems[index]['quantity']}',
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (item['quantity'] > 1) {
                        controller.updateQuantity(
                          item['orderId'],
                          item['cropId'],
                          (item['quantity'] as int) - 1,
                          index,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.remove,
                          color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  controller.deleteItem(item['orderId'], item['cropId'], index);
                },
                child: const Icon(Icons.delete_outline, color: Colors.grey),
              ),
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
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(
              color: MyColors.primaryColor, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg8.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    "Your cart is empty!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: _buildItem,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(() => Text(
                              "Total: \$${controller.totalAmount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => controller.confirmOrder(
                              context), // Call confirmOrder with context
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
