import 'dart:convert';
import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;
  int _totalAmount = 0;
  int? userId;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      int? buyerId = await prefs.getInt('userId');

      final url =
          Uri.parse("http://152.67.10.128:5280/api/Order/buyer/$buyerId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<dynamic> orders = data["\$values"] ?? [];
        List<Map<String, dynamic>> cartItems = [];

        for (var order in orders) {
          List<dynamic> crops = order["crops"]["\$values"] ?? [];

          for (var crop in crops) {
            if (crop["status"] == "Not Confirmed") {
              cartItems.add({
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
              });
            }
          }
        }

        setState(() {
          _cartItems = cartItems;
          _calculateTotalAmount();
          _isLoading = false;
        });
      } else {
        print("Failed to fetch cart items: ${response.body}");
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print("Error fetching cart: $e");
      setState(() => _isLoading = false);
    }
  }

  void _calculateTotalAmount() {
    _totalAmount =
        _cartItems.fold(0, (sum, item) => sum + (item['amount'] as int));
  }

  void _deleteItem(int orderId) async {
    final url =
        Uri.parse("http://152.67.10.128:5280/api/Order/cancel-order/$orderId");

    print("Cancelling order: $orderId");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Order cancelled successfully!");
        _fetchCartItems(); // Refresh cart after cancellation
      } else {
        print(
            "Failed to cancel order. Status: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      print("Error cancelling order: $e");
    }
  }

  void _editItem(int orderId, int cropId, int currentQuantity) {
    TextEditingController quantityController =
        TextEditingController(text: currentQuantity.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Quantity"),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Enter new quantity"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                int newQuantity =
                    int.tryParse(quantityController.text) ?? currentQuantity;
                Navigator.pop(context);
                _updateQuantity(orderId, cropId, newQuantity);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _updateQuantity(int orderId, int cropId, int quantity) async {
    final url = Uri.parse("http://152.67.10.128:5280/api/Order/eidt-order");

    final body = jsonEncode({
      "orderId": orderId,
      "cropId": cropId,
      "quantity": quantity,
    });
    print("");
    print("");
    print("");
    print("");
    print("");

    final Map<String, dynamic> orderData = {
      "orderId": orderId,
      "cropId": cropId,
      "quantity": quantity,
    };

    print("Updating quantity: $body");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        print("Quantity updated successfully!");
        _fetchCartItems(); // Refresh cart
      } else {
        print(
            "Failed to update quantity. Status: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      print("Error updating quantity: $e");
    }
  }

  /// Loads user data and fetches confirmed crops
  Future<void> _initializeData() async {
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
    print("User ID Loaded: $userId");
  }

  Future<void> confirmOrder() async {
    if (userId == null) {
      print("User ID is null. Cannot confirm order.");
      return;
    }

    final url =
        Uri.parse('http://152.67.10.128:5280/api/Order/confirm-orders/$userId');
    print(url);

    try {
      final response =
          await http.post(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        print("Order confirmed successfully!");

        // Navigate back to BuyerMain
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BuyerMain()),
        );
      } else {
        print(
            "Error confirming order: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty!"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final item = _cartItems[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.network(item['imageUrl'],
                                      width: 50, height: 50, fit: BoxFit.cover),
                                  title: Text(item['name'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Category: ${item['category']}"),
                                      Text("Amount: Rs. ${item['amount']}",
                                          style: const TextStyle(
                                              color: Colors.green)),
                                      Text("Quantity: ${item['quantity']} kg"),
                                      Text("Status: ${item['status']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("Order Date: ${item['orderDate']}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        label: const Text("Edit"),
                                        onPressed: () {
                                          _editItem(item['orderId'],
                                              item['cropId'], item['quantity']);
                                        }),
                                    TextButton.icon(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      label: const Text("Delete"),
                                      onPressed: () => _deleteItem(
                                          item['orderId']), // Pass orderId
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text("Total Amount: Rs. $_totalAmount",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: confirmOrder,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            child: const Text("Confirm Order",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
