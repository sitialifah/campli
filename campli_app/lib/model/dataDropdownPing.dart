///
/// List untuk detail list data dropdown yg perlu ada di ping page
///
///
///

class Lantai {
  int id;
  String name;

  Lantai(this.id, this.name);
  static List<Lantai> getLantais() {
    return <Lantai>[
      Lantai(1, 'Lantai 1'),
      Lantai(2, 'Lantai 2'),
      Lantai(3, 'Lantai 3'),
      Lantai(4, 'Lantai 4'),
    ];
  }
}

class LantaiPot {
  int id;
  String nameLantaiPot;

  LantaiPot(this.id, this.nameLantaiPot);
  static List<LantaiPot> getLantaiPots() {
    return <LantaiPot>[
      LantaiPot(1, 'Lantai 1'),
      LantaiPot(2, 'Lantai 2'),
      LantaiPot(3, 'Lantai 3'),
      LantaiPot(4, 'Lantai 4'),
    ];
  }
}

class Pot {
  int id;
  String namePot;

  Pot(this.id, this.namePot);
  static List<Pot> getPots() {
    return <Pot>[
      Pot(1, 'Polybag 1'),
      Pot(2, 'Polybag 2'),
      Pot(3, 'Polybag 3'),
      Pot(4, 'Polybag 4'),
    ];
  }
}
