import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/models/booking.dart';
import 'package:medihub_app/presentation/screens/services/pay.dart';

class VaccineTermsScreen extends StatefulWidget {
  final bool isFromBookingScreen;
  final Booking booking;

  const VaccineTermsScreen({
    super.key,
    this.isFromBookingScreen = false,
    required this.booking,
  });

  @override
  State<VaccineTermsScreen> createState() => _VaccineTermsScreenState();
}

class _VaccineTermsScreenState extends State<VaccineTermsScreen> {
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Điều khoản dịch vụ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTitle('QUY ĐỊNH KHI ĐẶT GIỮ VẮC XIN'),
          SizedBox(height: 16),
          _buildTitle('ĐỊNH NGHĨA'),
          SizedBox(height: 8),
          _buildDefinitionItem(
            'Người mua: là người đại diện thực hiện đăng ký thông tin và thanh toán cho bản thân hoặc người thân của mình.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'VNVC sẽ liên hệ với người mua để xác nhận chi tiết thông tin về ngày giờ và địa điểm tiêm chủng dựa theo mã đăng ký khách hàng được cung cấp ngay sau khi hoàn tất đặt mua hoặc/và thanh toán. Mỗi đơn đặt giữ vắc xin sẽ nhận được một mã đăng ký.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Người mua phải là công dân Việt Nam hoặc người nước ngoài sinh sống hợp pháp tại Việt Nam trên 15 tuổi.',
          ),
          SizedBox(height: 12),
          _buildDefinitionItem(
            'Người tiêm: là người sẽ được tiêm loại vắc xin mà người mua đã đặt giữ nếu đạt đủ các tiêu chuẩn quy định về sức khỏe.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'VNVC chỉ thực hiện tiêm chủng cho người tiêm có thông tin cá nhân trùng khớp hoàn toàn với thông tin đã đặt giữ và có mối quan hệ theo quy định với người mua.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Nếu người tiêm dưới 14 tuổi, các thông tin về số điện thoại, email, địa chỉ, nghề nghiệp và đơn vị công tác của người tiêm là thông tin đăng ký của người giám hộ hợp pháp.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Tùy theo loại vắc xin đặt giữ, người tiêm cần trả lời một số câu hỏi sàng lọc trước khi hoàn tất đặt giữ vắc xin.',
          ),
          SizedBox(height: 24),
          _buildTitle('QUY ĐỊNH ĐĂNG KÝ'),
          SizedBox(height: 12),
          _buildBulletItem(
            'Một người mua được đăng ký với số lượng người tiêm không giới hạn.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Người tiêm chỉ được đặt giữ tối đa 3 loại "Vắc xin đặt giữ theo yêu cầu": mỗi khách hàng chỉ được đặt mua 1 mũi vắc xin cho mỗi loại và được đặt mua tối đa 3 loại vắc xin.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Mũi tiêm tiếp theo chỉ được đặt giữ 28 ngày sau khi đã hoàn tất mũi tiêm trước. Đối với các vắc xin đặc biệt thời gian quy định có thể dài hơn tùy theo phác đồ tiêm chủng.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Một người tiêm có thể đặt giữ không giới hạn số lượng gói vắc xin.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Tất cả đơn đặt giữ vắc xin đã thanh toán thành công cần có sự tư vấn và xác nhận của tổng đài chăm sóc khách hàng hoặc nhận được tin nhắn hẹn tiêm trước khi đến tiêm chủng tại Trung tâm tiêm chủng VNVC.',
          ),
          SizedBox(height: 24),
          _buildTitle('QUY ĐỊNH VỀ GIÁ VẮC XIN'),
          SizedBox(height: 8),
          _buildTermsNote(
            'Giá vắc xin bao gồm giá lẻ, giá gói và phí đặt giữ.',
          ),
          SizedBox(height: 24),
          _buildTitle('GIÁ GÓI'),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chúng tôi lựa chọn những vắc xin nhập khẩu từ nước ngoài của các hãng sản xuất uy tín, nổi tiếng thế giới và số ít các vắc xin được sản xuất tại Việt Nam đã được kiểm chứng về độ hiệu quả và an toàn. Toàn bộ vắc xin trong hệ thống phòng tiêm được bảo quản nghiêm ngặt theo khuyến cáo của Tổ chức Y tế Thế giới (WHO) và nhà sản xuất.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chúng tôi cam kết cung cấp đầy đủ vắc xin theo gói của Quý khách hàng đã lựa chọn, đảm bảo quyền lợi cho Quý khách hàng ngay cả khi tình trạng khan hiếm vắc xin có thể xảy ra. Khách hàng được giữ giá vắc xin đã mua theo thoả thuận trong suốt quá trình sử dụng gói.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Trường hợp có sự biến động lớn về giá nhập mua trên thị trường, giá gói vắc xin có thể thay đổi.',
          ),
          SizedBox(height: 24),
          _buildTitle('GIÁ VẮC XIN ĐẶT GIỮ'),
          SizedBox(height: 8),
          _buildRegularText(
            'Giá vắc xin đặt giữ theo yêu cầu = giá vắc xin + phí đặt giữ (được tính bằng 20% giá bán lẻ vắc xin đó tại thời điểm thanh toán). Phí này bao gồm:',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chi phí đảm bảo khách hàng được sử dụng vắc xin theo thời gian phù hợp với phác đồ và chỉ định của bác sĩ trong vòng 12 tháng kể từ ngày đăng ký dịch vụ.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chi phí lưu giữ, bảo quản vắc xin lên đến 12 tháng trong điều kiện bảo quản chuyên nghiệp của VNVC.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chi phí chống trượt giá: khách hàng không phải đóng thêm bất cứ chi phí nào ngay cả khi vắc xin tăng giá.',
          ),
          SizedBox(height: 12),
          _buildBulletItem(
            'Chi phí vận chuyển, luân chuyển vắc xin để đảm bảo khách hàng được phục vụ đúng thời gian yêu cầu.',
          ),
          SizedBox(height: 24),
          _buildTitle('QUY ĐỊNH CHUNG'),
          SizedBox(height: 8),
          _buildTermsNote(
            'Bảng giá được áp dụng từ ngày 20/01/2021 cho đến khi có thông báo mới. Giá vắc xin có thể thay đổi và sẽ được thông báo chính thức trên các kênh truyền thông của VNVC: website chính thức vnvc.vn, website đặt giữ vắc xin vax.vnvc.vn và gửi văn bản đến các đối tác đặt giữ vắc xin.',
          ),
          SizedBox(height: 12),
          _buildTermsNote('Giá đã bao gồm chi phí khám, tư vấn với bác sĩ.'),
          SizedBox(height: 32),
          if (widget.isFromBookingScreen) ...[
            _buildTermsAgreement(),
            SizedBox(height: 15),
            _buildSubmitButton(widget.booking),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDefinitionItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('- ', style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildRegularText(String text) {
    return Text(text, style: const TextStyle(fontSize: 16));
  }

  Widget _buildTermsNote(String text) {
    return Text('*** $text', style: const TextStyle(fontSize: 16));
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

  Widget _buildSubmitButton(Booking booking) {
    return PrimaryButton(
      text: 'XÁC NHẬN',
      borderRadius: 40,
      onPressed: () {
        if (termsAccepted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(booking: booking),
            ),
          );
        } else if (!termsAccepted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Vui lòng đồng ý với điều khoản để tiếp tục'),
            ),
          );
        }
      },
    );
  }
}
