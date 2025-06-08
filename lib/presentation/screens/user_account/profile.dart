import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/button2.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/noti.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

class ProfileScreen extends StatefulWidget {
  final bool isNewUser;
  const ProfileScreen({super.key, required this.isNewUser});

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  // Controllers
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _idController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  //FocusNode
  final FocusNode _focusNode = FocusNode();

  // Dropdown values
  String? _genderValue;
  String? _jobValue;
  String? _countryValue;
  String? _ethnicValue;
  String? _provinceValue;
  String? _districtValue;

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
    'Khác',
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
  bool firstTime = true;

  bool checkNull() {
    if (useMainLogin?.numberBHYT.isEmpty == true ||
        useMainLogin?.numberBHYT == null ||
        useMainLogin?.idCardNumber.isEmpty == true ||
        useMainLogin?.idCardNumber == null ||
        useMainLogin?.phoneNumber.isEmpty == true ||
        useMainLogin?.phoneNumber == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _dobController.addListener(_validateForm);
    _idController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _insuranceController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    if (checkNull()) {
      firstTime = false;
    }
    // Set defaults
    _countryValue = 'Việt Nam';
    setUpdataUser();
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _dobController.removeListener(_validateForm);
    _idController.removeListener(_validateForm);
    _phoneController.removeListener(_validateForm);
    _insuranceController.removeListener(_validateForm);
    _addressController.removeListener(_validateForm);
    _focusNode.dispose();
    super.dispose();
  }

  void setUpdataUser() {
    if (useMainLogin != null) {
      DateFormat format = DateFormat('dd/MM/yyyy');
      String formattedDate = DateFormat(
        'dd/MM/yyyy',
      ).format(useMainLogin!.dateOfBirth);
      _nameController.text = useMainLogin!.fullName;
      _dobController.text = formattedDate;
      _genderValue = useMainLogin!.gender;
      _idController.text = useMainLogin!.idCardNumber;
      _insuranceController.text = useMainLogin!.numberBHYT;
      _phoneController.text = useMainLogin!.phoneNumber;
      _addressController.text = useMainLogin!.address;
      _countryValue = useMainLogin!.nationality;
      _ethnicValue = useMainLogin!.ethnicity;
      _provinceValue = useMainLogin!.city;
      _districtValue = useMainLogin!.district;
      _jobValue = useMainLogin!.job;
    }
  }

  void _validateForm() {
    bool tmp = false;
    setState(() {
      tmp =
          _nameController.text.isNotEmpty &&
          _dobController.text.isNotEmpty &&
          _idController.text.isNotEmpty &&
          _genderValue != null &&
          _jobValue != null &&
          _countryValue != null &&
          _ethnicValue != null &&
          _provinceValue != null &&
          _districtValue != null &&
          _phoneController.text.isNotEmpty;
    });

    if (_isFormValid != tmp) {
      // Chỉ setState khi có thay đổi
      setState(() {
        _isFormValid = tmp;
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

  Future<void> _submitForm() async {
    _validateForm();
    if (!checkLengthNumber()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text(
              'Vui lòng nhập đúng định dạng số điện thoại, CCCD và BHYT',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return;
    } else if (_isFormValid) {
      DateFormat format = DateFormat('dd/M/yyyy');
      useMainLogin?.fullName = _nameController.text;
      useMainLogin?.dateOfBirth = format.parse(_dobController.text);
      useMainLogin?.gender = _genderValue!;
      useMainLogin?.idCardNumber = _idController.text;
      useMainLogin?.numberBHYT = _insuranceController.text;
      useMainLogin?.job = _jobValue.toString();
      useMainLogin?.phoneNumber = _phoneController.text;
      useMainLogin?.nationality = _countryValue.toString();
      useMainLogin?.ethnicity = _ethnicValue.toString();
      useMainLogin?.city = _provinceValue.toString();
      useMainLogin?.district = _districtValue.toString();
      useMainLogin?.address = _addressController.text;
      bool up = await updateData(
        "THONGTIN_NGUOIDUNG",
        useMainLogin!.userId.toString(),
        useMainLogin!.toMap(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang cập nhập...')));
      if (up) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cập nhập thành công')));
        if (firstTime) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationBottom(initialIndex: 0),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: const Text(
                  'Cập nhập thành công! Bạn có muốn về trang chủ không?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng dialog
                    },
                    child: const Text('Không'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => NavigationBottom(initialIndex: 0),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
          ),
        );
      }
    }
  }

  bool checkLengthNumber() {
    if (_phoneController.text.length != 10) {
      return false;
    }
    if (_idController.text.length != 12) {
      return false;
    }
    if (_insuranceController.text.length != 10) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        isBackButton: widget.isNewUser ? false : true,
        title: 'Thông tin tài khoản',
      ),
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
                      focusNode: _focusNode,
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
                focusNode: _focusNode,
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
                focusNode: _focusNode,
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
                focusNode: _focusNode,
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
                    _validateForm();
                  });
                },
                hintText: 'Chọn tỉnh thành',
                focusNode: _focusNode,
              ),

              DropdownField(
                label: 'Quận/Huyện',
                value: _districtValue,
                items: _getDistrictsForProvince(_provinceValue),
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _districtValue = newValue;
                    _validateForm();
                  });
                },
                hintText: 'Chọn Quận/Huyện',
                focusNode: _focusNode,
              ),

              InputField(
                controller: _addressController,
                label: 'Số nhà/ Tên đường/ Xã phường',
                hintText: 'Chỉ nhập số nhà, tên đường, xã phường',
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
                    'Cập nhật hồ sơ',
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
            color: Colors.grey.withValues(alpha: 0.4),
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
            border: Border.all(color: Colors.grey.shade400, width: 1),
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
                    right: BorderSide(color: Colors.grey.shade400),
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

    // Return districts based on province
    switch (province) {
      case 'Hà Nội':
        return [
          'Ba Đình',
          'Hoàn Kiếm',
          'Đống Đa',
          'Cầu Giấy',
          'Tây Hồ',
          'Hà Đông',
          'Nam Từ Liêm',
          'Bắc Từ Liêm',
          'Thanh Xuân',
          'Khác',
        ];
      case 'Hải Phòng':
        return [
          'Hồng Bàng',
          'Ngô Quyền',
          'Lê Chân',
          'Hải An',
          'Kiến An',
          'Đồ Sơn',
          'Khác',
        ];
      case 'Quảng Ninh':
        return ['Hạ Long', 'Hải Hà', 'Cẩm Phả', 'Uông Bí', 'Khác'];
      case 'Bắc Ninh':
        return ['Thành phố Bắc Ninh', 'Yên Phong', 'Tiên Du', 'Khác'];
      case 'Hải Dương':
        return ['Thành phố Hải Dương', 'Chí Linh', 'Kinh Môn', 'Khác'];
      case 'Hưng Yên':
        return ['Thành phố Hưng Yên', 'Văn Lâm', 'Mỹ Hào', 'Khác'];
      case 'Thái Bình':
        return ['Thành phố Thái Bình', 'Hưng Hà', 'Tiền Hải', 'Khác'];
      case 'Nam Định':
        return ['Thành phố Nam Định', 'Mỹ Lộc', 'Vụ Bản', 'Khác'];
      case 'Ninh Bình':
        return ['Thành phố Ninh Bình', 'Tam Điệp', 'Yên Khánh', 'Khác'];
      case 'Đà Nẵng':
        return [
          'Hải Châu',
          'Thanh Khê',
          'Sơn Trà',
          'Ngũ Hành Sơn',
          'Liên Chiểu',
          'Khác',
        ];
      case 'Thừa Thiên Huế':
        return ['Thành phố Huế', 'Hương Thủy', 'Phú Vang', 'Khác'];
      case 'Quảng Nam':
        return ['Thành phố Hội An', 'Thành phố Tam Kỳ', 'Điện Bàn', 'Khác'];
      case 'Quảng Ngãi':
        return ['Thành phố Quảng Ngãi', 'Bình Sơn', 'Sơn Tịnh', 'Khác'];
      case 'Bình Định':
        return ['Thành phố Quy Nhơn', 'An Lão', 'Tuy Phước', 'Khác'];
      case 'Khánh Hòa':
        return ['Thành phố Nha Trang', 'Cam Ranh', 'Diên Khánh', 'Khác'];
      case 'Phú Yên':
        return ['Thành phố Tuy Hòa', 'Sông Cầu', 'Đồng Xuân', 'Khác'];
      case 'TP.HCM':
        return [
          'Quận 1',
          'Quận 2',
          'Quận 3',
          'Quận 4',
          'Quận 5',
          'Quận 6',
          'Quận 7',
          'Quận 8',
          'Quận 9',
          'Quận 10',
          'Quận 11',
          'Quận 12',
          'Tân Bình',
          'Tân Phú',
          'Bình Thạnh',
          'Gò Vấp',
          'Phú Nhuận',
          'Thủ Đức',
          'Bình Tân',
          'Khác',
        ];
      case 'Cần Thơ':
        return ['Ninh Kiều', 'Bình Thủy', 'Cái Răng', 'Thốt Nốt', 'Khác'];
      case 'Bình Dương':
        return [
          'Thành phố Thủ Dầu Một',
          'Bình Dương',
          'Dĩ An',
          'Thuận An',
          'Khác',
        ];
      case 'Đồng Nai':
        return ['Thành phố Biên Hòa', 'Long Thành', 'Nhơn Trạch', 'Khác'];
      case 'Bà Rịa - Vũng Tàu':
        return ['Thành phố Vũng Tàu', 'Bà Rịa', 'Long Điền', 'Khác'];
      case 'Long An':
        return ['Thành phố Tân An', 'Cần Giuộc', 'Bến Lức', 'Khác'];
      case 'Tiền Giang':
        return ['Thành phố Mỹ Tho', 'Cai Lậy', 'Châu Thành', 'Khác'];
      case 'An Giang':
        return ['Thành phố Long Xuyên', 'Châu Đốc', 'Tri Tôn', 'Khác'];
      case 'Khác':
        return ['Chọn Quận/Huyện', 'Khác'];
      default:
        return ['Chọn Quận/Huyện', 'Khác'];
    }
  }
}
