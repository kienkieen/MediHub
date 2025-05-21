import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/password_input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/social_login_options.dart';
import 'package:medihub_app/core/widgets/login_widgets/text.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/verifyCodeInput.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                // Image.asset(
                //   'assets/images/vietnam_flag.png',
                //   height: 70,
                // ),
                // const SizedBox(height: 8),
                // // Slogan text
                // const Text(
                //   'Giải pháp tiếp cận y tế thông minh',
                //   style: TextStyle(
                //     color: Colors.blue,
                //     fontSize: 14,
                //   ),
                // ),
                // const SizedBox(height: 40),
                // Sign up form
                const SignUpForm(),
                const SizedBox(height: 20),
                // Or sign up with text
                const Text(
                  'Hoặc đăng ký bằng tài khoản',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                // Social login options
                const SocialLoginOptions(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _verifiGmail = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  late String codeVerify;
  bool _isSendVerify = false;
  Color _colorVerify = Colors.blue;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome text
        const Center(
          child: Text(
            'Tạo tài khoản mới',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 24),
        // Full name input
        InputField(
          controller: _nameController,
          label: 'Họ và tên',
          hintText: 'Nhập họ và tên',
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        VerifyCodeInput(controller: _verifiGmail, required: true),
        PrimaryButton(
          text: 'Nhận mã xác thực',
          backgroundColor: _colorVerify,
          onPressed: () {
            _isSendVerify
                ? null
                : _submitRecieveCodeVerify(_phoneController.text);
          },
        ),
        const SizedBox(height: 16),
        // Password input field
        PasswordInputField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          onToggleVisibility: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        const SizedBox(height: 16),
        // Confirm password input field
        PasswordInputField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          hintText: 'Xác nhận mật khẩu',
          onToggleVisibility: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
        const SizedBox(height: 16),
        // Terms and conditions checkbox
        Row(
          children: [
            Checkbox(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value ?? false;
                });
              },
              activeColor: Colors.blue,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Tôi đồng ý với ',
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'Điều khoản sử dụng',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      // Add gesture recognizer here
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Sign up button
        PrimaryButton(
          text: 'ĐĂNG KÝ',
          onPressed: () {
            // Handle sign up
            if (_agreeToTerms) {
              // Proceed with registration
            } else {
              // Show error message about terms
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng đồng ý với điều khoản sử dụng'),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
        // Login link
        AuthLinkText(
          text: 'Đã có tài khoản? ',
          linkText: 'Đăng nhập',
          onLinkTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void changeColor() {
    setState(() {
      _colorVerify = const Color.fromARGB(137, 33, 149, 243);
    });
  }

  String randomCode() {
    final r = Random();
    return List.generate(6, (_) => r.nextInt(10)).join();
  }

  void _submitRecieveCodeVerify(String nameEmail) {
    if (nameEmail.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Hãy nhập Email')));
      return;
    }
    codeVerify = randomCode();
    sendEmail(nameEmail, codeVerify);
    _isSendVerify = true;
    changeColor();
  }
}
