import 'dart:io';
import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCrop extends StatefulWidget {
  const AddCrop({super.key});

  @override
  _AddCropState createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  DateTime? _harvestingDate;
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitCrop(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    if (_image == null) {
      _showSnackbar(context as BuildContext, "Please select an image.");
      return;
    }
    if (_harvestingDate == null) {
      _showSnackbar(
          context as BuildContext, "Please select a harvesting date.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      int? farmerId = await prefs.getInt('userId');

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://152.67.10.128:5280/api/crops"),
      );

      // Add text fields
      request.fields["name"] = _nameController.text;
      request.fields["category"] = _categoryController.text;
      request.fields["price"] = _priceController.text;
      request.fields["quantity"] = _quantityController.text;
      request.fields["farmerId"] = farmerId.toString();
      request.fields["harvestingDate"] =
          _harvestingDate!.toUtc().toIso8601String();

      // Attach image file
      var imageStream = http.ByteStream(_image!.openRead());
      var imageLength = await _image!.length();
      var multipartFile = http.MultipartFile(
        'File', // This should match the backend field name
        imageStream,
        imageLength,
        filename: basename(_image!.path),
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);

      var response = await request.send();
      setState(() => _isLoading = false);

      if (response.statusCode == 201) {
        _showSnackbar(context, "Crop added successfully!",
            isSuccess: true);
        print("");
        print("");
        print("");
        print("Crop added successfully!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FarmerMain()),
          );
      } else {
        _showSnackbar(context as BuildContext,
            "Failed to add crop. Status code: ${response.statusCode}");
        print("Failed to add crop. Status code: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackbar(context as BuildContext,"Error: $e");
      print('');
      print('');
      print('');
      print('');
      print('');
      print("Error: $e");
    }
  }

void _showSnackbar(BuildContext context, String message, {bool isSuccess = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
  children: [
   
Stack(
  children: [
    // Top container with background color and centered title
    Container(
      height: 100,
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
                'Add Crop',
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
)



    // Profile Avatar
    
  ],
),

    SizedBox(height: 30,),
           Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
             child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: TextFormField(
                    controller: _nameController,
                     validator: (value) => value!.isEmpty ? "Enter Your Crop Name" : null,
                     cursorColor:  MyColors.primaryColor,
                     decoration: InputDecoration(
                       
                       hintText: "Enter Your Crop Name",
                       prefixIcon:
                Icon(Icons.crop, color: MyColors.primaryColor),
                       filled: true,
                       fillColor: Colors.white, // Background color
                       border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded borders
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
                       ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                       // Show eye icon only if it's a password field
                     ),
                     
                     style: const TextStyle(fontSize: 16),
                   ),
                 ),
           ),

            SizedBox(height: 30,),
           Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
             child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: TextFormField(
                    controller: _categoryController,
                     validator: (value) => value!.isEmpty ? "Enter your Category name" : null,
                     cursorColor:  MyColors.primaryColor,
                     decoration: InputDecoration(
                       
                       hintText: "Enter Your Category Name",
                       prefixIcon:
                Icon(Icons.crop, color: MyColors.primaryColor),
                       filled: true,
                       fillColor: Colors.white, // Background color
                       border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded borders
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
                       ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                       // Show eye icon only if it's a password field
                     ),
                     
                     style: const TextStyle(fontSize: 16),
                   ),
                 ),
           ),
           
               SizedBox(height: 30,),
           Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
             child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: TextFormField(
                    controller: _priceController,
                     validator: (value) => value!.isEmpty ? "Enter Your Price Name" : null,
                     cursorColor:  MyColors.primaryColor,
                     decoration: InputDecoration(
                       
                       hintText: "Enter Your Price Name",
                       prefixIcon:
                Icon(Icons.crop, color: MyColors.primaryColor),
                       filled: true,
                       fillColor: Colors.white, // Background color
                       border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded borders
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
                       ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                       // Show eye icon only if it's a password field
                     ),
                     
                     style: const TextStyle(fontSize: 16),
                   ),
                 ),
           ),
              

               SizedBox(height: 30,),
           Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
             child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: TextFormField(
                    controller: _quantityController,
                     validator: (value) => value!.isEmpty ? "Enter Your Quantity name" : null,
                     cursorColor:  MyColors.primaryColor,
                     decoration: InputDecoration(
                       
                       hintText: "Enter Your Quantity Name",
                       prefixIcon:
                Icon(Icons.crop, color: MyColors.primaryColor),
                       filled: true,
                       fillColor: Colors.white, // Background color
                       border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded borders
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
                       ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
                       ),
                       contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                       // Show eye icon only if it's a password field
                     ),
                     
                     style: const TextStyle(fontSize: 16),
                   ),
                 ),
           ),
          
             

              Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 20),
                // padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2,
                    color:  MyColors.grey
                  )
                ),
                child: ListTile(
                  title: 
                  Container(margin: EdgeInsets.only(left: 0),
                    child: Text(
                     _harvestingDate == null
                          ? "Select Harvesting Date"
                          : _harvestingDate!.toLocal().toString().split(' ')[0],
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      
                      // fontWeight: FontWeight.w500,
                      color:   _harvestingDate == null? MyColors.profileColor:MyColors.primaryColor,
                    ),
                                  ),
                  ),
                            
                  trailing: Icon(Icons.calendar_today,color: MyColors.primaryColor,),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() => _harvestingDate = pickedDate);
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!, height: 100)
                  : Center(
                    child: Container(
                                margin: EdgeInsets.only(left: 15,right: 15),
                                child:    CustomButton(
                            radius: CustomSize().customWidth(context) / 10,
                            height: CustomSize().customHeight(context) / 15,
                            width: CustomSize().customWidth(context)/1.5 ,
                            title: "Pick Image",
                            
                            loading: false,
                            color: MyColors.primaryColor,
                            onTap: () {
                               _pickImage(); 
                            },
                          ),
                               ),
                  ),
                 
              const SizedBox(height: 20),
              _isLoading
                  ?  Center(child: CircularProgressIndicator(
                    backgroundColor: MyColors.primaryColor,
                  ),
                  )
                  :  Center(
                    child: Container(
                                margin: EdgeInsets.only(left: 15,right: 15),
                                child:    CustomButton(
                            radius: CustomSize().customWidth(context) / 10,
                            height: CustomSize().customHeight(context) / 15,
                            width: CustomSize().customWidth(context)/1.5 ,
                            title: "Sumbit",
                            
                            loading: false,
                            color: MyColors.primaryColor,
                            onTap: () {
                          
                            },
                          ),
                               ),
                  ),
                   SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
