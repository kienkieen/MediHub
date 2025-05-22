import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/core/utils/validators.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/login_widgets/password_input_field.dart';
import 'package:medihub_app/core/widgets/login_widgets/verifyCodeInput.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _verifiGmail = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late String codeVerify;
  bool _isSendVerify = false;
  Color _colorVerify = Colors.blue;

  @override
  void dispose() {
    _passwordController.dispose();
    _newpasswordController.dispose();
    _confirmPasswordController.dispose();
    _verifiGmail.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_verifiGmail.text == codeVerify) {
        bool t = await ChangePassword(
          useMainLogin!.email,
          _passwordController.text,
          _newpasswordController.text,
        );
        if (t) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mật khẩu đã được đặt lại thành công'),
              backgroundColor: Colors.green,
            ),
          );
          // // Navigate back to login screen
          Navigator.popUntil(context, (route) => route.isActive);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'thao tác thất bại! Mật khẩu sai hoặc mật khẩu mới không khớp',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mã xác thực không đúng!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures keyboard doesn't cause overflow
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
          'Đổi Mật Khẩu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical:
                          MediaQuery.of(context).viewInsets.bottom > 0
                              ? 16
                              : 24,
                    ),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.03),
                          PasswordInputField(
                            controller: _passwordController,
                            label: 'Mật khẩu cũ',
                            hintText: 'Nhập mật khẩu cũ',
                            obscureText: _obscurePassword,
                            onToggleVisibility: () {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: constraints.maxHeight * 0.03),
                          PasswordInputField(
                            controller: _newpasswordController,
                            label: 'Mật khẩu mới',
                            hintText: 'Nhập mật khẩu mới',
                            obscureText: _obscurePassword,
                            validator: Validators.validatePassword,
                            onToggleVisibility: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          PasswordInputField(
                            controller: _confirmPasswordController,
                            label: 'Xác nhận mật khẩu',
                            hintText: 'Xác nhận mật khẩu',
                            obscureText: _obscureConfirmPassword,
                            validator:
                                (value) =>
                                    Validators.validatePasswordConfirmation(
                                      value,
                                      _newpasswordController.text,
                                    ),
                            onToggleVisibility: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          VerifyCodeInput(
                            controller: _verifiGmail,
                            required: true,
                            hintText: 'Mã xác thực',
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Nhận mã xác thực',
                            backgroundColor: _colorVerify,
                            onPressed: () {
                              _isSendVerify
                                  ? null
                                  : _submitRecieveCodeVerify(
                                    useMainLogin!.email,
                                  );
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildPasswordRequirements(),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: PrimaryButton(
                              text: 'XÁC NHẬN',
                              onPressed: _handleResetPassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Yêu cầu mật khẩu mới:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          _buildRequirement('Ít nhất 6 ký tự'),
          _buildRequirement('Chứa ít nhất 1 chữ hoa'),
          _buildRequirement('Chứa ít nhất 1 số'),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
