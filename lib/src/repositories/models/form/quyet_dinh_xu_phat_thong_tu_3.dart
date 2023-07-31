class QuyetDinhXuPhatThongTu03 {
  QdXuPhatMauThongTu03 qdXuPhatMauThongTu03;

  QuyetDinhXuPhatThongTu03({this.qdXuPhatMauThongTu03});

  QuyetDinhXuPhatThongTu03.fromJson(Map<String, dynamic> json) {
    qdXuPhatMauThongTu03 = json['qdXuPhatMauThongTu03'] != null
        ? new QdXuPhatMauThongTu03.fromJson(json['qdXuPhatMauThongTu03'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.qdXuPhatMauThongTu03 != null) {
      data['qdXuPhatMauThongTu03'] = this.qdXuPhatMauThongTu03.toJson();
    }
    return data;
  }
}

class QdXuPhatMauThongTu03 {
  String soBienBan;
  String diaDiem;
  String ngayLap;
  String canCu;
  BieBanVPHC bieBanVPHC;
  BieBanVPHC bieBanGT;
  BieBanVPHC bienBanXacMinhChiTiet;
  BieBanVPHC qdGiaoQuyenXuPhat;
  String nguoiLap;
  String chucVu;
  DoiTuongViPham doiTuongViPham;
  String hangViViPham;
  String quyDinhTai;
  String tinhTietTangNang;
  String tinhTietGianNhe;
  String hinhThucXuPhat;
  String hinhThucXuPhatBoXung;
  String ngayHieuLuc;
  String finalReceiverName;
  String noiNopTien;
  String soTaiKhoan;
  String nganHang;
  int soNgay;
  String guiCho;
  String giaoCho;

  QdXuPhatMauThongTu03(
      {this.soBienBan,
        this.diaDiem,
        this.ngayLap,
        this.canCu,
        this.bieBanVPHC,
        this.bieBanGT,
        this.bienBanXacMinhChiTiet,
        this.qdGiaoQuyenXuPhat,
        this.nguoiLap,
        this.chucVu,
        this.doiTuongViPham,
        this.hangViViPham,
        this.quyDinhTai,
        this.tinhTietTangNang,
        this.tinhTietGianNhe,
        this.hinhThucXuPhat,
        this.hinhThucXuPhatBoXung,
        this.ngayHieuLuc,
        this.finalReceiverName,
        this.noiNopTien,
        this.soTaiKhoan,
        this.nganHang,
        this.soNgay,
        this.guiCho,
        this.giaoCho});

  QdXuPhatMauThongTu03.fromJson(Map<String, dynamic> json) {
    soBienBan = json['soBienBan'];
    diaDiem = json['diaDiem'];
    ngayLap = json['ngayLap'];
    canCu = json['canCu'];
    bieBanVPHC = json['bieBanVPHC'] != null
        ? new BieBanVPHC.fromJson(json['bieBanVPHC'])
        : null;
    bieBanGT = json['bieBanGT'] != null
        ? new BieBanVPHC.fromJson(json['bieBanGT'])
        : null;
    bienBanXacMinhChiTiet = json['bienBanXacMinhChiTiet'] != null
        ? new BieBanVPHC.fromJson(json['bienBanXacMinhChiTiet'])
        : null;
    qdGiaoQuyenXuPhat = json['qdGiaoQuyenXuPhat'] != null
        ? new BieBanVPHC.fromJson(json['qdGiaoQuyenXuPhat'])
        : null;
    nguoiLap = json['nguoiLap'];
    chucVu = json['chucVu'];
    doiTuongViPham = json['doiTuongViPham'] != null
        ? new DoiTuongViPham.fromJson(json['doiTuongViPham'])
        : null;
    hangViViPham = json['hangViViPham'];
    quyDinhTai = json['quyDinhTai'];
    tinhTietTangNang = json['tinhTietTangNang'];
    tinhTietGianNhe = json['tinhTietGianNhe'];
    hinhThucXuPhat = json['hinhThucXuPhat'];
    hinhThucXuPhatBoXung = json['hinhThucXuPhatBoXung'];
    ngayHieuLuc = json['ngayHieuLuc'];
    finalReceiverName = json['finalReceiverName'];
    noiNopTien = json['noiNopTien'];
    soTaiKhoan = json['soTaiKhoan'];
    nganHang = json['nganHang'];
    soNgay = json['soNgay'];
    guiCho = json['guiCho'];
    giaoCho = json['giaoCho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soBienBan'] = this.soBienBan;
    data['diaDiem'] = this.diaDiem;
    data['ngayLap'] = this.ngayLap;
    data['canCu'] = this.canCu;
    if (this.bieBanVPHC != null) {
      data['bieBanVPHC'] = this.bieBanVPHC.toJson();
    }
    if (this.bieBanGT != null) {
      data['bieBanGT'] = this.bieBanGT.toJson();
    }
    if (this.bienBanXacMinhChiTiet != null) {
      data['bienBanXacMinhChiTiet'] = this.bienBanXacMinhChiTiet.toJson();
    }
    if (this.qdGiaoQuyenXuPhat != null) {
      data['qdGiaoQuyenXuPhat'] = this.qdGiaoQuyenXuPhat.toJson();
    }
    data['nguoiLap'] = this.nguoiLap;
    data['chucVu'] = this.chucVu;
    if (this.doiTuongViPham != null) {
      data['doiTuongViPham'] = this.doiTuongViPham.toJson();
    }
    data['hangViViPham'] = this.hangViViPham;
    data['quyDinhTai'] = this.quyDinhTai;
    data['tinhTietTangNang'] = this.tinhTietTangNang;
    data['tinhTietGianNhe'] = this.tinhTietGianNhe;
    data['hinhThucXuPhat'] = this.hinhThucXuPhat;
    data['hinhThucXuPhatBoXung'] = this.hinhThucXuPhatBoXung;
    data['ngayHieuLuc'] = this.ngayHieuLuc;
    data['finalReceiverName'] = this.finalReceiverName;
    data['noiNopTien'] = this.noiNopTien;
    data['soTaiKhoan'] = this.soTaiKhoan;
    data['nganHang'] = this.nganHang;
    data['soNgay'] = this.soNgay;
    data['guiCho'] = this.guiCho;
    data['giaoCho'] = this.giaoCho;
    return data;
  }
}

class BieBanVPHC {
  String soBienBan;
  String ngayLap;

  BieBanVPHC({this.soBienBan, this.ngayLap});

  BieBanVPHC.fromJson(Map<String, dynamic> json) {
    soBienBan = json['soBienBan'];
    ngayLap = json['ngayLap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soBienBan'] = this.soBienBan;
    data['ngayLap'] = this.ngayLap;
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