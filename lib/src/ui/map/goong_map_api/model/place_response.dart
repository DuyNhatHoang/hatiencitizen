class PlaceResponse {
  List<Predictions> predictions;
  int executedTime;
  int executedTimeAll;
  String status;

  PlaceResponse(
      {this.predictions, this.executedTime, this.executedTimeAll, this.status});

  PlaceResponse.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = new List<Predictions>();
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }
    executedTime = json['executed_time'];
    executedTimeAll = json['executed_time_all'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predictions != null) {
      data['predictions'] = this.predictions.map((v) => v.toJson()).toList();
    }
    data['executed_time'] = this.executedTime;
    data['executed_time_all'] = this.executedTimeAll;
    data['status'] = this.status;
    return data;
  }
}

class Predictions {
  String description;
  List<Null> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Null> terms;
  bool hasChildren;
  String displayType;
  double score;
  PlusCode plusCode;

  Predictions(
      {this.description,
        this.matchedSubstrings,
        this.placeId,
        this.reference,
        this.structuredFormatting,
        this.terms,
        this.hasChildren,
        this.displayType,
        this.score,
        this.plusCode});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    // if (json['matched_substrings'] != null) {
    //   matchedSubstrings = new List<Null>();
    //   json['matched_substrings'].forEach((v) {
    //     matchedSubstrings.add(new Null.fromJson(v));
    //   });
    // }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? new StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    // if (json['terms'] != null) {
    //   terms = new List<Null>();
    //   json['terms'].forEach((v) {
    //     terms.add(new Null.fromJson(v));
    //   });
    // }
    hasChildren = json['has_children'];
    displayType = json['display_type'];
    score = json['score'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    // if (this.matchedSubstrings != null) {
    //   data['matched_substrings'] =
    //       this.matchedSubstrings.map((v) => v.toJson()).toList();
    // }
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    if (this.structuredFormatting != null) {
      data['structured_formatting'] = this.structuredFormatting.toJson();
    }
    // if (this.terms != null) {
    //   data['terms'] = this.terms.map((v) => v.toJson()).toList();
    // }
    data['has_children'] = this.hasChildren;
    data['display_type'] = this.displayType;
    data['score'] = this.score;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    return data;
  }
}

class StructuredFormatting {
  String mainText;
  String secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_text'] = this.mainText;
    data['secondary_text'] = this.secondaryText;
    return data;
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}