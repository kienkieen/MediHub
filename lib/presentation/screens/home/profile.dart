import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/button2.dart';
import 'package:medihub_app/core/widgets/button.dart';
import 'package:medihub_app/core/widgets/noti.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/input_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Hồ sơ bệnh nhân'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildNoti(
              content:
                  'Bạn chưa có hồ sơ bệnh nhân. Vui lòng tạo mới hồ sơ để được đặt khám.',
              icon: Icons.error_outline,
            ),
            const SizedBox(height: 20),
            const _EmptyProfileContent(),
          ],
        ),
      ),
    );
  }
}

class _EmptyProfileContent extends StatelessWidget {
  const _EmptyProfileContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
          const SizedBox(height: 30),
          const Text(
            'Tạo hồ sơ bệnh nhân',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          const Text(
            'Bạn được phép tạo tối đa 10 hồ sơ (Cá nhân và người thân trong gia đình)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 25),
          PrimaryGradientButton(
            text: 'CHƯA TỪNG ĐĂNG KÝ MỚI',
            icon: Icons.person_add,
            onPressed: () => _navigateToCreateProfile(context),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'ĐÃ TỪNG KHÁM TẠI MEDIHUB',
            onPressed: () => _navigateToCreateProfile(context),
            icon: Icons.search_outlined,
            backgroundColor: Colors.transparent,
            textColor: Color(0xFF019BD3),
            borderColor: Color(0xFF019BD3),
            borderRadius: 10,
          ),
        ],
      ),
    );
  }

  void _navigateToCreateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateProfile()),
    );
  }
}

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  // Controllers
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _idController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  //FocusNode
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _jobFocusNode = FocusNode();

  // Dropdown values
  String? _genderValue;
  String? _jobValue;
  String? _countryValue;
  String? _ethnicValue;
  String? _provinceValue;
  String? _districtValue;
  String? _wardValue;

  // Form sections data
  final List<String> _genderOptions = ['Nam', 'Nữ', 'Khác'];
  final List<String> _jobOptions = [
    'Công nhân',
    'Nhân viên văn phòng',
    'Học sinh/sinh viên',
    'Giáo viên',
    'Bác sĩ',
    'Kỹ sư',
    'Khác',
  ];
  final List<String> _countryOptions = [
    'Việt Nam',
    'Thái Lan',
    'Singapore',
    'Nhật Bản',
    'Hàn Quốc',
    'Trung Quốc',
    'Hoa Kỳ',
    'Pháp',
    'Đức',
    'Anh',
    'Úc',
  ];
  final List<String> _ethnicOptions = ['Kinh', 'Tày', 'Thái', 'Mường', 'Khác'];
  final List<String> _provinceOptions = [
    'Hà Nội',
    'Hải Phòng',
    'Quảng Ninh',
    'Bắc Ninh',
    'Hải Dương',
    'Hưng Yên',
    'Thái Bình',
    'Nam Định',
    'Ninh Bình',

    'Đà Nẵng',
    'Thừa Thiên Huế',
    'Quảng Nam',
    'Quảng Ngãi',
    'Bình Định',
    'Khánh Hòa',
    'Phú Yên',

    'TP.HCM',
    'Cần Thơ',
    'Bình Dương',
    'Đồng Nai',
    'Bà Rịa - Vũng Tàu',
    'Long An',
    'Tiền Giang',
    'An Giang',
  ];

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _dobController.addListener(_validateForm);
    _idController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _insuranceController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    // Set defaults
    _countryValue = 'Việt Nam';
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _dobController.removeListener(_validateForm);
    _idController.removeListener(_validateForm);
    _phoneController.removeListener(_validateForm);
    _insuranceController.removeListener(_validateForm);
    _addressController.removeListener(_validateForm);
    _genderFocusNode.dispose();
    _jobFocusNode.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _nameController.text.isNotEmpty &&
          _dobController.text.isNotEmpty &&
          _idController.text.isNotEmpty &&
          _genderValue != null &&
          _jobValue != null &&
          _countryValue != null &&
          _ethnicValue != null &&
          _provinceValue != null &&
          _districtValue != null &&
          _wardValue != null &&
          _phoneController.text.isNotEmpty;
    });

    if (_isFormValid != _isFormValid) {
      // Chỉ setState khi có thay đổi
      setState(() {
        _isFormValid = _isFormValid;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
        _validateForm();
      });
    }
  }

  void _submitForm() {
    _validateForm();
    if (_isFormValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang xử lý hồ sơ...')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const AppbarWidget(title: 'Tạo mới hồ sơ'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildNoti(
              content:
                  'Vui lòng cung cấp thông tin chính xác để được phục vụ tốt nhất.',
            ),

            _buildFormSection('Thông tin chung', [
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
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: InputField(
                          controller: _dobController,
                          label: 'Ngày sinh',
                          hintText: 'Ngày / Tháng / Năm',
                          isRequired: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownField(
                      label: 'Giới tính',
                      value: _genderValue,
                      items: _genderOptions,
                      isRequired: true,
                      onChanged: (newValue) {
                        setState(() {
                          _genderValue = newValue;
                          _validateForm();
                        });
                      },
                      padding: const EdgeInsets.only(bottom: 8),
                      hintText: 'Giới tính',
                      focusNode: _genderFocusNode,
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
                items: _jobOptions,
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _jobValue = newValue;
                    _validateForm();
                  });
                },
                hintText: 'Chọn nghề nghiệp',
                focusNode: _genderFocusNode,
              ),

              _buildPhoneInputField(
                _phoneController,
                'Số điện thoại',
                '09xxxxxxxx',
              ),
            ]),

            _buildFormSection('Thông tin địa chỉ', [
              DropdownField(
                label: 'Quốc gia',
                value: _countryValue,
                items: _countryOptions,
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _countryValue = newValue;
                    _validateForm();
                  });
                },
                hintText: 'Việt Nam',
                focusNode: _genderFocusNode,
              ),

              DropdownField(
                label: 'Dân tộc',
                value: _ethnicValue,
                items: _ethnicOptions,
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _ethnicValue = newValue;
                    _validateForm();
                  });
                },
                hintText: 'Chọn Dân tộc',
                focusNode: _genderFocusNode,
              ),
            ]),

            _buildFormSection('Địa chỉ theo CCCD', [
              DropdownField(
                label: 'Tỉnh/TP',
                value: _provinceValue,
                items: _provinceOptions,
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _provinceValue = newValue;
                    // Reset dependent fields
                    _districtValue = null;
                    _wardValue = null;
                    _validateForm();
                  });
                },
                hintText: 'Chọn tỉnh thành',
                focusNode: _genderFocusNode,
              ),

              DropdownField(
                label: 'Quận/Huyện',
                value: _districtValue,
                items: _getDistrictsForProvince(_provinceValue),
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _districtValue = newValue;
                    // Reset dependent field
                    _wardValue = null;
                    _validateForm();
                  });
                },
                hintText: 'Chọn Quận/Huyện',
                focusNode: _genderFocusNode,
              ),

              DropdownField(
                label: 'Phường/Xã',
                value: _wardValue,
                items: _getWardsForDistrict(_districtValue),
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _wardValue = newValue;
                    _validateForm();
                  });
                },
                hintText: 'Chọn Phường/Xã',
                focusNode: _genderFocusNode,
              ),

              InputField(
                controller: _addressController,
                label: 'Số nhà/ Tên đường/ Ấp thôn xóm',
                hintText: 'Chỉ nhập số nhà, tên đường, ấp thôn xóm',
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: const Text(
                    'Tạo mới hồ sơ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildSectionTitle(title), ...children],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF007DAB),
        ),
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
              TextSpan(text: label, style: const TextStyle(fontSize: 16)),
              const TextSpan(
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
                    const Text('+84', style: TextStyle(fontSize: 16)),
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
                  onChanged: (value) => _validateForm(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper methods for location data
  List<String> _getDistrictsForProvince(String? province) {
    if (province == null) return ['Chọn Quận/Huyện'];

    // Return dummy data based on province
    switch (province) {
      case 'Hà Nội':
        return ['Ba Đình', 'Hoàn Kiếm', 'Đống Đa', 'Cầu Giấy'];
      case 'TP.HCM':
        return ['Quận 1', 'Quận 2', 'Quận 3', 'Tân Bình', 'Tân Phú'];
      default:
        return ['Chọn Quận/Huyện'];
    }
  }

  List<String> _getWardsForDistrict(String? district) {
    if (district == null) return ['Chọn Phường/Xã'];

    return ['Phường 1', 'Phường 2', 'Phường 3', 'Xã An Phú'];
  }
}
