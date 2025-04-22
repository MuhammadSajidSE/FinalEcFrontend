
import 'package:agriconnect/chatbot_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:agriconnect/Controllers/FarmerController.dart';
import 'package:agriconnect/Views/Common/profile_screen.dart';
import 'package:agriconnect/Views/Farmer/AddCrop.dart';
import 'package:agriconnect/Views/Farmer/cropslist.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class FarmerMain extends StatefulWidget {
  const FarmerMain({Key? key}) : super(key: key);

  @override
  State<FarmerMain> createState() => _FarmerMainState();
}

class _FarmerMainState extends State<FarmerMain> with TickerProviderStateMixin {
  final Farmercontroller _controller = Farmercontroller();
  late MotionTabBarController _motionTabBarController;

  String? imageUrl;
  String? username;
  String? userId;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _controller.loadUserData();
    setState(() {
      imageUrl = userData['imageUrl'];
      username = userData['username'];
      userId = userData['userId'];
    });
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   title: const Text('Farmer Dashboard'),
      //   actions: [
      //     if (imageUrl != null)
      //       Padding(
      //         padding: const EdgeInsets.only(right: 8.0),
      //         child: CircleAvatar(
      //           backgroundImage: NetworkImage(imageUrl!),
      //           radius: 20,
      //         ),
      //       ),
      //   ],
      // ),
      
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          _buildHomeScreen(),
          _buildShoppingScreen(),
          _buildProfileScreen(),
          _buildChatBotScreen(),

        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Home", "Cart","Profile","ChatBot" ],
        icons: const [Icons.home, Icons.shopping_cart,Icons.person, Icons.smart_toy],
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
            _motionTabBarController.index = value;
          });
        },
      ),
    );
  }


  TextStyle _drawerTextStyle() => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MyColors.black,
      );

  Widget _buildHomeScreen() => CropListScreen();

  Widget _buildProfileScreen() => ProfileScreen();

  Widget _buildShoppingScreen() => AddCrop();

  Widget _buildChatBotScreen() => ChatBotScreen();
}
