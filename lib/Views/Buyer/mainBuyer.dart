import 'package:agriconnect/Controllers/LoginController.dart';
import 'package:agriconnect/Controllers/buyerController.dart';
import 'package:agriconnect/Models/CropModel.dart';
import 'package:agriconnect/Views/Buyer/BuyerTransection.dart';
import 'package:agriconnect/Views/Buyer/complete_order.dart';
import 'package:agriconnect/Views/Buyer/history_order.dart';
import 'package:agriconnect/Views/Common/profile_screen.dart';
import 'package:agriconnect/Views/Order/detailed.dart';
import 'package:agriconnect/Views/Order/shoppingCard.dart';
import 'package:agriconnect/Views/chatting/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerMain extends StatefulWidget {
  BuyerMain({Key? key}) : super(key: key);

  @override
  _BuyerMainState createState() => _BuyerMainState();
}

class _BuyerMainState extends State<BuyerMain> {
  final BuyerController _controller = BuyerController();
  List<Crop> crops = [];
  List<Crop> filteredCrops = [];
  bool isLoading = true;
  String? imageUrl;
  String? username;
  int? userId;
  String? roleName;
  String categoryFilter = "";
  String nameFilter = "";
  int _selectedIndex = 0;
  String phoneno = '';
  @override
  void initState() {
    super.initState();
    fetchCrops();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      imageUrl = prefs.getString('imageUrl');
      userId = prefs.getInt('userId');
      roleName = prefs.getString('roleName');
      phoneno = prefs.getString('phoneNumber') ?? '';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Category'),
                  onChanged: (value) {
                    categoryFilter = value;
                    _filterCrops();
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    nameFilter = value;
                    _filterCrops();
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredCrops.length,
                  itemBuilder: (context, index) {
                    return CropCard(crop: filteredCrops[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildProfileScreen() {
    return ProfileScreen();
  }

  Widget _buildshopingscrenn() {
    return ShoppingScreen();
  }

  // Widget _buildShoppingScreen() {
  //   return Center(child: Text('Shopping Cart Screen'));
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Main Page'),
        actions: [
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
                radius: 20,
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null ? const Icon(Icons.person) : null,
              ),
              accountName: Text('${username}'),
              accountEmail: Text('${userId}'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                LoginController().logout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_rounded),
              title: const Text('Ordered'),
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
              title: const Text('Transection'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionScreen(userId: userId!)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('chatting'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsScreen(phone: phoneno,)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('History Order'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryOrder()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeScreen(),
          _buildProfileScreen(),
          ShoppingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            // Assuming ShoppingScreen is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingScreen()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final Crop crop;

  CropCard({required this.crop});

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
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  crop.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                crop.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Price: ${crop.price} per kg',
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
