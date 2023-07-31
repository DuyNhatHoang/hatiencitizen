import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Constants {
  //system
  static const String apiUrl = 'https://smarthatien.bakco.vn/api/';
  static const String url = 'https://smarthatien.bakco.vn/';
  static const int timeOut = 10000000;
  static const String expiredTokenMsg = "EXPIRED_TOKEN_MSG";
  static const String GOOGLE_MAP_API =
      "AIzaSyACvvPqM_Q11pYEh9jvVx4dgUhI3PkZTf0";

  static const ctnForm = 1;
  static const dsscForm = 2;

  // string
  static const String CTN = "Chờ tiếp nhận";
  static const String DSSC = "Công việc";
  static const String BCSC = "Tạo sự kiện";
  static const String TB = "Thông báo";
  static const String TK = "Tài khoản";

  static const int chuaXuLy = 0;
  static const int tiepnhan = 7;
  static const int dangXuLy = 1;
  static const int dangDiChuyen = 6;
  static const int daDenNoiXuLy = 2;
  static const int huyXuLy = 4;
  static const int ngoaiQuyTrinh = 5;
  static const int daXuLy = 3;
  static const int chuyen = 99;

  static const int suKienMoi = 1;
  static const int quaThoiGian = 2;
  static const int dangKiXuLy = 3;
  static const int capNhatThongTin = 4;
  static const int tuChoiNhan = 5;
  static const int moiXuLy = 6;
  static const int dieuPhoiXuLy = 7;
  static const int daXuLyEL = 8;
  static const int dahuy = 9;
  static const int chuyenXuLy = 10;
  static const int batDauXuLy = 1;
  static const int huyTiepNhan = 16;

  static const Map<int, String> statuses = {
    chuaXuLy: "Chờ tiếp nhận",
    dangXuLy: "Đang xử lý",
    dangDiChuyen: "Bắt đầu đi",
    daDenNoiXuLy: "Đã đế nơi xử lý",
    huyXuLy: "Hủy",
    ngoaiQuyTrinh: "Ngoài Quy Trình",
    daXuLy: "Đã hoàn thành",
    chuyen: "Chuyển",
    huyTiepNhan: "Hủy Tiếp Nhận",
    7 : "Chờ xử lý",
    10 : "Y/c hoàn thành",
  };

  static String getStatus(BuildContext context, int index){
    switch(index) {
      case chuaXuLy:
        return  AppLocalizations.of(context).waiting;
      case dangXuLy:
        return  AppLocalizations.of(context).processing;
        case dangDiChuyen:
        return  AppLocalizations.of(context).moving;
      case daDenNoiXuLy:
        return  AppLocalizations.of(context).arrived;
      case huyXuLy:
        return  AppLocalizations.of(context).cancel;
      case daXuLy:
        return  AppLocalizations.of(context).done;
      case huyTiepNhan:
        return  AppLocalizations.of(context).cancel;
      case 7:
        return  AppLocalizations.of(context).waiting;
      case 10:
        return  AppLocalizations.of(context).doneRequest;
      default:
        return "";
    }

  }

  static const Map<int, Color> statusColors = {
    chuaXuLy: kPrimaryColor,
    dangXuLy: Color(0xFFF3D057),
    daDenNoiXuLy: Colors.blueGrey,
    daXuLy: Colors.red,
    huyTiepNhan: Colors.red,
    huyXuLy: Colors.red,
    ngoaiQuyTrinh: Colors.grey,
    dangDiChuyen: kPrimaryColor,
    chuyen: Colors.cyan,
    7: Color(0xFFD454E8),
    10: Colors.green,
  };

  Color mainBlueColor = Color(0xff1874CD);
  //ui
  static const double verticleArea = 0.8;
  static const double horizontalArea = 0.8;
  static const double radiusButton = 15;

  static const double normalFontSize = 15;
  static const double mediumFontSize = 18;
  static const double smallFontSize = 12;
  static const double largeFontSize = 20;
  static const double homeFontSize = 28;

  static const double floatingActionMargin = 20;

  static const double widthOfMarker = 120.0;
  static const double heightOfMarker = 160.0;
}

class EventLogTypeID {
  static const int taoSuKien = 1;
  static const int tiepNhanSuKien = 2;
  static const int batDauXuLy = 3;
  static const int moiXuLy = 4;
  static const int huyTiepNhan = 5;
  static const int chuyenXuLy = 6;
  static const int capNhatSuKien = 7;
  static const int lapBienBan = 8;
  static const int batDauDiChuyen = 9;
  static const int dungDiChuyen = 10;
  static const int daTiepCanSuKien = 11;
  static const int chuyenNgoaiQuyTrinh = 12;
  static const int hoanTatXuLy = 13;
  static const int ycHoanTat = 18;
  static const int moiRaKhoiSuKien = 14;
  static const int huyXuLy = 15;
}
