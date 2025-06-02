import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/social_login_options.dart';
import 'package:medihub_app/core/widgets/login_widgets/text.dart';
import 'package:medihub_app/core/widgets/login_widgets/password_input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/email_input_field.dart';
import 'package:medihub_app/firebase_helper/cart_helper.dart';
import 'package:medihub_app/firebase_helper/stateData_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/presentation/screens/login/fogot_password.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/presentation/screens/login/register.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';

class LoginScreen extends StatelessWidget {
  final bool isNewLoginl;
  const LoginScreen({super.key, required this.isNewLoginl});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isNewLoginl,
      child: Scaffold(
        appBar:
            isNewLoginl
                ? AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Handle back button press
                    },
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                )
                : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity, // Chiều ngang full
              height: MediaQuery.of(context).size.height, // Chiều cao full
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset('assets/images/vietnam_flag.png', height: 70),
                  const SizedBox(height: 8),
                  // Slogan
                  const Text(
                    'Giải pháp tiếp cận y tế thông minh',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  const SizedBox(height: 40),
                  const LoginForm(),
                  const SizedBox(height: 20),
                  const Text(
                    'Hoặc đăng nhập bằng tài khoản',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const SocialLoginOptions(),

                  // Không dùng Spacer nữa vì nó gây lỗi với ScrollView
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      bool userState = await checkState.getStateUser(context, email);
      if (userState) {
        showErrorUser(context);
      } else {
        if (await SignIn(email, password)) {
          cart = await getCartbyUserID(useMainLogin!.userId);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationBottom()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thông tin đăng nhập không đúng')),
          );
        }
      }
    }
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
              'Vui lòng đăng nhập để tiếp tục',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 24),
          // Phone/Email input
          EmailInputField(controller: _phoneController, hintText: 'Email'),
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
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Login button
          PrimaryButton(
            text: 'ĐĂNG NHẬP',
            onPressed:
                () => {
                  _submitForm(_phoneController.text, _passwordController.text),
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
      ),
    );
  }
}
