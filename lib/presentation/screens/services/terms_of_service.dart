
import 'package:flutter/material.dart';

class VaccineTermsScreen extends StatelessWidget {
  const VaccineTermsScreen({Key? key}) : super(key: key);

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
      body: const TermsContent(),
    );
  }
}

class TermsContent extends StatelessWidget {
  const TermsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        SectionTitle(title: 'QUY ĐỊNH KHI ĐẶT GIỮ VẮC XIN'),
        SizedBox(height: 16),
        SectionTitle(title: 'ĐỊNH NGHĨA'),
        SizedBox(height: 8),
        DefinitionItem(
          text: 'Người mua: là người đại diện thực hiện đăng ký thông tin và thanh toán cho bản thân hoặc người thân của mình.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'VNVC sẽ liên hệ với người mua để xác nhận chi tiết thông tin về ngày giờ và địa điểm tiêm chủng dựa theo mã đăng ký khách hàng được cung cấp ngay sau khi hoàn tất đặt mua hoặc/và thanh toán. Mỗi đơn đặt giữ vắc xin sẽ nhận được một mã đăng ký.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Người mua phải là công dân Việt Nam hoặc người nước ngoài sinh sống hợp pháp tại Việt Nam trên 15 tuổi.',
        ),
        SizedBox(height: 12),
        DefinitionItem(
          text: 'Người tiêm: là người sẽ được tiêm loại vắc xin mà người mua đã đặt giữ nếu đạt đủ các tiêu chuẩn quy định về sức khỏe.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'VNVC chỉ thực hiện tiêm chủng cho người tiêm có thông tin cá nhân trùng khớp hoàn toàn với thông tin đã đặt giữ và có mối quan hệ theo quy định với người mua.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Nếu người tiêm dưới 14 tuổi, các thông tin về số điện thoại, email, địa chỉ, nghề nghiệp và đơn vị công tác của người tiêm là thông tin đăng ký của người giám hộ hợp pháp.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Tùy theo loại vắc xin đặt giữ, người tiêm cần trả lời một số câu hỏi sàng lọc trước khi hoàn tất đặt giữ vắc xin.',
        ),
        SizedBox(height: 24),
        SectionTitle(title: 'QUY ĐỊNH ĐĂNG KÝ'),
        SizedBox(height: 12),
        BulletItem(
          text: 'Một người mua được đăng ký với số lượng người tiêm không giới hạn.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Người tiêm chỉ được đặt giữ tối đa 3 loại "Vắc xin đặt giữ theo yêu cầu": mỗi khách hàng chỉ được đặt mua 1 mũi vắc xin cho mỗi loại và được đặt mua tối đa 3 loại vắc xin.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Mũi tiêm tiếp theo chỉ được đặt giữ 28 ngày sau khi đã hoàn tất mũi tiêm trước. Đối với các vắc xin đặc biệt thời gian quy định có thể dài hơn tùy theo phác đồ tiêm chủng.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Một người tiêm có thể đặt giữ không giới hạn số lượng gói vắc xin.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Tất cả đơn đặt giữ vắc xin đã thanh toán thành công cần có sự tư vấn và xác nhận của tổng đài chăm sóc khách hàng hoặc nhận được tin nhắn hẹn tiêm trước khi đến tiêm chủng tại Trung tâm tiêm chủng VNVC.',
        ),
        SizedBox(height: 24),
        SectionTitle(title: 'QUY ĐỊNH VỀ GIÁ VẮC XIN'),
        SizedBox(height: 8),
        TermsNote(
          text: 'Giá vắc xin bao gồm giá lẻ, giá gói và phí đặt giữ.',
        ),
        SizedBox(height: 24),
        SectionTitle(title: 'GIÁ GÓI'),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chúng tôi lựa chọn những vắc xin nhập khẩu từ nước ngoài của các hãng sản xuất uy tín, nổi tiếng thế giới và số ít các vắc xin được sản xuất tại Việt Nam đã được kiểm chứng về độ hiệu quả và an toàn. Toàn bộ vắc xin trong hệ thống phòng tiêm được bảo quản nghiêm ngặt theo khuyến cáo của Tổ chức Y tế Thế giới (WHO) và nhà sản xuất.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chúng tôi cam kết cung cấp đầy đủ vắc xin theo gói của Quý khách hàng đã lựa chọn, đảm bảo quyền lợi cho Quý khách hàng ngay cả khi tình trạng khan hiếm vắc xin có thể xảy ra. Khách hàng được giữ giá vắc xin đã mua theo thoả thuận trong suốt quá trình sử dụng gói.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Trường hợp có sự biến động lớn về giá nhập mua trên thị trường, giá gói vắc xin có thể thay đổi.',
        ),
        SizedBox(height: 24),
        SectionTitle(title: 'GIÁ VẮC XIN ĐẶT GIỮ'),
        SizedBox(height: 8),
        RegularText(
          text: 'Giá vắc xin đặt giữ theo yêu cầu = giá vắc xin + phí đặt giữ (được tính bằng 20% giá bán lẻ vắc xin đó tại thời điểm thanh toán). Phí này bao gồm:',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chi phí đảm bảo khách hàng được sử dụng vắc xin theo thời gian phù hợp với phác đồ và chỉ định của bác sĩ trong vòng 12 tháng kể từ ngày đăng ký dịch vụ.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chi phí lưu giữ, bảo quản vắc xin lên đến 12 tháng trong điều kiện bảo quản chuyên nghiệp của VNVC.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chi phí chống trượt giá: khách hàng không phải đóng thêm bất cứ chi phí nào ngay cả khi vắc xin tăng giá.',
        ),
        SizedBox(height: 12),
        BulletItem(
          text: 'Chi phí vận chuyển, luân chuyển vắc xin để đảm bảo khách hàng được phục vụ đúng thời gian yêu cầu.',
        ),
        SizedBox(height: 24),
        SectionTitle(title: 'QUY ĐỊNH CHUNG'),
        SizedBox(height: 8),
        TermsNote(
          text: 'Bảng giá được áp dụng từ ngày 20/01/2021 cho đến khi có thông báo mới. Giá vắc xin có thể thay đổi và sẽ được thông báo chính thức trên các kênh truyền thông của VNVC: website chính thức vnvc.vn, website đặt giữ vắc xin vax.vnvc.vn và gửi văn bản đến các đối tác đặt giữ vắc xin.',
        ),
        SizedBox(height: 12),
        TermsNote(
          text: 'Giá đã bao gồm chi phí khám, tư vấn với bác sĩ.',
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DefinitionItem extends StatelessWidget {
  final String text;
  const DefinitionItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class BulletItem extends StatelessWidget {
  final String text;
  const BulletItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '- ',
          style: TextStyle(fontSize: 14),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class RegularText extends StatelessWidget {
  final String text;
  const RegularText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}

class TermsNote extends StatelessWidget {
  final String text;
  const TermsNote({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '*** $text',
      style: const TextStyle(fontSize: 16),
    );
  }
}