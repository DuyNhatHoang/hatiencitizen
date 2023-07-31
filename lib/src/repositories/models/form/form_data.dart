import 'package:ha_tien_app/src/repositories/models/form/quyet_dinh_xu_phat_thong_tu_3.dart';

class FormEventData {
  BienBanViPhamHanhChinh03 bienBanViPhamHanhChinh03;
  QuyetDinhXuPhatThongTu03 quyetDinhXuPhatThongTu03;

  FormEventData({this.bienBanViPhamHanhChinh03, this.quyetDinhXuPhatThongTu03});

  FormEventData.fromJson(Map<String, dynamic> json) {
    bienBanViPhamHanhChinh03 = json['bienBanViPhamHanhChinh03'] != null
        ? new BienBanViPhamHanhChinh03.fromJson(
        json['bienBanViPhamHanhChinh03'])
        : null;

    quyetDinhXuPhatThongTu03 = json['qdXuPhatMauThongTu03'] != null
        ? new QuyetDinhXuPhatThongTu03.fromJson(
        json['qdXuPhatMauThongTu03'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bienBanViPhamHanhChinh03 != null) {
      data['bienBanViPhamHanhChinh03'] = this.bienBanViPhamHanhChinh03.toJson();
    }

    if (this.quyetDinhXuPhatThongTu03 != null) {
      data['qdXuPhatMauThongTu03'] = this.quyetDinhXuPhatThongTu03.toJson();
    }
    return data;
  }
}

class BienBanViPhamHanhChinh03 {
  String tieuDe;
  String gio;
  String phut;
  String ngayLap;
  String diaChiViPham;
  String canCu;
  List<DsCanBoThamGia> dsCanBoThamGia;
  List<DsNhanChung> dsNhanChung;
  DoiTuongViPham doiTuongViPham;
  String hanhViViPham;
  String quyDinhLuat;
  String doiTuongBiThietHai;
  String yKienNguoiViPham;
  String yKienNguoiChungKien;
  String yKienNguoiThietHai;
  String canBoNhanGiaiTrinh;
  int doneHour;
  int doneMinute;
  String doneDate;
  int soTo;
  int soLuongBienBan;
  String lyDoKhongKyBienBan;

  BienBanViPhamHanhChinh03(
      {this.tieuDe,
        this.gio,
        this.phut,
        this.ngayLap,
        this.diaChiViPham,
        this.canCu,
        this.dsCanBoThamGia,
        this.dsNhanChung,
        this.doiTuongViPham,
        this.hanhViViPham,
        this.quyDinhLuat,
        this.doiTuongBiThietHai,
        this.yKienNguoiViPham,
        this.yKienNguoiChungKien,
        this.yKienNguoiThietHai,
        this.canBoNhanGiaiTrinh,
        this.doneHour,
        this.doneMinute,
        this.doneDate,
        this.soTo,
        this.soLuongBienBan,
        this.lyDoKhongKyBienBan});

  BienBanViPhamHanhChinh03.fromJson(Map<String, dynamic> json) {
    tieuDe = json['tieuDe'];
    gio = json['gio'];
    phut = json['phut'];
    ngayLap = json['ngayLap'];
    diaChiViPham = json['diaChiViPham'];
    canCu = json['canCu'];
    if (json['dsCanBoThamGia'] != null) {
      dsCanBoThamGia = new List<DsCanBoThamGia>();
      json['dsCanBoThamGia'].forEach((v) {
        dsCanBoThamGia.add(new DsCanBoThamGia.fromJson(v));
      });
    }
    if (json['dsNhanChung'] != null) {
      dsNhanChung = new List<DsNhanChung>();
      json['dsNhanChung'].forEach((v) {
        dsNhanChung.add(new DsNhanChung.fromJson(v));
      });
    }
    doiTuongViPham = json['doiTuongViPham'] != null
        ? new DoiTuongViPham.fromJson(json['doiTuongViPham'])
        : null;
    hanhViViPham = json['hanhViViPham'];
    quyDinhLuat = json['quyDinhLuat'];
    doiTuongBiThietHai = json['doiTuongBiThietHai'];
    yKienNguoiViPham = json['yKienNguoiViPham'];
    yKienNguoiChungKien = json['yKienNguoiChungKien'];
    yKienNguoiThietHai = json['yKienNguoiThietHai'];
    canBoNhanGiaiTrinh = json['canBoNhanGiaiTrinh'];
    doneHour = json['doneHour'];
    doneMinute = json['doneMinute'];
    doneDate = json['doneDate'];
    soTo = json['soTo'];
    soLuongBienBan = json['soLuongBienBan'];
    lyDoKhongKyBienBan = json['lyDoKhongKyBienBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tieuDe'] = this.tieuDe;
    data['gio'] = this.gio;
    data['phut'] = this.phut;
    data['ngayLap'] = this.ngayLap;
    data['diaChiViPham'] = this.diaChiViPham;
    data['canCu'] = this.canCu;
    if (this.dsCanBoThamGia != null) {
      data['dsCanBoThamGia'] =
          this.dsCanBoThamGia.map((v) => v.toJson()).toList();
    }
    if (this.dsNhanChung != null) {
      data['dsNhanChung'] = this.dsNhanChung.map((v) => v.toJson()).toList();
    }
    if (this.doiTuongViPham != null) {
      data['doiTuongViPham'] = this.doiTuongViPham.toJson();
    }
    data['hanhViViPham'] = this.hanhViViPham;
    data['quyDinhLuat'] = this.quyDinhLuat;
    data['doiTuongBiThietHai'] = this.doiTuongBiThietHai;
    data['yKienNguoiViPham'] = this.yKienNguoiViPham;
    data['yKienNguoiChungKien'] = this.yKienNguoiChungKien;
    data['yKienNguoiThietHai'] = this.yKienNguoiThietHai;
    data['canBoNhanGiaiTrinh'] = this.canBoNhanGiaiTrinh;
    data['doneHour'] = this.doneHour;
    data['doneMinute'] = this.doneMinute;
    data['doneDate'] = this.doneDate;
    data['soTo'] = this.soTo;
    data['soLuongBienBan'] = this.soLuongBienBan;
    data['lyDoKhongKyBienBan'] = this.lyDoKhongKyBienBan;
    return data;
  }
}

class DsCanBoThamGia {
  String hoTen;
  String chucVu;
  String coQuan;

  DsCanBoThamGia({this.hoTen, this.chucVu, this.coQuan});

  DsCanBoThamGia.fromJson(Map<String, dynamic> json) {
    hoTen = json['hoTen'];
    chucVu = json['chucVu'];
    coQuan = json['coQuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoTen'] = this.hoTen;
    data['chucVu'] = this.chucVu;
    data['coQuan'] = this.coQuan;
    return data;
  }
}

class DsNhanChung {
  String id;
  String hoTen;
  String ngheNghiep;
  String diaChi;

  DsNhanChung({this.id, this.hoTen, this.ngheNghiep, this.diaChi});

  DsNhanChung.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hoTen = json['hoTen'];
    ngheNghiep = json['ngheNghiep'];
    diaChi = json['diaChi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hoTen'] = this.hoTen;
    data['ngheNghiep'] = this.ngheNghiep;
    data['diaChi'] = this.diaChi;
    return data;
  }
}

class DoiTuongViPham {
  String hoTen;
  String gioiTinh;
  String ngaySinh;
  String quocTich;
  String ngheNghiep;
  String diaChi;
  String cmnd;
  String ngayCapCMND;
  String noiCapCMND;
  String tenToChucViPham;
  String diaChiTruSoChinh;
  String maSoDoanhNghiep;
  String gcnOrGP;
  String ngayCapGCNOrGP;
  String noiCapGCNOrGP;
  String nguoiDaiDienPhapLuat;
  bool gioiTinhNguoiDaiDienPhapLuat;
  String chucDanhNguoiDaiDienPhapLuat;

  DoiTuongViPham(
      {this.hoTen,
        this.gioiTinh,
        this.ngaySinh,
        this.quocTich,
        this.ngheNghiep,
        this.diaChi,
        this.cmnd,
        this.ngayCapCMND,
        this.noiCapCMND,
        this.tenToChucViPham,
        this.diaChiTruSoChinh,
        this.maSoDoanhNghiep,
        this.gcnOrGP,
        this.ngayCapGCNOrGP,
        this.noiCapGCNOrGP,
        this.nguoiDaiDienPhapLuat,
        this.gioiTinhNguoiDaiDienPhapLuat,
        this.chucDanhNguoiDaiDienPhapLuat});

  DoiTuongViPham.fromJson(Map<String, dynamic> json) {
    hoTen = json['hoTen'];
    gioiTinh = json['gioiTinh'];
    ngaySinh = json['ngaySinh'];
    quocTich = json['quocTich'];
    ngheNghiep = json['ngheNghiep'];
    diaChi = json['diaChi'];
    cmnd = json['cmnd'];
    ngayCapCMND = json['ngayCapCMND'];
    noiCapCMND = json['noiCapCMND'];
    tenToChucViPham = json['tenToChucViPham'];
    diaChiTruSoChinh = json['diaChiTruSoChinh'];
    maSoDoanhNghiep = json['maSoDoanhNghiep'];
    gcnOrGP = json['gcnOrGP'];
    ngayCapGCNOrGP = json['ngayCapGCNOrGP'];
    noiCapGCNOrGP = json['noiCapGCNOrGP'];
    nguoiDaiDienPhapLuat = json['nguoiDaiDienPhapLuat'];
    gioiTinhNguoiDaiDienPhapLuat = json['gioiTinhNguoiDaiDienPhapLuat'];
    chucDanhNguoiDaiDienPhapLuat = json['chucDanhNguoiDaiDienPhapLuat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoTen'] = this.hoTen;
    data['gioiTinh'] = this.gioiTinh;
    data['ngaySinh'] = this.ngaySinh;
    data['quocTich'] = this.quocTich;
    data['ngheNghiep'] = this.ngheNghiep;
    data['diaChi'] = this.diaChi;
    data['cmnd'] = this.cmnd;
    data['ngayCapCMND'] = this.ngayCapCMND;
    data['noiCapCMND'] = this.noiCapCMND;
    data['tenToChucViPham'] = this.tenToChucViPham;
    data['diaChiTruSoChinh'] = this.diaChiTruSoChinh;
    data['maSoDoanhNghiep'] = this.maSoDoanhNghiep;
    data['gcnOrGP'] = this.gcnOrGP;
    data['ngayCapGCNOrGP'] = this.ngayCapGCNOrGP;
    data['noiCapGCNOrGP'] = this.noiCapGCNOrGP;
    data['nguoiDaiDienPhapLuat'] = this.nguoiDaiDienPhapLuat;
    data['gioiTinhNguoiDaiDienPhapLuat'] = this.gioiTinhNguoiDaiDienPhapLuat;
    data['chucDanhNguoiDaiDienPhapLuat'] = this.chucDanhNguoiDaiDienPhapLuat;
    return data;
  }
}