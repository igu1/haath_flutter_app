import 'package:disaster_management_app/controller/details.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

class GetDetails extends StatelessWidget {
  GetDetails({super.key});

  final detC = Get.put(DetailsController());

  final String initialCountry = 'IN';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "H A A T H",
                style: GoogleFonts.getFont(
                  'Lexend',
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
              Text(
                "From Team Retro",
                style: GoogleFonts.getFont(
                  'Lexend',
                  fontWeight: FontWeight.w200,
                  letterSpacing: 3,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: detC.nameController,
                      label: 'Name',
                      keyboardType: TextInputType.name,
                      onChanged: (_) => detC.updateButton(),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: detC.emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => detC.updateButton(),
                    ),
                    const SizedBox(height: 16),
                    IntlPhoneField(
                      controller: detC.phoneController,
                      initialCountryCode: initialCountry,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (_) => detC.updateButton(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 60,
                child: Obx(() => ElevatedButton(
                    onPressed: detC.buttonEnabled.value
                        ? () async {
                            detC.submitForm();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        counter: const Offstage(),
        labelText: ' $label',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 3.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
