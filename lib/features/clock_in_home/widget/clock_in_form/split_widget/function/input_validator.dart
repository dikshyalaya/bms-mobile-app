class InputValidator {
  static bool isValidInput({
    required String startTime,
    required String endTime,
    required String mealTime,
    required String noMealReasonId,
  }) {
    final bool startTimeNotEmpty = startTime.isNotEmpty;
    final bool endTimeEmpty = endTime.isEmpty;
    final bool mealTimeNotEmpty = mealTime.isNotEmpty;
    final bool noMealReasonNotEmpty = noMealReasonId.isNotEmpty;

    final bool case1 = startTimeNotEmpty &&
        endTimeEmpty &&
        mealTimeNotEmpty &&
        noMealReasonNotEmpty;
    final bool case2 = startTimeNotEmpty &&
        !endTimeEmpty &&
        mealTime == 'No Meal' &&
        !noMealReasonNotEmpty;
    final bool case3 = startTimeNotEmpty &&
        !endTimeEmpty &&
        mealTime != 'No Meal' &&
        noMealReasonNotEmpty;
    final bool case4 = startTimeNotEmpty &&
        endTimeEmpty &&
        mealTime != 'No Meal' &&
        !noMealReasonNotEmpty;
    final bool case5 = startTimeNotEmpty &&
        endTimeEmpty &&
        mealTime == 'No Meal' &&
        !noMealReasonNotEmpty;
    final bool case6 = startTimeNotEmpty &&
        !endTimeEmpty &&
        mealTimeNotEmpty &&
        noMealReasonNotEmpty;
    final bool case7 = startTimeNotEmpty &&
        endTimeEmpty &&
        mealTimeNotEmpty &&
        !noMealReasonNotEmpty;

    return case1 || case2 || case3 || case4 || case5 || case6 || case7;
  }
}
