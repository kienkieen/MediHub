import 'dart:math';
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/core/utils/validators.dart';
// Import the extracted widgets
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/email_input_field.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';
import 'package:medihub_app/presentation/screens/login/reset_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isVerificationSent = false;
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String codeVerify = '';
  Timer? _timer;
  int _secondsRemaining = 0;

  void startTimer() {
    setState(() {
      _secondsRemaining = 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
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
  }

  void _sendVerification(bool isNewSend) {
    if (isNewSend) {
      if (_formKey.currentState!.validate()) {
        _submitRecieveCodeVerify(_emailController.text.trim());
        setState(() {
          _isVerificationSent = true;
        });
      }
    } else {
      _submitRecieveCodeVerify(_emailController.text.trim());
    }
    startTimer();
  }

  void _verifyOtp() async {
    // Combine all OTP digits
    String otp = _otpControllers.map((controller) => controller.text).join();

    // Validate OTP
    String? otpError = Validators.validateOtp(otp);
    if (otpError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(otpError)));
      return;
    }
    if (otp != codeVerify) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mã xác nhận không đúng')));
      return;
    }
    bool up = false;
    if (otp == codeVerify) {
      up = await resetPassword(_emailController.text.trim());
    }

    if (up) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text(
              'Gửi thiết lập lại mật khẩu thành công. Vui lòng kiểm tra email của bạn.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(isNewLoginl: false),
                    ),
                  );
                },
                child: const Text('Quay về trang đăng nhập'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đặt lại mật khẩu thất bại')),
      );
    }
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
                Image.asset('assets/images/vietnam_flag.png', height: 70),
                const SizedBox(height: 40),
                // Either phone input or OTP input
                _isVerificationSent
                    ? _buildOtpVerification()
                    : _buildPhoneVerification(),
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
            'Vui lòng nhập email để lấy lại mật khẩu',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          EmailInputField(controller: _emailController, hintText: 'Email'),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'GỬI MÃ XÁC NHẬN',
            onPressed: () {
              _sendVerification(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      children: [
        const Text(
          'Vui lòng nhập mã xác nhận đã được gửi đến email của bạn',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
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
              fontFamily: 'Calistoga',
            ),
            children: [
              TextSpan(
                text:
                    _secondsRemaining == 0
                        ? 'Gửi lại mã'
                        : 'Gửi lại mã ($_secondsRemaining giây)',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Calistoga',
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        if (_secondsRemaining == 0) {
                          _sendVerification(false);
                          startTimer();
                        }
                      },
              ),
            ],
            // children: [
            //   TextSpan(
            //     onEnter: (event) {
            //       _secondsRemaining == 0 ? _sendVerification : startTimer();
            //     },
            //     text: 'Gửi lại mã ($_secondsRemaining giây)',
            //     style: const TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Calistoga',
            //     ),
            //     // Add gesture recognizer here
            //   ),
            // ],
          ),
        ),
        const SizedBox(height: 40),
        PrimaryButton(text: 'XÁC NHẬN', onPressed: _verifyOtp),
      ],
    );
  }

  Widget _buildOtpInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 50,
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
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
    );
  }
}
