// Student: Stevy MBAZOLOUMOUE
// Reg no: 23049
const String regNo = '23049';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int value) {
  if (value <= 0) return -1;
  if (value <= 1000) return 20;
  if (value <= 10000) return 100;
  if (value <= 150000) return 250;
  return 1500;
}

String formatRwf(int val) {
  var isNeg = val < 0;
  var rawDigits = (isNeg ? -val : val).toString();
  var outStr = '';
  var groupCounter = 0;
  var idx = rawDigits.length - 1;

  while (idx >= 0) {
    if (groupCounter > 0 && groupCounter % 3 == 0) {
      outStr = ',$outStr';
    }
    outStr = rawDigits[idx] + outStr;
    groupCounter++;
    idx--;
  }
  return '${isNeg ? '-' : ''}$outStr RWF';
}

bool isValidPin(String secretPin) {
  if (secretPin.length != 5) return false;
  
  var identicalDigits = true;
  var pos = 0;
  
  while (pos < secretPin.length) {
    var charCode = secretPin.codeUnitAt(pos);
    if (charCode < 48 || charCode > 57) return false; // check digits 0-9
    if (secretPin[pos] != secretPin[0]) {
      identicalDigits = false;
    }
    pos++;
  }

  if (secretPin == '12345') return false;
  if (identicalDigits) return false;
  
  return true;
}

int sendMoney(int currentBal, int transferAmt) {
  var tax = momoFee(transferAmt);
  if (tax == -1) {
    print('Failed: invalid amount');
    return currentBal;
  }
  if (transferAmt + tax > currentBal) {
    print('Failed: insufficient balance');
    return currentBal;
  }
  var updatedBal = currentBal - transferAmt - tax;
  print('Sent ${formatRwf(transferAmt)} (fee ${formatRwf(tax)}). New balance: ${formatRwf(updatedBal)}');
  return updatedBal;
}

int buyAirtime(int currentBal, int creditAmt) {
  if (creditAmt < 100 || creditAmt > 50000) {
    print('Failed: airtime must be between 100 and 50,000 RWF');
    return currentBal;
  }
  if (creditAmt > currentBal) {
    print('Failed: insufficient balance');
    return currentBal;
  }
  var updatedBal = currentBal - creditAmt;
  print('Airtime bought: ${formatRwf(creditAmt)}. New balance: ${formatRwf(updatedBal)}');
  return updatedBal;
}

void main() {
  print('Reg no: $regNo | D = $d | T = $t');

  print(isValidPin('12345'));
  print(isValidPin('77777'));
  print(isValidPin('4821'));
  print(isValidPin('48a21'));
  print(isValidPin('4821$d'));

  var accountBalance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(accountBalance)}');

  var step = 0;
  while (step < 3) {
    accountBalance = sendMoney(accountBalance, (d + 1) * 3000);
    step++;
  }
  
  accountBalance = buyAirtime(accountBalance, 1000);
  accountBalance = sendMoney(accountBalance, 0);
  accountBalance = sendMoney(accountBalance, 200000);
  
  print('Final balance: ${formatRwf(accountBalance)}');

  // Custom tests checks
  print(formatRwf(0));          // 0 RWF
  print(formatRwf(100000));     // 100,000 RWF
  print(formatRwf(-1000));      // -1,000 RWF
  print(isValidPin('00000'));   // false
  print(isValidPin('01234'));   // true
  print(isValidPin(''));        // false
}
