// Student: Stevy MBAZOLOUMOUE
// Reg no: 23049
const String regNo = '23049';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int amount) {
  // by SM
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String formatRwf(int amount) {
  // by SM
  bool negative = amount < 0;
  String digits = (negative ? -amount : amount).toString();
  String result = '';
  int count = 0;
  int i = digits.length - 1;
  while (i >= 0) {
    if (count > 0 && count % 3 == 0) result = ',$result';
    result = digits[i] + result;
    count++;
    i--;
  }
  return '${negative ? '-' : ''}$result RWF';
}

bool isValidPin(String pin) {
  // by SM
  if (pin.length != 5) return false;
  bool allSame = true;
  int i = 0;
  while (i < pin.length) {
    int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) return false; // not a digit 0-9
    if (pin[i] != pin[0]) allSame = false;
    i++;
  }
  if (pin == '12345') return false;
  if (allSame) return false;
  return true;
}

int sendMoney(int balance, int amount) {
  // by SM
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

int buyAirtime(int balance, int amount) {
  // by SM
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be between 100 and 50,000 RWF');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Airtime bought: ${formatRwf(amount)}. '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by SM
  print('Reg no: $regNo | D = $d | T = $t');

  print(isValidPin('12345'));
  print(isValidPin('77777'));
  print(isValidPin('4821'));
  print(isValidPin('48a21'));
  print(isValidPin('4821$d'));

  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  int i = 0;
  while (i < 3) {
    balance = sendMoney(balance, (d + 1) * 3000);
    i++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);
  print('Final balance: ${formatRwf(balance)}');

  // My own tests (expected output in the comment)
  print(formatRwf(0)); // 0 RWF
  print(formatRwf(100000)); // 100,000 RWF  <- risky: leading comma?
  print(formatRwf(-1000)); // -1,000 RWF  <- risky: negative, multiple of 3 digits
  print(isValidPin('00000')); // false (same digit five times)
  print(isValidPin('01234')); // true (leading zero allowed)
  print(isValidPin('')); // false (empty string)
}
