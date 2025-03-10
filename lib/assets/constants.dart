class Constants {
  static Map<int, List<int>> sectionMap = {
    0:  [16], // inner
    1:  [17],
    2:  [18],
    3:  [19],
    4:  [20],
    5:  [21, 22, 23], // middle 
    6:  [24, 25, 26],
    7:  [27, 28, 29],
    8:  [30, 31, 32],
    9:  [33, 34, 35],
    10: [36, 37, 38, 39], // outer 
    11: [40, 41, 42, 43],
    12: [44, 45, 46, 47],
    13: [48, 49, 50, 51],
    14: [52, 53, 54, 55],
    15: [56, 57, 58, 59, 60], // top 
  };
  static int totalModules = 45;
  static int totalSections = 16;
  static List<int> allSections = List.generate(16, (i) => i);
  static List<int> allAddresses = List<int>.generate(45, (i) => i + 16);
  static double selectorWidth = 250;
  static double selectorHeight = 300;
  static double selectorHorizontalPadding = 90;
  static double selectorVerticalPadding = 30;
  static int debounceTimerDuration = 100;
<<<<<<< HEAD
<<<<<<< HEAD
  static int throttleTimerDuration = 200;
=======
>>>>>>> 17336a3 (Replace throttle behaviour with debounce for lights cubit bluetooth write)
=======
  static int throttleTimerDuration = 200;
>>>>>>> 7b7e337 (Fix incorrect function call in updateRgb, decouple debouce/throttle function)
}

