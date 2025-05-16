import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double sectionSpacing = 18;
    const double paragraphSpacing = 10;
    const TextStyle paragraphStyle = TextStyle(fontSize: 15, height: 1.6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Chính sách quyền riêng tư', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'VNVC VÀ CHÍNH SÁCH QUYỀN RIÊNG TƯ'),

            const Text(
              'Trang web app.vnvc.vn và ứng dụng VNVC (sau đây được gọi chung là "VNVC app") được điều hành bởi Công ty Cổ phần Vacxin Việt Nam (sau đây gọi là "VNVC" / "Chúng Tôi"), giúp kết nối VNVC với khách hàng (sau đây gọi là "Khách Hàng" hoặc "Người Dùng") bằng cách ứng dụng các nền tảng công nghệ thông tin mới thông qua việc Khách Hàng sử dụng các dịch vụ do Chúng Tôi cung cấp ("Dịch Vụ"), với mong muốn mang lại tiện ích cho Người Dùng trong việc theo dõi, quản lý hồ sơ tiêm chủng, tương tác với chuyên gia, đặt mua các sản phẩm/dịch vụ của Chúng Tôi dễ dàng.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: sectionSpacing),

            // Section 1
            _buildSectionTitle('1. Nguyên tắc chung:'),
            const SizedBox(height: 4),
            const Text(
              '"Dữ Liệu Cá Nhân" của Người Dùng là bất kỳ thông tin, dữ liệu nào có thể được sử dụng để nhận dạng Người Dùng hoặc dựa vào đó mà Người Dùng được xác định, chẳng hạn như họ, chữ đệm và tên khai sinh, tên gọi khác; giới tính; nơi sinh, nơi đăng ký khai sinh, nơi thường trú, nơi tạm trú, nơi ở hiện tại, quê quán, địa chỉ liên hệ; quốc tịch; hình ảnh của cá nhân; số điện thoại, số chứng minh nhân dân, số định danh cá nhân, số hộ chiếu, số giấy phép lái xe, số biển số xe, số mã số thuế cá nhân, số bảo hiểm xã hội, số thẻ bảo hiểm y tế; tình trạng hôn nhân; thông tin về mối quan hệ gia đình (cha mẹ, con cái); thông tin về tài khoản số của cá nhân, dữ liệu cá nhân phản ánh hoạt động, lịch sử hoạt động trên không gian mạng và các thông tin khác gắn liền với Người Dùng cụ thể hoặc giúp xác định một Người Dùng cụ thể không thuộc dữ liệu cá nhân nhạy cảm.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: paragraphSpacing),
            const Text(
              'Ngoài ra, một số thông tin mang tính nhạy cảm như: quan điểm chính trị, quan điểm tôn giáo; tình trạng sức khỏe và đời tư được ghi trong hồ sơ bệnh án, không bao gồm thông tin về nhóm máu; thông tin liên quan đến nguồn gốc chủng tộc, nguồn gốc dân tộc; thông tin về đặc điểm di truyền được thừa hưởng hoặc có được của cá nhân; thông tin về thuộc tính vật lý, đặc điểm sinh hoạt riêng của cá nhân; thông tin về đời sống tình dục, xu hướng tình dục của cá nhân; dữ liệu về vị trí của cá nhân được xác định qua dịch vụ định vị và các Dữ Liệu Cá Nhân khác được pháp luật quy định là đặc thù và cần có biện pháp bảo mật cần thiết ("Dữ Liệu Cá Nhân Nhạy Cảm") có thể được Chúng Tôi Xử Lý khi cần thiết.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: sectionSpacing),

            // Section 2
            _buildSectionTitle('II. Mục đích thu thập Dữ Liệu Cá Nhân của Người Dùng:'),
            const SizedBox(height: 4),
            const Text(
              'Bằng cách, bấm chọn "Tôi đã đọc và đồng ý" ở phía dưới Chính sách này, đăng ký tài khoản tại VNVC app, sử dụng một hoặc nhiều Dịch Vụ, Người Dùng thừa nhận, đồng ý cung cấp Dữ Liệu Cá Nhân của Người Dùng cho Chúng Tôi và đồng ý cho phép Chúng Tôi sử dụng Dữ Liệu Cá Nhân của Người Dùng trong việc Xử Lý theo các quy định, thực tiễn áp dụng thuộc Chính Sách này với tất cả các mục đích như liệt kê dưới đây.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: paragraphSpacing),
            const Text(
              'Chúng Tôi thực hiện việc thu thập Dữ Liệu Cá Nhân của Người Dùng nhằm:',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: paragraphSpacing),
            _buildBulletPoint('Giới thiệu các hàng hóa và dịch vụ có thể phù hợp với các nhu cầu của Người Dùng.'),
            _buildBulletPoint('Cá nhân hóa luồng nội dung của Người Dùng trên VNVC app.'),
            _buildBulletPoint('Cung cấp những thông tin mới nhất của Chúng Tôi.'),
            _buildBulletPoint('Giải đáp thắc mắc của Người Dùng về cách chăm sóc sức khỏe, phòng ngừa & hỗ trợ cải thiện các vấn đề về sức khỏe, đăng ký tiêm chủng, khảo sát điều tra sau tiêm,...'),
            const SizedBox(height: sectionSpacing),

            // Section 3
            _buildSectionTitle('III. Phạm vi thu thập thông tin'),
            const SizedBox(height: 4),
            const Text(
              'Chúng Tôi thu thập Dữ Liệu Cá Nhân của Người Dùng khi:\n'
              '(i) Người Dùng thực hiện giao dịch, đăng ký mở tài khoản, đăng nhập, tương tác với Chúng Tôi trên tất cả các kênh tương tác,\n'
              '(ii) Người Dùng sử dụng các Dịch Vụ do Chúng Tôi cung cấp;\n'
              '(iii) Người Dùng tham gia các cuộc thi, trò chơi hoặc sự kiện do Chúng Tôi tổ chức,\n'
              '(iv) Người Dùng sử dụng chức năng sinh trắc học để nhận diện cá nhân, xác thực giao dịch,\n'
              '(v) Người Dùng tham gia thực hiện các khảo sát, điều tra,...',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: sectionSpacing),

            // Section 4 - Access Rights
            _buildSectionTitle('IV. Quyền truy cập'),
            const SizedBox(height: 4),
            const Text(
              'Để sử dụng và khai thác hiệu quả toàn bộ các tính năng của VNVC app, Người Dùng cần cho phép VNVC app có quyền truy cập và sử dụng những chức năng sau đây trên điện thoại/thiết bị di động của Người Dùng:',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: paragraphSpacing),
            _buildBulletPoint('Quyền truy cập vào Internet từ điện thoại/thiết bị di động.'),
            _buildBulletPoint('Quyền truy cập và sử dụng Camera trên điện thoại/thiết bị di động để chụp hình làm avatar cho hồ sơ của Người Dùng.'),
            _buildBulletPoint('Quyền truy cập và sử dụng bộ nhớ trên điện thoại/thiết bị di động để: tải về và lưu trữ các tập tin hình ảnh, tài liệu dạng pdf hồ sơ sức khoẻ của Người Dùng.'),
            _buildBulletPoint('Truy cập thư viện hình ảnh để tải lên hình ảnh làm avatar hồ sơ của Người Dùng hoặc gửi hình trong quá trình Người Dùng đăng ký sử dụng Dịch Vụ.'),
            _buildBulletPoint('Quyền truy cập vị trí Người Dùng sử dụng ứng dụng: để đề xuất, tìm kiếm được trung tâm gần Người Dùng nhất.'),
            const SizedBox(height: sectionSpacing),

            // Section 5 - Storage Duration
            _buildSectionTitle('V. Thời gian lưu trữ thông tin'),
            const SizedBox(height: 4),
            const Text(
              'Chúng Tôi sẽ lưu trữ Dữ Liệu Cá Nhân của Người Dùng cho đến khi Người Dùng có yêu cầu hủy bỏ hoặc Người Dùng tự đăng nhập và thực hiện hủy bỏ.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: sectionSpacing),

            // Section 6
            _buildSectionTitle('VI. Quyền của Khách Hàng đối với thông tin cá nhân:'),
            const SizedBox(height: 4),
            _buildBulletPoint('Khách Hàng có quyền cung cấp thông tin cá nhân cho Chúng Tôi và có thể thay đổi quyết định đó vào bất cứ lúc nào;'),
            _buildBulletPoint('Khách Hàng có quyền tự kiểm tra, cập nhật, điều chỉnh thông tin cá nhân của mình bằng cách đăng nhập vào tài khoản và chỉnh sửa thông tin cá nhân hoặc yêu cầu Chúng Tôi thực hiện việc này;'),
            _buildBulletPoint('Các quyền khác theo quy định của pháp luật.'),
            const SizedBox(height: sectionSpacing),

            // Section 8 - Contact Information
            _buildSectionTitle('VIII. Thông tin liên hệ:'),
            const SizedBox(height: 4),
            const Text(
              'Nếu Khách Hàng có câu hỏi hoặc bất kỳ thắc mắc nào về Chính Sách này, xin vui lòng liên hệ với Chúng Tôi bằng cách:',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: paragraphSpacing),
            const Text(
              'Gọi điện thoại đến hotline: 028 7102 6595',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: sectionSpacing),

            // Section 9 - Company Information
            _buildSectionTitle('IX. Đơn vị thu thập và quản lý thông tin:'),
            const SizedBox(height: 4),
            const Text(
              'CÔNG TY CỔ PHẦN VACXIN VIETNAM\n'
              'Thành lập và hoạt động theo Giấy chứng nhận đăng ký doanh nghiệp số: 0107631488 do Sở Kế hoạch và Đầu tư thành phố Hà Nội cấp, đăng ký lần đầu ngày 11 tháng 11 năm 2016.\n'
              'Trụ sở chính: Số 180 Trường Chinh, Phường Khương Thượng, Quận Đống Đa, Thành phố Hà Nội, Việt Nam.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: sectionSpacing),

            // Section 10 - Effective Date
            _buildSectionTitle('X. Hiệu lực'),
            const SizedBox(height: 4),
            const Text(
              'Chính Sách Dữ Liệu Cá Nhân này có hiệu lực từ ngày 02/06/2023.',
              textAlign: TextAlign.justify,
              style: paragraphStyle,
            ),
            const SizedBox(height: 28),

            // Agree button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Tôi đã đọc và đồng ý'),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  static Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ),
        ],
      ),
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