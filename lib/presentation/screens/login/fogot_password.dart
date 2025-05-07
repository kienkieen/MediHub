import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/core/utils/validators.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/email_input_field.dart';
import 'package:medihub_app/presentation/screens/login/reset_password.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isVerificationSent = false;
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  
  @override
  void dispose() {
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _sendVerification() {
    if (_formKey.currentState!.validate()) {
      // In a real app, this would send a verification code
      setState(() {
        _isVerificationSent = true;
      });
    }
  }

  void _verifyOtp() {
    // Combine all OTP digits
    String otp = _otpControllers.map((controller) => controller.text).join();
    
    // Validate OTP
    String? otpError = Validators.validateOtp(otp);
    if (otpError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(otpError)),
      );
      return;
    }
    
    // If valid, proceed to reset password screen
    _navigateToResetPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.lightBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Quên mật khẩu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // Logo
                Image.asset(
                  'assets/images/vietnam_flag.png',
                  height: 70,
                ),
                const SizedBox(height: 40),
                // Either phone input or OTP input
                _isVerificationSent ? _buildOtpVerification() : _buildPhoneVerification(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneVerification() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Vui lòng nhập số điện thoại để lấy lại mật khẩu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          EmailInputField(
            controller: _phoneController,
            hintText: 'Email',
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'GỬI MÃ XÁC NHẬN',
            onPressed: _sendVerification,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      children: [
        const Text(
          'Vui lòng nhập mã xác nhận đã được gửi đến số điện thoại của bạn',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        _buildOtpInputs(),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Không nhận được mã? ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Gửi lại',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                // Add gesture recognizer here
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        PrimaryButton(
          text: 'XÁC NHẬN',
          onPressed: _verifyOtp,
        ),
      ],
    );
  }

  Widget _buildOtpInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 40,
          height: 50,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  _focusNodes[index + 1].requestFocus();
                }
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        ),
      ),
    );
  }

  void _navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }
}

