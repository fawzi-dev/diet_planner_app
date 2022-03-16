import 'package:flutter/cupertino.dart';

import '../models/IntroModel.dart';

class DataFile {
  static List<IntroModel> getIntroModel(BuildContext context) {
    List<IntroModel> introList = [];

    IntroModel mainModel = IntroModel();
    mainModel.id = 1;
    mainModel.name = "Welcome!";
    mainModel.image = "assets/images/img_1.0.png";
    mainModel.desc =
        "You don't need to worry about your diet plan anymore in this app you will be guided correctly to lose your weight.";
    introList.add(mainModel);

    mainModel = IntroModel();
    mainModel.id = 2;
    mainModel.name = "Meal planner";
    mainModel.image = "assets/images/img_2.0.png";
    mainModel.desc =
        "Generate diet plan with no time and get all the infomation you need.";
    introList.add(mainModel);

    mainModel = IntroModel();
    mainModel.id = 3;
    mainModel.name = "Health Manage";
    mainModel.image = "assets/images/img_3.0.png";
    mainModel.desc =
        "With us you don't need to know anything cause We prepred all types of meals for you to explore.";
    introList.add(mainModel);

    return introList;
  }

  static getMealList() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "Breakfast";
    model.image = "imoji_6.png";
    list.add(model);

    model = DietModel();
    model.title = "Snack";
    model.image = "imoji_7.png";
    list.add(model);

    model = DietModel();
    model.title = "Lunch";
    model.image = "imoji_8.png";
    list.add(model);

    model = DietModel();
    model.title = "Dinner";
    model.image = "imoji_9.png";
    list.add(model);

    return list;
  }

  static getDietList() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "Standard";
    model.subTitle = "I eat everything";
    model.image = "imoji_1.png";
    list.add(model);

    model = DietModel();
    model.title = "Vegetarian";
    model.subTitle = "I can't eat meat and seafood";
    model.image = "imoji_2.png";
    list.add(model);

    model = DietModel();
    model.title = "Vegan";
    model.image = "imoji_3.png";
    model.subTitle = "I can't eat animal Product";
    list.add(model);

    model = DietModel();
    model.title = "Pescatarian";
    model.subTitle = "Vegetarian plus seafood";
    model.image = "imoji_4.png";
    list.add(model);

    return list;
  }

  static getGender() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "Male";
    model.subTitle = "male.png";
    list.add(model);

    model = DietModel();
    model.title = "Female";
    model.subTitle = "female.png";
    list.add(model);

    return list;
  }

  static getMotivateList() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "Feeling confident";
    model.subTitle = "I want to be more confident in myself";
    model.image = "imoji_11.png";
    list.add(model);

    model = DietModel();
    model.title = "Being noticed";
    model.subTitle = "I want to be repected,appreciated and loved";
    model.image = "imoji_12.png";
    list.add(model);

    model = DietModel();
    model.title = "Being Active";
    model.image = "imoji_13.png";
    model.subTitle = "I want to feel energetic,fit and healthy";
    list.add(model);

    model = DietModel();
    model.title = "Gaining muscle";
    model.subTitle = "I want to be and look stronger";
    model.image = "imoji_14.png";
    list.add(model);

    return list;
  }

  static getVariedList() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "Low Variety";
    model.subTitle = "Meals frequently repeated";
    list.add(model);

    model = DietModel();
    model.title = "Medium Variety";
    model.subTitle = "Meals repeated from time to time";
    list.add(model);

    model = DietModel();
    model.title = "High Variety";
    model.subTitle = "Meals rarely repeated";
    list.add(model);

    return list;
  }
}
