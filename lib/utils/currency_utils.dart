String getDecimalFormattedString(String value) {
  if (value == null) {
    return null;
  } else {
    String str1 = "";
    String str3 = "";

    if (value.contains(".")) {
      str1 = value.substring(0, value.indexOf("."));
    } else {
      str1 = value;
    }
    int i = 0;
    int j = -1 + str1.length;
    for (int k = j;; k--) {
      if (k < 0) {
        return str3;
      }
      if (i == 3) {
        str3 = '.' + str3;
        i = 0;
      }
      str3 = str1[k] + str3;
      i++;
    }
  }
}
