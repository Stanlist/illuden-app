class Constants {
  static Map<int, List<int>> sectionMap = {
    // Old mapping
    // 0:  [16], // inner
    // 1:  [17],
    // 2:  [18],
    // 3:  [19],
    // 4:  [20],
    // 5:  [21, 22, 23], // middle 
    // 6:  [24, 25, 26],
    // 7:  [27, 28, 29],
    // 8:  [30, 31, 32],
    // 9:  [33, 34, 35],
    // 10: [36, 37, 38, 39], // outer 
    // 11: [40, 41, 42, 43],
    // 12: [44, 45, 46, 47],
    // 13: [48, 49, 50, 51],
    // 14: [52, 53, 54, 55],
    // 15: [56, 57, 58, 59, 60], // top 

    // Demo mapping
    0:  [0x20], // inner
    1:  [0x23],
    2:  [0x1A],
    3:  [0x1C],
    4:  [0x38],
    5:  [0x13, 0x16, 0x11, 0x18], // middle 
    6:  [0x1B, 0x1E, 0x3C],
    7:  [0x1D, 0x21],
    8:  [0x19, 0x15, 0x17],
    9:  [0x14, 0x1F, 0x2E],
    10: [0x10, 0x3A, 0x3B], // outer 
    11: [0x35, 0x24, 0x27],
    12: [0x34, 0x2D, 0x32],
    13: [0x2F, 0x30, 0x39],
    14: [0x37, 0x2B],
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
  static int throttleTimerDuration = 200;
}