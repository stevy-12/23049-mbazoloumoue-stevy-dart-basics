// Student: Stevy MBAZOLOUMOUE
// Reg no: 23049
const String regNo = '23049';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int countVowels(String text) {
  // by SM
  String lower = text.toLowerCase(); // this line makes capital letters count
  int count = 0;
  for (int i = 0; i < lower.length; i++) {
    if ('aeiou'.contains(lower[i])) count++;
  }
  return count;
}

String initials(String fullName) {
  // by SM
  String result = '';
  for (final part in fullName.trim().split(' ')) {
    if (part.isNotEmpty) result += '${part[0].toUpperCase()}.';
  }
  return result;
}

void drawTriangle(int height) {
  // by SM
  for (int row = 1; row <= height; row++) {
    String symbol = row.isOdd ? '*' : '#';
    print(' ' * (height - row) + symbol * row);
  }
}

int momoFee(int amount) {
  // by SM
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by SM
  if (phone.length != 10) return 'INVALID';
  String stars = '';
  int i = 3;
  while (i < phone.length - 2) {
    stars += '*';
    i++;
  }
  return phone.substring(0, 3) + stars + phone.substring(phone.length - 2);
}

void main() {
  // by SM
  print('Reg no: $regNo | D = $d | T = $t');

  // B2
  const name = 'Stevy MBAZOLOUMOUE';
  print('$name has ${countVowels(name)} vowels');

  // B3
  print(initials(name));
  print(initials(' ana uwase '));
  print(initials(' '));

  // C5
  drawTriangle(d + 3);
  drawTriangle(0);
  drawTriangle(-2);

  // D2
  const phone = '0788123456';
  int i = 1;
  int totalFees = 0;
  while (i <= d + 3) {
    int amount = i * 4000 + t * 100;
    int fee = momoFee(amount);
    print('Receipt $i | $amount RWF | fee $fee RWF | to ${maskPhone(phone)}');
    totalFees += fee;
    i++;
  }
  print('Total fees: $totalFees RWF');
}
