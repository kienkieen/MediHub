import 'package:flutter/material.dart';
import 'dart:math';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';
import 'package:medihub_app/presentation/screens/user_account/profile.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/models/feedback.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final FocusNode _focusNode = FocusNode();

  bool _isFormValid = false;

  final List<String> _facilityOptions = [
  'Bệnh viện Đa khoa Quốc tế Vinmec',
  'Bệnh viện Nhiệt đới Trung ương',
  'Trung tâm Y tế dự phòng Hà Nội',
  'Bệnh viện Bạch Mai',
  'VNVC Hoàng Văn Thụ',
  'VNVC Lê Đại Hành',
  'VNVC Nguyễn Xí',
  'VNVC Nguyễn Văn Cừ',
  'VNVC Nguyễn Hữu Thọ',
  'VNVC Tân Phú',
  'VNVC Kha Vạn Cân',
  'VNVC Huỳnh Tấn Phát',
  'VNVC Vĩnh Lộc B',
  'VNVC Thạnh Lộc',
  'VNVC Lê Văn Sỹ',
  'VNVC Gò Vấp',
  'VNVC Bình Thạnh',
  'VNVC Thủ Đức',
  'VNVC Quận 7',
  'VNVC Tân Bình',
  'VNVC Phú Nhuận',
  'VNVC Quận 3',
  'VNVC Quận 10',
  'VNVC Hóc Môn',
  'VNVC Bình Chánh',
  'VNVC Nhà Bè',
  'VNVC Củ Chi',
  'VNVC Quận 12',
  'VNVC Quận 9',
  'VNVC Quận 6',
  'VNVC Quận 5',
  'VNVC Quận 4',
  'VNVC Quận 1',
  'VNVC Tân Hưng',
  'VNVC Bình Tân',
  'VNVC Phạm Văn Chiêu',
  'VNVC Nguyễn Ảnh Thủ',
  'VNVC Lê Văn Việt',
  'VNVC Tô Ký',
  'VNVC Nguyễn Thiện Thuật',
  'VNVC Võ Văn Ngân',
  'VNVC Nguyễn Oanh',
  'VNVC Phan Văn Trị',
  'VNVC Nguyễn Trãi',
];

  Map<String, int> serviceRatings = {
    'Dịch vụ Lễ tân/ Chăm sóc Khách hàng': 0,
    'Dịch vụ Tư vấn vắc xin': 0,
    'Nội dung tư vấn gói vắc xin': 0,
    'Dịch vụ Khám sàng lọc': 0,
    'Dịch vụ Tiêm/ Uống vắc xin': 0,
    'Dịch vụ Kiểm tra sau tiêm': 0,
    'Bảo vệ, an ninh': 0,
    'Vệ sinh tại các khu vực': 0,
  };

  Map<String, String> serviceComments = {
    'Dịch vụ Lễ tân/ Chăm sóc Khách hàng': '',
    'Dịch vụ Tư vấn vắc xin': '',
    'Nội dung tư vấn gói vắc xin': '',
    'Dịch vụ Khám sàng lọc': '',
    'Dịch vụ Tiêm/ Uống vắc xin': '',
    'Dịch vụ Kiểm tra sau tiêm': '',
    'Bảo vệ, an ninh': '',
    'Vệ sinh tại các khu vực': '',
  };

  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _facilityValue;
  int satisfactionRating = 0;
  String? referralSource;
  String? willContinueUsing;
  String? willRecommend;
  String additionalFeedback = '';
  bool termsAccepted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userLogin == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(isNewLoginl: false),
          ),
        );
      }
    });
  }

  void updateFormValidity() {
    setState(() {
      _isFormValid =
          _facilityValue != null &&
          satisfactionRating > 0 &&
          referralSource != null &&
          willContinueUsing != null &&
          willRecommend != null &&
          termsAccepted &&
          serviceRatings.values.every((rating) => rating > 0);
    });
  }

  Future<void> submitFeedback() async {
    try {
      final feedback = FeedBack(
        id: generateRandomString(6),
        idUser: useMainLogin!.userId,
        facility: _facilityValue,
        satisfactionRating: satisfactionRating,
        referralSource: referralSource,
        willContinueUsing: willContinueUsing,
        willRecommend: willRecommend,
        additionalFeedback: additionalFeedback,
        serviceComments: Map.from(serviceComments),
        serviceRatings: Map.from(serviceRatings),
      );

      bool up = await insertData("GOPY", feedback.id, feedback.toMap());

      if (up) {
        _showSubmitSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi khi gửi phản hồi. Vui lòng thử lại'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Góp ý & Phản hồi', isBackButton: true),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildVNVCHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PHIẾU GÓP Ý',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DropdownField(
                    label: 'Chọn cơ sở',
                    value: _facilityValue,
                    items: _facilityOptions,
                    isRequired: true,
                    onChanged: (newValue) {
                      setState(() {
                        _facilityValue = newValue;
                        updateFormValidity();
                      });
                    },
                    hintText: 'Chọn cơ sở',
                    focusNode: _focusNode,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'THÔNG TIN KHÁCH HÀNG',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  useMainLogin != null
                      ? _buildCustomerInfoFields()
                      : Container(),
                  const SizedBox(height: 20),
                  _buildSatisfactionRating(),
                  const SizedBox(height: 20),
                  _buildServiceRatings(),
                  const SizedBox(height: 20),
                  _buildReferralSource(),
                  const SizedBox(height: 20),
                  _buildWillContinueUsing(),
                  const SizedBox(height: 20),
                  _buildWillRecommend(),
                  const SizedBox(height: 20),
                  _buildAdditionalFeedback(),
                  const SizedBox(height: 20),
                  _buildTermsAgreement(),
                  const SizedBox(height: 20),
                  _buildSubmitButton(),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Trân trọng cảm ơn những ý kiến đóng góp của quý khách',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVNVCHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Bo góc cho ảnh
        child: Image.asset(
          'assets/images/background-gioi-thieu-vnvc-desk.jpg', // Đường dẫn đến ảnh
          width: double.infinity, // Chiều rộng toàn bộ
          height: 160, // Chiều cao tùy chỉnh
          fit: BoxFit.cover, // Ảnh phủ toàn bộ khung
        ),
      ),
    );
  }

  Widget _buildCustomerInfoFields() {
    return Column(
      children: [
        InputField(
          label: 'Họ và tên',
          hintText: useMainLogin!.fullName,
          enable: false,
        ),
        const SizedBox(height: 16),
        InputField(
          label: 'Số điện thoại',
          hintText: useMainLogin!.phoneNumber,
          enable: false,
        ),

        const SizedBox(height: 16),
        InputField(
          label: 'Email',
          hintText: useMainLogin!.email,
          enable: false,
        ),
      ],
    );
  }

  Widget _buildSatisfactionRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '1. Mức độ hài lòng của quý khách với trung tâm tiêm chủng VNVC?',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    satisfactionRating = index + 1;
                  });
                  updateFormValidity();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          satisfactionRating == index + 1
                              ? Colors.blue
                              : Colors.grey[500]!,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight:
                            satisfactionRating == index + 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color:
                            satisfactionRating == index + 1
                                ? Colors.blue
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Không hài lòng', style: TextStyle(fontSize: 12)),
            Text('Rất hài lòng', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '2. Quý khách vui lòng đánh giá các dịch vụ của Trung tâm tiêm chủng VNVC',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...serviceRatings.entries.map(
          (entry) => _buildServiceRatingItem(entry.key),
        ),
      ],
    );
  }

  Widget _buildServiceRatingItem(String serviceName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(serviceName),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    serviceRatings[serviceName] = index + 1;
                  });
                  updateFormValidity();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          serviceRatings[serviceName] == index + 1
                              ? Colors.blue
                              : Colors.grey[500]!,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight:
                            serviceRatings[serviceName] == index + 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color:
                            serviceRatings[serviceName] == index + 1
                                ? Colors.blue
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Không hài lòng',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Rất hài lòng',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Viết ý kiến',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          maxLines: 1,
          onChanged: (value) {
            serviceComments[serviceName] = value;
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildReferralSource() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '3. Quý khách biết tiêm chủng VNVC qua?',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        ...[
          'Báo - Đài',
          'Bạn bè hoặc Người thân giới thiệu',
          'Internet, mạng xã hội (Facebook, Tiktok,...)',
          'Bác sĩ',
          'Khác',
        ].asMap().entries.map((entry) {
          final index = entry.key;
          final source = entry.value;
          return Column(
            children: [
              RadioListTile<String>(
                title: Text(
                  source,
                  style: const TextStyle(
                    fontSize: 14, // Chỉnh cỡ chữ
                    color: Color.fromARGB(195, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: source,
                groupValue: referralSource,
                onChanged: (String? value) {
                  setState(() {
                    referralSource = value;
                  });
                  updateFormValidity();
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Khoảng cách bên trong
                visualDensity: const VisualDensity(
                  horizontal: -2,
                  vertical: -4,
                ), // Giảm kích thước Radio
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Giảm vùng chạm
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildWillContinueUsing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '4. Quý khách có tiếp tục sử dụng dịch vụ của Trung tâm tiêm chủng VNVC trong thời gian tới không?',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...['Có', 'Có thể', 'Không']
            .map(
              (option) => RadioListTile<String>(
                title: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 14, // Chỉnh cỡ chữ
                    color: Color.fromARGB(195, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: option,
                groupValue: willContinueUsing,
                onChanged: (String? value) {
                  setState(() {
                    willContinueUsing = value;
                  });
                  updateFormValidity();
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Khoảng cách bên trong
                visualDensity: const VisualDensity(
                  horizontal: -2,
                  vertical: -4,
                ), // Giảm kích thước Radio
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Giảm vùng chạm
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildWillRecommend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '5. Quý khách có sẵn lòng giới thiệu dịch vụ của Trung tâm tiêm chủng VNVC cho bạn bè, người thân không?',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...['Có', 'Có thể', 'Không']
            .map(
              (option) => RadioListTile<String>(
                title: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 14, // Chỉnh cỡ chữ
                    color: Color.fromARGB(195, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: option,
                groupValue: willRecommend,
                onChanged: (String? value) {
                  setState(() {
                    willRecommend = value;
                  });
                  updateFormValidity();
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Khoảng cách bên trong
                visualDensity: const VisualDensity(
                  horizontal: -2,
                  vertical: -4,
                ), // Giảm kích thước Radio
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Giảm vùng chạm
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildAdditionalFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '6. Quý khách vui lòng chia sẻ thêm ý kiến khác (nếu có)',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Viết ý kiến...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
          onChanged: (value) {
            setState(() {
              additionalFeedback = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTermsAgreement() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[50],
      ),
      child: Row(
        children: [
          Checkbox(
            value: termsAccepted,
            onChanged: (bool? value) {
              setState(() {
                termsAccepted = value ?? false;
              });
              updateFormValidity();
            },
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Tôi đồng ý với các '),
                  TextSpan(
                    text: 'điều khoản',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                  const TextSpan(
                    text:
                        ' và chấp nhận cho VNVC sử dụng thông tin nhằm nâng cao chất lượng dịch vụ.',
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate() && _isFormValid) {
            // Submit the form
            submitFeedback();
          } else if (!termsAccepted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Vui lòng đồng ý với điều khoản')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
        ),
        child: const Text(
          'GỬI THÔNG TIN',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _showSubmitSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.blue, size: 28),
                SizedBox(width: 10),
                Text(
                  'Thành công',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            content: const Text(
              '🎉 Cảm ơn quý khách đã gửi ý kiến đóng góp. Chúng tôi sẽ xem xét trong thời gian sớm nhất!',
              style: TextStyle(fontSize: 16),
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const NavigationBottom(initialIndex: 0),
                    ),
                  );
                },
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }
}
