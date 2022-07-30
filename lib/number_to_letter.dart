String unite(int nombre) {
  String unite = "null";
  switch (nombre) {
    case 0:
      {
        unite = "zéro";
      }
      break;
    case 1:
      {
        unite = "un";
      }
      break;
    case 2:
      {
        unite = "deux";
      }
      break;
    case 3:
      {
        unite = "trois";
      }
      break;
    case 4:
      {
        unite = "quatre";
      }
      break;
    case 5:
      {
        unite = "cinq";
      }
      break;
    case 6:
      {
        unite = "six";
      }
      break;
    case 7:
      {
        unite = "sept";
      }
      break;
    case 8:
      {
        unite = "huit";
      }
      break;
    case 9:
      {
        unite = "neuf";
      }
      break;
  }
  return unite;
}

String dizaine(int nombre) {
  String dizaine = "null";
  switch (nombre) {
    case 10:
      {
        dizaine = "dix";
      }
      break;
    case 11:
      {
        dizaine = "onze";
      }
      break;
    case 12:
      {
        dizaine = "douze";
      }
      break;
    case 13:
      {
        dizaine = "treize";
      }
      break;
    case 14:
      {
        dizaine = "quatorze";
      }
      break;
    case 15:
      {
        dizaine = "quinze";
      }
      break;
    case 16:
      {
        dizaine = "seize";
      }
      break;
    case 17:
      {
        dizaine = "dix-sept";
      }
      break;
    case 18:
      {
        dizaine = "dix-huit";
      }
      break;
    case 19:
      {
        dizaine = "dix-neuf";
      }
      break;
    case 20:
      {
        dizaine = "vingt";
      }
      break;
    case 30:
      {
        dizaine = "trente";
      }
      break;
    case 40:
      {
        dizaine = "quarante";
      }
      break;
    case 50:
      {
        dizaine = "cinquante";
      }
      break;
    case 60:
      {
        dizaine = "soixante";
      }
      break;
    case 70:
      {
        dizaine = "soixante-dix";
      }
      break;
    case 80:
      {
        dizaine = "quatre-vingt";
      }
      break;
    case 90:
      {
        dizaine = "quatre-vingt-dix";
      }
      break;
  }
  return dizaine;
}

bool isNumeric(String nbr) {
  try {
    print(int.parse(nbr));
    return true;
  } on FormatException {
    print("invalid number");
    return false;
  }
}

String fnumberToLetter(nombre) {
  var n, quotient, reste, nb;
  var numberToLetter = '';
  //__________________________________

  if (nombre.toString().trim().length > 15) return "dépassement de capacité";
  if (isNumeric(nombre.toString().trim()) == false) return "Nombre non valide";

  nb = int.parse(nombre.toString().trim());

  n = nb.toString().length;
  switch (n) {
    case 1:
      numberToLetter = unite(nb);
      break;
    case 2:
      if (nb > 19) {
        quotient = (nb / 10).floor();
        reste = nb % 10;
        if (nb < 71 || (nb > 79 && nb < 91)) {
          if (reste == 0) numberToLetter = dizaine(quotient * 10);
          if (reste == 1)
            numberToLetter = dizaine(quotient * 10) + "-et-" + unite(reste);
          if (reste > 1)
            numberToLetter = dizaine(quotient * 10) + "-" + unite(reste);
        } else {
          var nReste = 10 + reste;
          numberToLetter = dizaine((quotient - 1) * 10) +
              "-" +
              dizaine(int.parse(nReste.toString()));
        }
      } else
        numberToLetter = dizaine(nb);
      break;
    case 3:
      quotient = (nb / 100).floor();
      reste = nb % 100;
      if (quotient == 1 && reste == 0) numberToLetter = "cent";
      if (quotient == 1 && reste != 0)
        numberToLetter = "cent" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = unite(quotient) + " cents";
      if (quotient > 1 && reste != 0)
        numberToLetter = unite(quotient) + " cent " + fnumberToLetter(reste);
      break;
    case 4:
      quotient = (nb / 1000).floor();
      reste = nb - quotient * 1000;
      if (quotient == 1 && reste == 0) numberToLetter = "mille";
      if (quotient == 1 && reste != 0)
        numberToLetter = "mille" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " mille";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " mille " + fnumberToLetter(reste);
      break;
    case 5:
      quotient = (nb / 1000).floor();
      reste = nb - quotient * 1000;
      if (quotient == 1 && reste == 0) numberToLetter = "mille";
      if (quotient == 1 && reste != 0)
        numberToLetter = "mille" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " mille";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " mille " + fnumberToLetter(reste);
      break;
    case 6:
      quotient = (nb / 1000).floor();
      reste = nb - quotient * 1000;
      if (quotient == 1 && reste == 0) numberToLetter = "mille";
      if (quotient == 1 && reste != 0)
        numberToLetter = "mille" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " mille";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " mille " + fnumberToLetter(reste);
      break;
    case 7:
      quotient = (nb / 1000000).floor();
      reste = nb % 1000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un million";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un million" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " millions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " millions " + fnumberToLetter(reste);
      break;
    case 8:
      quotient = (nb / 1000000).floor();
      reste = nb % 1000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un million";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un million" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " millions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " millions " + fnumberToLetter(reste);
      break;
    case 9:
      quotient = (nb / 1000000).floor();
      reste = nb % 1000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un million";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un million" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " millions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " millions " + fnumberToLetter(reste);
      break;
    case 10:
      quotient = (nb / 1000000000).floor();
      reste = nb - quotient * 1000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un milliard";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un milliard" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " milliards";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " milliards " + fnumberToLetter(reste);
      break;
    case 11:
      quotient = (nb / 1000000000).floor();
      reste = nb - quotient * 1000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un milliard";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un milliard" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " milliards";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " milliards " + fnumberToLetter(reste);
      break;
    case 12:
      quotient = (nb / 1000000000).floor();
      reste = nb - quotient * 1000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un milliard";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un milliard" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " milliards";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " milliards " + fnumberToLetter(reste);
      break;
    case 13:
      quotient = (nb / 1000000000000).floor();
      reste = nb - quotient * 1000000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un billion";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un billion" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " billions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " billions " + fnumberToLetter(reste);
      break;
    case 14:
      quotient = (nb / 1000000000000).floor();
      reste = nb - quotient * 1000000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un billion";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un billion" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " billions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " billions " + fnumberToLetter(reste);
      break;
    case 15:
      quotient = (nb / 1000000000000).floor();
      reste = nb - quotient * 1000000000000;
      if (quotient == 1 && reste == 0) numberToLetter = "un billion";
      if (quotient == 1 && reste != 0)
        numberToLetter = "un billion" + " " + fnumberToLetter(reste);
      if (quotient > 1 && reste == 0)
        numberToLetter = fnumberToLetter(quotient) + " billions";
      if (quotient > 1 && reste != 0)
        numberToLetter =
            fnumberToLetter(quotient) + " billions " + fnumberToLetter(reste);
      break;
  }

  return numberToLetter;
}
