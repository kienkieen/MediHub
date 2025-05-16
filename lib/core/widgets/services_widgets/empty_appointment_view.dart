import 'package:flutter/material.dart';

class EmptyAppointmentView extends StatelessWidget {
  const EmptyAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/icons/empty_appointment.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Quý khách chưa có lịch hẹn',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E4053),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Tạo đặt hẹn để tiết kiệm thời gian khi đến tiêm chủng tại VNVC',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF7F8C8D),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
