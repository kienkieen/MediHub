import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/button2.dart';
import 'package:medihub_app/core/widgets/noti.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
// import 'package:medihub_app/core/widgets/phone_input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Hồ sơ bệnh nhân'),
      body: Column(
        children: [
          buildNoti(
            content:
                'Bạn chưa có hồ sơ bệnh nhân. Vui lòng tạo mới hồ sơ để được đặt khám.',
            icon: Icons.error_outline,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),

                Image.asset("assets/icons/icon_9.png", width: 260, height: 260),

                SizedBox(height: 30),
                Text('Tạo hồ sơ bệnh nhân', style: TextStyle(fontSize: 20)),

                Text(
                  'Bạn được phép tạo tối đa 10 hồ sơ (Cá nhân và người thân trong gia đình)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 30),
                PrimaryGradientButton(
                  text: 'CHƯA TỪNG ĐĂNG KÝ MỚI',
                  icon: Icons.person_add,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateProfile(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12),
                // PrimaryButton(
                //   text: 'QUÉT MÃ BHYT / CCCD',
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const Naviga,
                //       ),
                //     );
                //   },
                //   icon: Icons.qr_code_scanner,
                //   backgroundColor: Colors.transparent,
                //   textColor: Color(0xFF019BD3),
                //   borderColor: Color(0xFF019BD3),
                //   borderRadius: 10,
                // ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _idController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String? _genderValue;
  String? _jobValue;
  String? _countryValue;
  String? _ethnicValue;
  String? _provinceValue;
  String? _districtValue;
  String? _wardValue;

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _idController.dispose();
    _insuranceController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppbarWidget(title: 'Tạo mới hồ sơ'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildNoti(
              content:
                  'Vui lòng cung cấp thông tin chính xác để được phục vụ tốt nhất.',
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Thông tin chung'),

                  InputField(
                    controller: _nameController,
                    label: 'Họ và tên (có dấu)',
                    hintText: 'Nhập họ và tên',
                    isRequired: true,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InputField(
                          controller: _dobController,
                          label: 'Ngày sinh',
                          hintText: 'Ngày / Tháng / Năm',
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownField(
                          label: 'Giới tính',
                          value: _genderValue,
                          items: ['Nam', 'Nữ', 'Khác'],
                          isRequired: true,
                          onChanged: (newValue) {
                            setState(() {
                              _genderValue = newValue;
                            });
                          },
                          padding: const EdgeInsets.only(bottom: 8),
                          hintText: 'Giới tính',
                        ),
                      ),
                    ],
                  ),

                  InputField(
                    controller: _idController,
                    label: 'Mã định danh/CCCD/Passport',
                    hintText: 'Vui lòng nhập Mã định danh/CCCD/Passport',
                    isRequired: true,
                  ),

                  InputField(
                    controller: _insuranceController,
                    label: 'Mã bảo hiểm y tế',
                    hintText: 'Mã bảo hiểm y tế',
                  ),

                  DropdownField(
                    label: 'Nghề nghiệp',
                    value: _jobValue,
                    items: [
                      'Công nhân',
                      'Nhân viên văn phòng',
                      'Học sinh/sinh viên',
                    ],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _jobValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Chọn nghề nghiệp',
                  ),

                  _buildPhoneInputField(
                    _phoneController,
                    'Số điện thoại',
                    '09xxxxxxxx',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Phần 2: Thông tin địa chỉ
                  _buildSectionTitle('Thông tin địa chỉ'),
                  DropdownField(
                    label: 'Quốc gia',
                    value: _countryValue,
                    items: ['Việt Nam', 'Khác'],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _countryValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Việt Nam',
                  ),

                  DropdownField(
                    label: 'Dân tộc',
                    value: _ethnicValue,
                    items: ['Kinh', 'Tày', 'Thái'],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _ethnicValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Chọn Dân tộc',
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Địa chỉ theo CCCD'),

                  DropdownField(
                    label: 'Tỉnh/TP',
                    value: _provinceValue,
                    items: ['Hà Nội', 'TP.HCM', 'Đà Nẵng'],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _provinceValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Chọn tỉnh thành',
                  ),

                  DropdownField(
                    label: 'Quận/Huyện',
                    value: _districtValue,
                    items: ['Chọn Quận/Huyện'],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _districtValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Chọn Quận/Huyện',
                  ),

                  DropdownField(
                    label: 'Phường/Xã',
                    value: _wardValue,
                    items: ['Chọn Phường/Xã'],
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _wardValue = newValue;
                      });
                    },
                    padding: const EdgeInsets.only(bottom: 8),
                    hintText: 'Chọn Phường/ =Xã',
                  ),

                  InputField(
                    controller: _phoneController,
                    label: 'Số nhà/ Tên đường/ Ấp thôn xóm',
                    hintText: 'Chỉ nhập số nhà, tên đường, ấp thôn xóm',
                    isRequired: true,
                  ),

                  const SizedBox(height: 30),

                  // Nút tạo hồ sơ
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Xử lý tạo hồ sơ
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue[800],
                      ),
                      child: const Text(
                        'Tạo mới hồ sơ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildPhoneInputField(
    TextEditingController controller,
    String label,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label, style: TextStyle(fontSize: 16)),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade700, width: 1),
          ),
          child: Row(
            children: [
              // Country code selector
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/vietnam_flag.png",
                      width: 24,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text('+84', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              // Phone input
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
