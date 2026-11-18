// Student: Stevy MBAZOLOUMOUE
// Reg no: 23049
const String regNo = '23049';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int mnt) {
  if (mnt <= 0) return -1;
  if (mnt <= 1000) return 20;
  if (mnt <= 10000) return 100;
  if (mnt <= 150000) return 250;
  return 1500;
}

String maskPhone(String tel) {
  if (tel.length != 10) return 'INVALID';
  var hidden = '';
  var idx = 3;
  while (idx < tel.length - 2) {
    hidden += '*';
    idx++;
  }
  return tel.substring(0, 3) + hidden + tel.substring(tel.length - 2);
}

int countVowels(String str) {
  var s = str.toLowerCase();
  var tally = 0;
  for (var k = 0; k < s.length; k++) {
    if ('aeiou'.contains(s[k])) {
      tally++;
    }
  }
  return tally;
}

String initials(String fullname) {
  var res = '';
  for (var chunk in fullname.trim().split(' ')) {
    if (chunk.isNotEmpty) {
      res += '${chunk[0].toUpperCase()}.';
    }
  }
  return res;
}

void drawTriangle(int h) {
  for (var r = 1; r <= h; r++) {
    var char = (r % 2 != 0) ? '*' : '#';
    print('${' ' * (h - r)}${char * r}');
  }
}

void main() {
  print('Reg no: $regNo | D = $d | T = $t');

  // B2
  const studentName = 'Stevy MBAZOLOUMOUE';
  print('$studentName has ${countVowels(studentName)} vowels');

  // B3
  print(initials(studentName));
  print(initials(' ana uwase '));
  print(initials(' '));

  // C5
  drawTriangle(d + 3);
  drawTriangle(0);
  drawTriangle(-2);

  // D2
  const pNumber = '0788123456';
  var counter = 1;
  var sumFees = 0;
  
  while (counter <= d + 3) {
    var computedAmount = counter * 4000 + t * 100;
    var computedFee = momoFee(computedAmount);
    print('Receipt $counter | $computedAmount RWF | fee $computedFee RWF | to ${maskPhone(pNumber)}');
    sumFees += computedFee;
    counter++;
  }
  print('Total fees: $sumFees RWF');
}
