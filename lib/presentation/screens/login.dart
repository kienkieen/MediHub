import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/button.dart';
import 'package:medihub_app/core/widgets/social_login_options';
import 'package:medihub_app/core/widgets/text.dart';  
import 'package:medihub_app/core/widgets/password_input_field.dart';
import 'package:medihub_app/core/widgets/phone_input_field.dart';
import 'package:medihub_app/presentation/screens/fogot_password.dart';
import 'package:medihub_app/presentation/screens/home.dart';
import 'package:medihub_app/presentation/screens/register.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.lightBlue),
          onPressed: () {
            // Handle back button press
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
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
              const SizedBox(height: 8),
              // Slogan text
              const Text(
                'Giải pháp tiếp cận y tế thông minh',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              // Login form
              const LoginForm(),
              const SizedBox(height: 20),
              // Or login with text
              const Text(
                'Hoặc đăng nhập bằng tài khoản',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              // Social login options
              const SocialLoginOptions(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
            'Vui lòng đăng nhập để tiếp tục',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Phone input with country code
        PhoneInputField(controller: _phoneController),
        const SizedBox(height: 16),
        // Password input field
        PasswordInputField(
          controller: _passwordController,
          obscureText: _obscureText,
          onToggleVisibility: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        const SizedBox(height: 8),
        // Forgot password button
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Điều hướng tới màn hình ForgotPasswordScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
            ),
            child: const Text(
              'Quên mật khẩu?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
        // Login button
        PrimaryButton(
          text: 'ĐĂNG NHẬP',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedihubHomeScreen(),
                ),
              );
          },
        ),
        const SizedBox(height: 16),
        // Register link
        AuthLinkText(
          text: 'Bạn chưa có tài khoản? ',
          linkText: 'Đăng ký',
          onLinkTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
        ),
      ],
    );
  }
}