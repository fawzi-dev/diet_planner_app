//This file will handle all our API calls to the
//Spoonacular API

import 'dart:convert';
import 'dart:io';
import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:diet_planner_app/models/ingredients.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  // ignore: constant_identifier_names
  static const String API_KEY = "f6164432bfbe4f06870dccfae9fe65bb";

  //We create async function to generate meal plan which takes in
  //timeFrame, targetCalories, diet and apiKey

  //If diet is none, we set the diet into an empty string

  //timeFrame parameter sets our meals into 3 meals, which are daily meals.
  //that's why it's set to day

  generateMealsPlans({required int targetCalories}) async {
    //check if diet is null
    Map<String, String> parameters = {
      'timeFrame': 'week', //to get 3 meals
      'targetCalories': targetCalories.toString(),
      'apiKey': API_KEY,
    };

    //The Uri consists of the base url, the endpoint we are going to use. It has also
    //parameters
    Uri uri = Uri.https(
      _baseURL,
      '/mealplanner/generate',
      parameters,
    );

    //Our header specifies that we want the request to return a json object
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map

      Map<String, dynamic> data = json.decode(response.body);
      //convert the map into a MealPlan Object using the factory constructor,
      //MealPlan.fromMap
      DailyPlans dailyPlans = DailyPlans.fromJson(data);
      return dailyPlans;
    } catch (err) {
      //If our response has error, we throw an error message
      
      throw err.toString();
    }
  }

  getIngridents({required int id}) async {
    

    String apiLink = 'https://api.spoonacular.com/recipes/$id/ingredientWidget.json?apiKey=f6164432bfbe4f06870dccfae9fe65bb';


    try {
      //http.get to retrieve the response
      var response = await http.get(Uri.parse(apiLink));
      //decode the body of the response into a map

      Map<String, dynamic> data = json.decode(response.body);
      //convert the map into a MealPlan Object using the factory constructor,
      //MealPlan.fromMap
      Ingredients ingredients = Ingredients.fromJson(data);
      return ingredients;
    } catch (err) {
      //If our response has error, we throw an error message
      debugPrint(err.toString());
      throw err.toString();
    }
  }

}
