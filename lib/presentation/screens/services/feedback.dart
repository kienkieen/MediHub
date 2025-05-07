import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String? selectedCenter;
  int? satisfactionRating;
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

  String? referralSource;
  String? willContinueUsing;
  String? willRecommend;
  String additionalFeedback = '';
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Liên hệ & Góp ý', style: TextStyle(color: Colors.white),),
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCenterSelection(),
                  const SizedBox(height: 20),
                  const Text(
                    'THÔNG TIN KHÁCH HÀNG',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCustomerInfoFields(),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
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

  Widget _buildCenterSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Chọn trung tâm dự kiến tiêm ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            // Show center selection dialog or navigate to selection screen
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCenter ?? 'Chọn địa điểm tiêm',
                  style: TextStyle(
                    color: selectedCenter != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerInfoFields() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Họ và tên *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập họ tên';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Số điện thoại *',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            // Kiểm tra số điện thoại có đúng định dạng
            final phoneRegExp = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
            if (!phoneRegExp.hasMatch(value)) {
              return 'Số điện thoại không hợp lệ';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              // Kiểm tra email có đúng định dạng
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegExp.hasMatch(value)) {
                return 'Email không hợp lệ';
              }
            }
            return null; // Không có lỗi nếu trường trống
          },
        ),
      ],
    );
  }

  Widget _buildSatisfactionRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '1. Mức độ hài lòng của Quý khách với Trung tâm tiêm chủng VNVC? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  satisfactionRating = index + 1;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: satisfactionRating == index + 1
                        ? Colors.blue
                        : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: satisfactionRating == index + 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: satisfactionRating == index + 1
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
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
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '2. Quý khách vui lòng đánh giá mức độ hài lòng về các dịch vụ của Trung tâm tiêm chủng VNVC ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...serviceRatings.entries.map((entry) => _buildServiceRatingItem(entry.key)),
      ],
    );
  }

  Widget _buildServiceRatingItem(String serviceName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(serviceName),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  serviceRatings[serviceName] = index + 1;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: serviceRatings[serviceName] == index + 1
                        ? Colors.blue
                        : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: serviceRatings[serviceName] == index + 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: serviceRatings[serviceName] == index + 1
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Không hài lòng', style: TextStyle(fontSize: 12)),
            Text('Rất hài lòng', style: TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Viết ý kiến...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Giảm padding bên trong
          ),
          maxLines: 1,
          onChanged: (value) {
            serviceComments[serviceName] = value;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildReferralSource() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '3. Quý khách biết tới Trung tâm tiêm chủng VNVC qua? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...['Báo - Đài', 'Bạn bè hoặc Người thân giới thiệu', 'Internet, mạng xã hội (Facebook, Tiktok,...)', 'Bác sĩ', 'Khác']
            .map((source) => RadioListTile<String>(
                  title: Text(source),
                  value: source,
                  groupValue: referralSource,
                  onChanged: (String? value) {
                    setState(() {
                      referralSource = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ))
            .toList(),
      ],
    );
  }

  Widget _buildWillContinueUsing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '4. Quý khách sẽ tiếp tục sử dụng dịch vụ của Trung tâm tiêm chủng VNVC trong thời gian tới? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...['Có', 'Có thể', 'Không']
            .map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: willContinueUsing,
                  onChanged: (String? value) {
                    setState(() {
                      willContinueUsing = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ))
            .toList(),
      ],
    );
  }

  Widget _buildWillRecommend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '5. Quý khách có sẵn lòng giới thiệu Trung tâm tiêm chủng VNVC cho người thân/ bạn bè? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...['Có', 'Có thể', 'Không']
            .map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: willRecommend,
                  onChanged: (String? value) {
                    setState(() {
                      willRecommend = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ))
            .toList(),
      ],
    );
  }

  Widget _buildAdditionalFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('6. Quý khách vui lòng chia sẻ thêm ý kiến khác (Nếu có)'),
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
      color: Colors.blue[50],
      child: Row(
        children: [
          Checkbox(
            value: termsAccepted,
            onChanged: (bool? value) {
              setState(() {
                termsAccepted = value ?? false;
              });
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
                  const TextSpan(text: ' và chấp nhận cho VNVC sử dụng thông tin nhằm nâng cao chất lượng dịch vụ.'),
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
          if (_formKey.currentState!.validate() && termsAccepted) {
            // Submit the form
            _showSubmitSuccessDialog();
          } else if (!termsAccepted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Vui lòng đồng ý với điều khoản')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
        ),
        child: const Text('Gửi thông tin', style: TextStyle(color: Colors.white),),
      ),
    );
  }

  void _showSubmitSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}