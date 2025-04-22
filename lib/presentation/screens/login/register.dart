import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/core/utils/validators.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/password_input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/email_input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/social_login_options.dart';
import 'package:medihub_app/core/widgets/login_widgets/text.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeVerifyController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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

  void _submitForm(String email, String password) async {
    // First validate form fields
    if (_formKey.currentState!.validate()) {
      // Check if terms are agreed to
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng đồng ý với điều khoản sử dụng'),
          ),
        );
        return;
      }

      try {
        if (codeVerify != _codeVerifyController.text) throw Exception(1);
        if (await signUp(email, password)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Đăng ký thất bại')));
        }
      } catch (e) {
        if (e == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mã xác thực không đúng')),
          );
        }
      }
      Navigator.pop(context);
    }
  }

  String randomCode() {
    final r = Random();
    return List.generate(6, (_) => r.nextInt(10)).join();
  }

  void changeColor() {
    setState(() {
      _colorVerify = const Color.fromARGB(137, 33, 149, 243);
    });
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
          _buildNameInputField(),
          const SizedBox(height: 16),
          // Phone/Email input
          EmailInputField(
            controller: _phoneController,
            hintText: 'Email',
            required: true,
          ),
          const SizedBox(height: 16),
          VerifyCodeInput(
            controller: _codeVerifyController,
            hintText: 'Mã xác thực Email',
            required: true,
          ),
          const SizedBox(height: 16),
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
            required: true,
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
            required: true,
            hintText: 'Xác nhận mật khẩu',
            onToggleVisibility: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
            validator:
                (value) => Validators.validatePasswordConfirmation(
                  value,
                  _passwordController.text,
                ),
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
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () => showClause(context),
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
              _submitForm(_phoneController.text, _passwordController.text);
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
      ),
    );
  }

  Widget _buildNameInputField() {
    return TextFormField(
      controller: _nameController,
      validator: Validators.validateName,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Họ và tên',
        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
