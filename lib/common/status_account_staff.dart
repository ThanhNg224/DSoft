import 'package:spa_project/base_project/package.dart';

class StatusAccountStaff {

  static int isActive = 1;
  static int isLock = 0;

  static String title(int? value) {
    switch (value) {
      case 1: return "Kích hoạt";
      case 0: default: return "Khóa"; 
    }
  }

  static Color color(int? value) {
    switch (value) {
      case 1: return MyColor.green;
      case 0: default: return MyColor.red;
    }
  }

  static IconData icon(int? value) {
    switch (value) {
      case 1: return Icons.lock_open;
      case 0: default: return Icons.lock;
    }
  }
}