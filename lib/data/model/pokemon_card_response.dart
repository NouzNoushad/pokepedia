// To parse this JSON data, do
//
//     final pokemonCardResponse = pokemonCardResponseFromJson(jsonString);

import 'dart:convert';

PokemonCardResponse pokemonCardResponseFromJson(String str) =>
    PokemonCardResponse.fromJson(json.decode(str));

String pokemonCardResponseToJson(PokemonCardResponse data) =>
    json.encode(data.toJson());

class PokemonCardResponse {
  List<Cards> cards;

  PokemonCardResponse({
    required this.cards,
  });

  factory PokemonCardResponse.fromJson(Map<String, dynamic> json) =>
      PokemonCardResponse(
        cards: List<Cards>.from(json["cards"].map((x) => Cards.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
      };
}

class Cards {
  String id;
  String name;
  int? nationalPokedexNumber;
  String imageUrl;
  String imageUrlHiRes;
  List<RetreatCost>? types;
  Supertype supertype;
  String? subtype;
  String? evolvesFrom;
  String? hp;
  String number;
  String artist;
  String rarity;
  Series series;
  String? cardSet;
  String setCode;
  List<Attack>? attacks;
  List<Resistance>? weaknesses;
  List<RetreatCost>? retreatCost;
  int? convertedRetreatCost;
  List<Resistance>? resistances;
  List<String>? text;
  Ability? ability;

  Cards({
    required this.id,
    required this.name,
    this.nationalPokedexNumber,
    required this.imageUrl,
    required this.imageUrlHiRes,
    this.types,
    required this.supertype,
    this.subtype,
    this.evolvesFrom,
    this.hp,
    required this.number,
    required this.artist,
    required this.rarity,
    required this.series,
    this.cardSet,
    required this.setCode,
    this.attacks,
    this.weaknesses,
    this.retreatCost,
    this.convertedRetreatCost,
    this.resistances,
    this.text,
    this.ability,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        id: json["id"],
        name: json["name"],
        nationalPokedexNumber: json["nationalPokedexNumber"],
        imageUrl: json["imageUrl"],
        imageUrlHiRes: json["imageUrlHiRes"],
        types: json["types"] == null
            ? []
            : List<RetreatCost>.from(
                json["types"]!.map((x) => retreatCostValues.map[x]!)),
        supertype: supertypeValues.map[json["supertype"]]!,
        subtype: json["subtype"],
        evolvesFrom: json["evolvesFrom"],
        hp: json["hp"],
        number: json["number"],
        artist: json["artist"],
        rarity: json["rarity"],
        series: seriesValues.map[json["series"]]!,
        cardSet: json["set"],
        setCode: json["setCode"],
        attacks: json["attacks"] == null
            ? []
            : List<Attack>.from(
                json["attacks"]!.map((x) => Attack.fromJson(x))),
        weaknesses: json["weaknesses"] == null
            ? []
            : List<Resistance>.from(
                json["weaknesses"]!.map((x) => Resistance.fromJson(x))),
        retreatCost: json["retreatCost"] == null
            ? []
            : List<RetreatCost>.from(
                json["retreatCost"]!.map((x) => retreatCostValues.map[x]!)),
        convertedRetreatCost: json["convertedRetreatCost"],
        resistances: json["resistances"] == null
            ? []
            : List<Resistance>.from(
                json["resistances"]!.map((x) => Resistance.fromJson(x))),
        text: json["text"] == null
            ? []
            : List<String>.from(json["text"]!.map((x) => x)),
        ability:
            json["ability"] == null ? null : Ability.fromJson(json["ability"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nationalPokedexNumber": nationalPokedexNumber,
        "imageUrl": imageUrl,
        "imageUrlHiRes": imageUrlHiRes,
        "types": types == null
            ? []
            : List<dynamic>.from(
                types!.map((x) => retreatCostValues.reverse[x])),
        "supertype": supertypeValues.reverse[supertype],
        "subtype": subtype,
        "evolvesFrom": evolvesFrom,
        "hp": hp,
        "number": number,
        "artist": artist,
        "rarity": rarity,
        "series": seriesValues.reverse[series],
        "set": cardSet,
        "setCode": setCode,
        "attacks": attacks == null
            ? []
            : List<dynamic>.from(attacks!.map((x) => x.toJson())),
        "weaknesses": weaknesses == null
            ? []
            : List<dynamic>.from(weaknesses!.map((x) => x.toJson())),
        "retreatCost": retreatCost == null
            ? []
            : List<dynamic>.from(
                retreatCost!.map((x) => retreatCostValues.reverse[x])),
        "convertedRetreatCost": convertedRetreatCost,
        "resistances": resistances == null
            ? []
            : List<dynamic>.from(resistances!.map((x) => x.toJson())),
        "text": text == null ? [] : List<dynamic>.from(text!.map((x) => x)),
        "ability": ability?.toJson(),
      };
}

class Ability {
  String name;
  String text;
  Type type;

  Ability({
    required this.name,
    required this.text,
    required this.type,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        name: json["name"],
        text: json["text"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "text": text,
        "type": typeValues.reverse[type],
      };
}

enum Type { ABILITY, POK_BODY, POK_POWER }

final typeValues = EnumValues({
  "Ability": Type.ABILITY,
  "Poké-Body": Type.POK_BODY,
  "Poké-Power": Type.POK_POWER
});

class Attack {
  List<RetreatCost> cost;
  String name;
  String text;
  String damage;
  int convertedEnergyCost;

  Attack({
    required this.cost,
    required this.name,
    required this.text,
    required this.damage,
    required this.convertedEnergyCost,
  });

  factory Attack.fromJson(Map<String, dynamic> json) => Attack(
        cost: List<RetreatCost>.from(
            json["cost"].map((x) => retreatCostValues.map[x]!)),
        name: json["name"],
        text: json["text"],
        damage: json["damage"],
        convertedEnergyCost: json["convertedEnergyCost"],
      );

  Map<String, dynamic> toJson() => {
        "cost":
            List<dynamic>.from(cost.map((x) => retreatCostValues.reverse[x])),
        "name": name,
        "text": text,
        "damage": damage,
        "convertedEnergyCost": convertedEnergyCost,
      };
}

enum RetreatCost {
  COLORLESS,
  DARKNESS,
  FAIRY,
  FIGHTING,
  FIRE,
  FREE,
  GRASS,
  LIGHTNING,
  METAL,
  PSYCHIC,
  WATER
}

final retreatCostValues = EnumValues({
  "Colorless": RetreatCost.COLORLESS,
  "Darkness": RetreatCost.DARKNESS,
  "Fairy": RetreatCost.FAIRY,
  "Fighting": RetreatCost.FIGHTING,
  "Fire": RetreatCost.FIRE,
  "Free": RetreatCost.FREE,
  "Grass": RetreatCost.GRASS,
  "Lightning": RetreatCost.LIGHTNING,
  "Metal": RetreatCost.METAL,
  "Psychic": RetreatCost.PSYCHIC,
  "Water": RetreatCost.WATER
});

class Resistance {
  RetreatCost type;
  String value;

  Resistance({
    required this.type,
    required this.value,
  });

  factory Resistance.fromJson(Map<String, dynamic> json) => Resistance(
        type: retreatCostValues.map[json["type"]]!,
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": retreatCostValues.reverse[type],
        "value": value,
      };
}

enum Series {
  BASE,
  BLACK_WHITE,
  DIAMOND_PEARL,
  EX,
  HEART_GOLD_SOUL_SILVER,
  PLATINUM,
  SUN_MOON,
  SWORD_SHIELD,
  XY
}

final seriesValues = EnumValues({
  "Base": Series.BASE,
  "Black & White": Series.BLACK_WHITE,
  "Diamond & Pearl": Series.DIAMOND_PEARL,
  "EX": Series.EX,
  "HeartGold & SoulSilver": Series.HEART_GOLD_SOUL_SILVER,
  "Platinum": Series.PLATINUM,
  "Sun & Moon": Series.SUN_MOON,
  "Sword & Shield": Series.SWORD_SHIELD,
  "XY": Series.XY
});

enum Supertype { ENERGY, POKMON, TRAINER }

final supertypeValues = EnumValues({
  "Energy": Supertype.ENERGY,
  "Pokémon": Supertype.POKMON,
  "Trainer": Supertype.TRAINER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
