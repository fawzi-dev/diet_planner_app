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
}
