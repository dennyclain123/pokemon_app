class PokemonOb {
  int num;
  String name;
  List<Variations> variations;
  String link;

  PokemonOb({this.num, this.name, this.variations, this.link});

  PokemonOb.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    if (json['variations'] != null) {
      variations = new List<Variations>();
      json['variations'].forEach((v) {
        variations.add(new Variations.fromJson(v));
      });
    }
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    if (this.variations != null) {
      data['variations'] = this.variations.map((v) => v.toJson()).toList();
    }
    data['link'] = this.link;
    return data;
  }
}

class Variations {
  String name;
  String description;
  String image;
  List<String> types;
  String specie;
  num height;
  num weight;
  List<String> abilities;
  Stats stats;
  List<String> evolutions;

  Variations(
      {this.name,
        this.description,
        this.image,
        this.types,
        this.specie,
        this.height,
        this.weight,
        this.abilities,
        this.stats,
        this.evolutions});

  Variations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    types = json['types'].cast<String>();
    specie = json['specie'];
    height = json['height'];
    weight = json['weight'];
    abilities = json['abilities'].cast<String>();
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    evolutions = json['evolutions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['types'] = this.types;
    data['specie'] = this.specie;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['abilities'] = this.abilities;
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    data['evolutions'] = this.evolutions;
    return data;
  }
}

class Stats {
  int total;
  int hp;
  int attack;
  int defense;
  int speedAttack;
  int speedDefense;
  int speed;

  Stats(
      {this.total,
        this.hp,
        this.attack,
        this.defense,
        this.speedAttack,
        this.speedDefense,
        this.speed});

  Stats.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    hp = json['hp'];
    attack = json['attack'];
    defense = json['defense'];
    speedAttack = json['speedAttack'];
    speedDefense = json['speedDefense'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['hp'] = this.hp;
    data['attack'] = this.attack;
    data['defense'] = this.defense;
    data['speedAttack'] = this.speedAttack;
    data['speedDefense'] = this.speedDefense;
    data['speed'] = this.speed;
    return data;
  }
}
