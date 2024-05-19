class InputValidator {
  static bool isValidInput({
    required String startTime,
    required String endTime,
    required String mealTime,
    required String noMealReason,
  }) {
    final bool startTimeNotEmpty = startTime.isNotEmpty;
    final bool endTimeEmpty = endTime.isEmpty;
    final bool mealTimeNotEmpty = mealTime.isNotEmpty;
    final bool noMealReasonNotEmpty = noMealReason.isNotEmpty;

final bool case1 = startTimeNotEmpty && endTimeEmpty && !mealTimeNotEmpty && !noMealReasonNotEmpty;
final bool case2 = startTimeNotEmpty && mealTime == 'No Meal' && noMealReasonNotEmpty && endTimeEmpty;
final bool case3 = startTimeNotEmpty && mealTime == 'No Meal' && noMealReasonNotEmpty && !endTimeEmpty;
final bool case4 = startTimeNotEmpty && mealTime != 'No Meal' && !noMealReasonNotEmpty && endTimeEmpty;
final bool case5 = startTimeNotEmpty && mealTime != 'No Meal' && mealTime != '' && !noMealReasonNotEmpty && !endTimeEmpty;

    return case1 || case2 || case3 || case4 || case5 ;
  }
}
