import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final String routeName;
  const NavigationButton({
    super.key,
    required this.label,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, routeName),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue, // สีพื้นหลังของปุ่ม
            foregroundColor: Colors.white, // สีของข้อความในปุ่ม
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // มุมโค้งมนของปุ่ม
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 24), // padding ภายในปุ่ม
            textStyle: const TextStyle(
              fontSize: 16, // ขนาดตัวอักษร
              fontWeight: FontWeight.bold, // หนักตัวอักษร
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
