class DailyPlans {
  Week? week;

  DailyPlans({this.week});


  DailyPlans.fromJson(Map<String, dynamic> json) {
    week = json['week'] != null ? Week.fromJson(json['week']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (week != null) {
      data['week'] = week!.toJson();
    }
    return data;
  }
}

class Week {
  Day? monday;
  Day? tuesday;
  Day? wednesday;
  Day? thursday;
  Day? friday;
  Day? saturday;
  Day? sunday;

  Week(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Week.fromJson(Map<String, dynamic> json) {
    monday =  json['monday'] != null ? Day.fromJson(json['monday']) : null;
    tuesday = json['tuesday'] != null ? Day.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null ? Day.fromJson(json['wednesday']) : null;
    thursday = json['thursday'] != null ? Day.fromJson(json['thursday']) : null;
    friday = json['friday'] != null ? Day.fromJson(json['friday']) : null;
    saturday = json['saturday'] != null ? Day.fromJson(json['saturday']) : null;
    sunday = json['sunday'] != null ? Day.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monday != null) {
      data['monday'] = monday!.toJson();
    }
    if (tuesday != null) {
      data['tuesday'] = tuesday!.toJson();
    }
    if (wednesday != null) {
      data['wednesday'] = wednesday!.toJson();
    }
    if (thursday != null) {
      data['thursday'] = thursday!.toJson();
    }
    if (friday != null) {
      data['friday'] = friday!.toJson();
    }
    if (saturday != null) {
      data['saturday'] = saturday!.toJson();
    }
    if (sunday != null) {
      data['sunday'] = sunday!.toJson();
    }
    return data;
  }
}

class Day {
  List<Meals>? meals;
  Nutrients? nutrients;

  Day({this.meals, this.nutrients});

  Day.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
    nutrients = json['nutrients'] != null
        ? Nutrients.fromJson(json['nutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    if (nutrients != null) {
      data['nutrients'] = nutrients!.toJson();
    }
    return data;
  }
}

class Meals {
  int? id;
  String? imageType;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;

  Meals(
      {this.id,
      this.imageType,
      this.title,
      this.readyInMinutes,
      this.servings,
      this.sourceUrl});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageType = json['imageType'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageType'] = imageType;
    data['title'] = title;
    data['readyInMinutes'] = readyInMinutes;
    data['servings'] = servings;
    data['sourceUrl'] = sourceUrl;
    return data;
  }
}

class Nutrients {
  double? calories;
  double? protein;
  double? fat;
  double? carbohydrates;

  Nutrients({this.calories, this.protein, this.fat, this.carbohydrates});

  Nutrients.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    protein = json['protein'];
    fat = json['fat'];
    carbohydrates = json['carbohydrates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['protein'] = protein;
    data['fat'] = fat;
    data['carbohydrates'] = carbohydrates;
    return data;
  }
}