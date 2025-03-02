const Map<int, List<int>> sectionMap = {
  0:  [16],
  1:  [17],
  2:  [18],
  3:  [19],
  4:  [20],
  5:  [21, 22, 23], // middle ring
  6:  [24, 25, 26],
  7:  [27, 28, 29],
  8:  [30, 31, 32],
  9:  [33, 34, 35],
  10: [36, 37, 38, 39], // Outer ring
  11: [40, 41, 42, 43],
  12: [44, 45, 46, 47],
  13: [48, 49, 50, 51],
  14: [52, 53, 54, 55],
  16: [56, 57, 58, 59, 60], // Center
};

// List<String> convertToHex(List<int> values) {
//   return values.map((num) => '0x${num.toRadixString(16).toUpperCase()}').toList();
// }