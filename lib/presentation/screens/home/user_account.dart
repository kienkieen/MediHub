import 'package:flutter/material.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF007DAB), Color(0xD101ACCA)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Đinh Thị Thảo Ly',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Đăng xuất'),
                        SizedBox(width: 10),
                        Icon(Icons.logout_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 10),
                    child: sectionTitle("Điều khoản và quy định"),
                  ),
                  customTile(
                    Icons.verified_user,
                    Colors.cyan,
                    'Quy định sử dụng',
                  ),
                  Divider(height: 2),
                  customTile(Icons.lock, Colors.purple, 'Chính sách bảo mật'),
                  Divider(height: 2),
                  customTile(
                    Icons.description,
                    Colors.orange,
                    'Điều khoản dịch vụ',
                  ),
                ],
              ),
            ),

            customTile(
              Icons.phone,
              Colors.blue,
              'Tổng dài CSKH 19002115',
              top: 5,
              bottom: 5,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTile(
                    Icons.star,
                    Colors.yellow.shade800,
                    'Đánh giá ứng dụng',
                  ),
                  Divider(height: 2),
                  customTile(
                    Icons.share,
                    Colors.purpleAccent,
                    'Chia sẻ ứng dụng',
                  ),
                ],
              ),
            ),

            customTile(
              Icons.help_outline,
              Colors.red,
              'Một số câu hỏi thường gặp',
              top: 5,
              bottom: 5,
            ),
            customTile(
              Icons.g_translate_outlined,
              Colors.blue,
              'Ngôn ngữ',
              bottom: 5,
            ),
            customTile(
              Icons.logout_outlined,
              Colors.red,
              'Đăng xuất',
              bottom: 5,
            ),

            footer(),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget customTile(
    IconData icon,
    Color color,
    String title, {
    double? top,
    double? bottom,
  }) {
    return Container(
      padding:
          top != null || bottom != null
              ? EdgeInsets.symmetric(horizontal: 10)
              : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border(
          top:
              top != null
                  ? BorderSide(color: Colors.grey.shade300, width: top)
                  : BorderSide.none,
          bottom:
              bottom != null
                  ? BorderSide(color: Colors.grey.shade300, width: bottom)
                  : BorderSide.none,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget footer() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ: 140 Lê Trọng Tấn, quận Tân Phú, TP.HCM.',
                      style: TextStyle(fontSize: 14),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Website: https://??????.vn',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Số điện thoại: 0382431345',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Divider(color: Colors.grey),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10),
              Image.asset('assets/images/bocongthuong.webp', height: 40),
              SizedBox(height: 10),
              Image.asset('assets/images/dadangky.webp', height: 40),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
