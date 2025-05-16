import 'package:flutter/material.dart';
// import 'package:medihub_app/presentation/screens/home/notification.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "MH",
                      style: TextStyle(
                        color: Color(0xFF0099CC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Flexible(
                  child: Text(
                    "VNVC xin chào bạn!",
                    style: TextStyle(
                      color: Color(0xFF004466),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const NotificationScreen(),
          //       ),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.white,
          //     shape: const CircleBorder(),
          //     padding: const EdgeInsets.all(8),
          //   ),
          //   child: SvgPicture.asset(
          //     'assets/icons/notification.svg',
          //     width: 24,
          //     height: 24,
          //   ),
          // ),
        ],
      ),
    );
  }
}
