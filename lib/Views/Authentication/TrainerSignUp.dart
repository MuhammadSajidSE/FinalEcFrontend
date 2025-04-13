// import 'package:agriconnect/Controllers/TrainerController.dart';
// import 'package:flutter/material.dart';

// class Trainersignup extends StatefulWidget {
//   const Trainersignup({Key? key}) : super(key: key);

//   @override
//   _TrainersignupState createState() => _TrainersignupState();
// }

// class _TrainersignupState extends State<Trainersignup> {
//   final Trainercontroller _controller = Trainercontroller();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Buyer Signup')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _controller.formKey,
//           child: Column(
//             children: [
//               _buildTextField(_controller.userNameController, 'Username'),
//               _buildTextField(_controller.emailController, 'Email',
//                   inputType: TextInputType.emailAddress),
//               _buildTextField(_controller.passwordController, 'Password',
//                   obscureText: true),
//               _buildTextField(_controller.phoneNumberController, 'Phone Number',
//                   inputType: TextInputType.phone),
//               _buildTextField(_controller.addressController, 'Address'),
//               _buildTextField(_controller.nicController, 'NIC'),
//               _buildTextField(_controller.experienceController, 'Experience'),
//               const SizedBox(height: 10),
//               _controller.image != null
//                   ? Image.file(_controller.image!, height: 100)
//                   : const Text('No image selected'),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _controller.pickImage();
//                   setState(() {});
//                 },
//                 child: const Text('Pick Image'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _controller.registerBuyer(context),
//                 child: const Text('Register as Trainer'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {bool obscureText = false,
//       TextInputType inputType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//         obscureText: obscureText,
//         keyboardType: inputType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return '$label is required';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
