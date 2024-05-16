import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
// import 'package:flutter/material.dart'; // Import required packages

class ClockInUtils {
  static String convertStringToMeal(String mealTime) {
    switch (mealTime) {
      case '30 Minutes':
        return '30';
      case '60 Minutes':
        return '60';
      case 'No Meal':
        return '0';
      default:
        return '';
    }
  }

  static String convertMealTimeToString(String mealTime) {
    switch (mealTime) {
      case '30':
        return '30 Minutes';
      case '60':
        return '60 Minutes';
      case '0':
        return 'No Meal';
      default:
        return '';
    }
  }

  static String getNameById(String id, List<NoMealResponseModel> itemList) {
    try {
      NoMealResponseModel item =
          itemList.firstWhere((element) => element.id == int.parse(id));
      return item.name;
    } catch (e) {
      return ''; // Return empty string if ID is not found or parsing fails
    }
  }

  static String getIdByName(String name, List<NoMealResponseModel> itemList) {
    // Find the item with the matching name
    try {
      NoMealResponseModel item =
          itemList.firstWhere((element) => element.name == name);
      return item.id.toString();
    } catch (e) {
      return '';
    }
  }
}
