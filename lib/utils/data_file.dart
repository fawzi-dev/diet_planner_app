import 'package:flutter/cupertino.dart';

import '../models/diet_model.dart';
import '../models/intro_model.dart';

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

  static increaseWeightGoal() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "0.5";
    list.add(model);

    model = DietModel();
    model.title = "1.0";
    list.add(model);

    model = DietModel();
    model.title = "1.5";
    list.add(model);

    model = DietModel();
    model.title = "2.0";
    list.add(model);

    return list;
  }

  static getUsersPreferences() {
    List<DietModel> list = [];

    DietModel model = DietModel();
    model.title = "I want to gain weight";
    list.add(model);

    model = DietModel();
    model.title = "I want to lose weight";
    list.add(model);

    return list;
  }
}
