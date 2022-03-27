class Ingredients {
  List<Ingredient>? ingredients;

  Ingredients({this.ingredients});

  Ingredients.fromJson(Map<String, dynamic> json) {
    if (json['ingredients'] != null) {
      ingredients = <Ingredient>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredient {
  String? name;
  String? image;
  Amount? amount;

  Ingredient({this.name, this.image, this.amount});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    amount =
        json['amount'] != null ? Amount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    return data;
  }
}

class Amount {
  Metric? metric;
  Metric? us;

  Amount({this.metric, this.us});

  Amount.fromJson(Map<String, dynamic> json) {
    metric =
        json['metric'] != null ? Metric.fromJson(json['metric']) : null;
    us = json['us'] != null ? Metric.fromJson(json['us']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (metric != null) {
      data['metric'] = metric!.toJson();
    }
    if (us != null) {
      data['us'] = us!.toJson();
    }
    return data;
  }
}

class Metric {
  double? value;
  String? unit;

  Metric({this.value, this.unit});

  Metric.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}