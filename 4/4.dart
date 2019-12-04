bool check(num) {
  String s = num.toString();
  bool c = false;
  for (int i = 1; i < s.length; i++) {
    if (s[i - 1] == s[i]) {
      c = true;
    }
    if (int.parse(s[i - 1]) > int.parse(s[i])) {
      return false;
    }
  }
  return c;
}

RegExp dupeRegex = new RegExp('(\\d)\\1+');
bool check2(num) {
  String s = num.toString();
  bool c = false;
  for (int i = 1; i < s.length; i++) {
    for (var match in dupeRegex.allMatches(s)) {
      if (match.group(0).length == 2) {
        c = true;
      }
    }
    if (int.parse(s[i - 1]) > int.parse(s[i])) {
      return false;
    }
  }
  return c;
}

void main() {
  int tot1 = 0;
  int tot2 = 0;
  for (int i = 307237; i <= 769058; i++) {
    if (check(i)) {
      tot1 += 1;
    }
    if (check2(i)) {
      tot2 += 1;
    }
  }
  print('Answer to part 1: $tot1');
  print('Answer to part 2: $tot2');
}
