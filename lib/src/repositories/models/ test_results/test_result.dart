class TestResult {
  List<TestResultData> data;

  TestResult({this.data});

  TestResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TestResultData>();
      json['data'].forEach((v) {
        data.add(new TestResultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestResultData {
  String id;
  List<Profiles> profiles;
  AssigmentUnit assigmentUnit;
  String assignmentDate;
  String assigmentSource;
  AssigmentUnit takenUnit;
  String dateTaken;
  bool isGroup;
  String code;
  String examinationType;
  int sampleCount;
  String testTechnique;
  String feeType;
  String diseaseSample;
  String samplingPlace;
  AssigmentUnit executedUnit;
  String resultDate;
  String result;
  double cTE;
  Null cTN;
  Null cTRdRp;
  double orF1ab;
  String dateTesting;
  LastTransport lastTransport;
  int importantValue;
  String dateCreated;
  String dateUpdated;
  Null location;

  TestResultData(
      {this.id,
        this.profiles,
        this.assigmentUnit,
        this.assignmentDate,
        this.assigmentSource,
        this.takenUnit,
        this.dateTaken,
        this.isGroup,
        this.code,
        this.examinationType,
        this.sampleCount,
        this.testTechnique,
        this.feeType,
        this.diseaseSample,
        this.samplingPlace,
        this.executedUnit,
        this.resultDate,
        this.result,
        this.cTE,
        this.cTN,
        this.cTRdRp,
        this.orF1ab,
        this.dateTesting,
        this.lastTransport,
        this.importantValue,
        this.dateCreated,
        this.dateUpdated,
        this.location});

  TestResultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      profiles = new List<Profiles>();
      json['profiles'].forEach((v) {
        profiles.add(new Profiles.fromJson(v));
      });
    }
    assigmentUnit = json['assigmentUnit'] != null
        ? new AssigmentUnit.fromJson(json['assigmentUnit'])
        : null;
    assignmentDate = json['assignmentDate'];
    assigmentSource = json['assigmentSource'];
    takenUnit = json['takenUnit'] != null
        ? new AssigmentUnit.fromJson(json['takenUnit'])
        : null;
    dateTaken = json['dateTaken'];
    isGroup = json['isGroup'];
    code = json['code'];
    examinationType = json['examinationType'];
    sampleCount = json['sampleCount'];
    testTechnique = json['testTechnique'];
    feeType = json['feeType'];
    diseaseSample = json['diseaseSample'];
    samplingPlace = json['samplingPlace'];
    executedUnit = json['executedUnit'] != null
        ? new AssigmentUnit.fromJson(json['executedUnit'])
        : null;
    resultDate = json['resultDate'];
    result = json['result'];
    cTE = json['cT_E'];
    cTN = json['cT_N'];
    cTRdRp = json['cT_RdRp'];
    orF1ab = json['orF1ab'];
    dateTesting = json['dateTesting'];
    lastTransport = json['lastTransport'] != null
        ? new LastTransport.fromJson(json['lastTransport'])
        : null;
    importantValue = json['importantValue'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profiles != null) {
      data['profiles'] = this.profiles.map((v) => v.toJson()).toList();
    }
    if (this.assigmentUnit != null) {
      data['assigmentUnit'] = this.assigmentUnit.toJson();
    }
    data['assignmentDate'] = this.assignmentDate;
    data['assigmentSource'] = this.assigmentSource;
    if (this.takenUnit != null) {
      data['takenUnit'] = this.takenUnit.toJson();
    }
    data['dateTaken'] = this.dateTaken;
    data['isGroup'] = this.isGroup;
    data['code'] = this.code;
    data['examinationType'] = this.examinationType;
    data['sampleCount'] = this.sampleCount;
    data['testTechnique'] = this.testTechnique;
    data['feeType'] = this.feeType;
    data['diseaseSample'] = this.diseaseSample;
    data['samplingPlace'] = this.samplingPlace;
    if (this.executedUnit != null) {
      data['executedUnit'] = this.executedUnit.toJson();
    }
    data['resultDate'] = this.resultDate;
    data['result'] = this.result;
    data['cT_E'] = this.cTE;
    data['cT_N'] = this.cTN;
    data['cT_RdRp'] = this.cTRdRp;
    data['orF1ab'] = this.orF1ab;
    data['dateTesting'] = this.dateTesting;
    if (this.lastTransport != null) {
      data['lastTransport'] = this.lastTransport.toJson();
    }
    data['importantValue'] = this.importantValue;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['location'] = this.location;
    return data;
  }
}

class Profiles {
  int profileId;
  String name;
  int gender;
  String dateOfBirth;
  String phone;
  String cccd;
  String cmnd;
  String houseNumber;
  String province;
  String district;
  String ward;
  String quarter;
  String quarterGroup;
  String houseAddressCombination;
  String quarterGroupAddressCombination;
  String reason;
  Null relationObject;

  Profiles(
      {this.profileId,
        this.name,
        this.gender,
        this.dateOfBirth,
        this.phone,
        this.cccd,
        this.cmnd,
        this.houseNumber,
        this.province,
        this.district,
        this.ward,
        this.quarter,
        this.quarterGroup,
        this.houseAddressCombination,
        this.quarterGroupAddressCombination,
        this.reason,
        this.relationObject});

  Profiles.fromJson(Map<String, dynamic> json) {
    profileId = json['profileId'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    // cccd = json['cccd'];
    cmnd = json['cmnd'];
    houseNumber = json['houseNumber'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    quarter = json['quarter'];
    quarterGroup = json['quarterGroup'];
    houseAddressCombination = json['houseAddressCombination'];
    quarterGroupAddressCombination = json['quarterGroupAddressCombination'];
    reason = json['reason'];
    // relationObject = json['relationObject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = this.profileId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['phone'] = this.phone;
    data['cccd'] = this.cccd;
    data['cmnd'] = this.cmnd;
    data['houseNumber'] = this.houseNumber;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['quarter'] = this.quarter;
    data['quarterGroup'] = this.quarterGroup;
    data['houseAddressCombination'] = this.houseAddressCombination;
    data['quarterGroupAddressCombination'] =
        this.quarterGroupAddressCombination;
    data['reason'] = this.reason;
    data['relationObject'] = this.relationObject;
    return data;
  }
}

class AssigmentUnit {
  String id;
  String name;
  String samplingFunctionType;
  bool isCollector;
  bool isReceiver;
  bool isTester;
  String province;
  String district;
  String ward;
  UnitType unitType;

  AssigmentUnit(
      {this.id,
        this.name,
        this.samplingFunctionType,
        this.isCollector,
        this.isReceiver,
        this.isTester,
        this.province,
        this.district,
        this.ward,
        this.unitType});

  AssigmentUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    samplingFunctionType = json['samplingFunctionType'];
    isCollector = json['isCollector'];
    isReceiver = json['isReceiver'];
    isTester = json['isTester'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    unitType = json['unitType'] != null
        ? new UnitType.fromJson(json['unitType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['samplingFunctionType'] = this.samplingFunctionType;
    data['isCollector'] = this.isCollector;
    data['isReceiver'] = this.isReceiver;
    data['isTester'] = this.isTester;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    if (this.unitType != null) {
      data['unitType'] = this.unitType.toJson();
    }
    return data;
  }
}

class UnitType {
  String code;
  String name;

  UnitType({this.code, this.name});

  UnitType.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class LastTransport {
  FromUnit fromUnit;
  FromUnit toUnit;
  FromUnit receivedUnit;
  String createdTime;
  String sentDate;
  String receivedDate;

  LastTransport(
      {this.fromUnit,
        this.toUnit,
        this.receivedUnit,
        this.createdTime,
        this.sentDate,
        this.receivedDate});

  LastTransport.fromJson(Map<String, dynamic> json) {
    fromUnit = json['fromUnit'] != null
        ? new FromUnit.fromJson(json['fromUnit'])
        : null;
    toUnit =
    json['toUnit'] != null ? new FromUnit.fromJson(json['toUnit']) : null;
    receivedUnit = json['receivedUnit'] != null
        ? new FromUnit.fromJson(json['receivedUnit'])
        : null;
    createdTime = json['createdTime'];
    sentDate = json['sentDate'];
    receivedDate = json['receivedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fromUnit != null) {
      data['fromUnit'] = this.fromUnit.toJson();
    }
    if (this.toUnit != null) {
      data['toUnit'] = this.toUnit.toJson();
    }
    if (this.receivedUnit != null) {
      data['receivedUnit'] = this.receivedUnit.toJson();
    }
    data['createdTime'] = this.createdTime;
    data['sentDate'] = this.sentDate;
    data['receivedDate'] = this.receivedDate;
    return data;
  }
}

class FromUnit {
  String id;
  String name;
  String samplingFunctionType;
  bool isCollector;
  bool isReceiver;
  bool isTester;
  Null province;
  Null district;
  Null ward;
  Null unitType;

  FromUnit(
      {this.id,
        this.name,
        this.samplingFunctionType,
        this.isCollector,
        this.isReceiver,
        this.isTester,
        this.province,
        this.district,
        this.ward,
        this.unitType});

  FromUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    samplingFunctionType = json['samplingFunctionType'];
    isCollector = json['isCollector'];
    isReceiver = json['isReceiver'];
    isTester = json['isTester'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    unitType = json['unitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['samplingFunctionType'] = this.samplingFunctionType;
    data['isCollector'] = this.isCollector;
    data['isReceiver'] = this.isReceiver;
    data['isTester'] = this.isTester;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['unitType'] = this.unitType;
    return data;
  }
}