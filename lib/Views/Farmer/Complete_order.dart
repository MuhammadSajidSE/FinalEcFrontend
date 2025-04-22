import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FarmerOrdersScreen extends StatefulWidget {
  const FarmerOrdersScreen({Key? key}) : super(key: key);

  @override
  _FarmerOrdersScreenState createState() => _FarmerOrdersScreenState();
}

class _FarmerOrdersScreenState extends State<FarmerOrdersScreen> {
  List<dynamic> orders = [];
  bool isLoading = true;
  int? farmerId;

  @override
  void initState() {
    super.initState();
    _getFarmerId();
  }

  Future<void> _getFarmerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId'); // Fetch stored userId

    if (userId != null) {
      setState(() {
        farmerId = userId;
      });
      _fetchOrders(userId);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Error: User ID not found in SharedPreferences")),
      );
    }
  }

  Future<void> _fetchOrders(int farmerId) async {
    final url = Uri.parse(
        "http://152.67.10.128:5280/api/farmer/GetConfirmedOrdersByFarmer/${farmerId}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> orderList = data["\$values"];

        for (var order in orderList) {
          final buyerData = await _fetchBuyerDetails(order["buyerId"]);
          order["buyerDetails"] = buyerData;
        }

        setState(() {
          orders = orderList;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<Map<String, dynamic>> _fetchBuyerDetails(int buyerId) async {
    final url = Uri.parse("http://152.67.10.128:5280/api/Admin/$buyerId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error fetching buyer details: $e");
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: MyColors.primaryColor,
                child: Stack(
                  children: [
                    // Back Button
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmerMain()),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: MyColors.backgroundScaffoldColor,
                        ),
                      ),
                    ),
                    // Centered Title
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Confirmed Orders',
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
            ],
          ),
          const SizedBox(height: 15),

          // Body Section
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: MyColors.primaryColor,
                    ),
                  )
                : orders.isEmpty
                    ? Center(
                        child: Text(
                          "No confirmed orders found.",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: MyColors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          var order = orders[index];
                          var buyer = order["buyerDetails"] ?? {};

                          return Card(
                            margin: const EdgeInsets.all(12),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Crop Image and Name
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          order["cropImage"],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order['cropName'],
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Quantity: ${order["orderQuantity"]}",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Amount: Rs. ${order["orderAmount"]}",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 2),
                                  // Buyer Info
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          buyer["imageUrl"] ?? "",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            buyer["userName"] ?? "Unknown",
                                            style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            buyer["address"] ?? "No address",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.black,
                                            ),
                                          ),
                                          Text(
                                            buyer["phoneNumber"] ??
                                                "No phone",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: MyColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
