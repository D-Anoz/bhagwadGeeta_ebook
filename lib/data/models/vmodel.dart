// To parse this JSON data, do
//
//     final vModel = vModelFromJson(jsonString);

import 'dart:convert';

List<VModel> vModelFromJson(String str) => List<VModel>.from(json.decode(str).map((x) => VModel.fromJson(x)));

String vModelToJson(List<VModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VModel {
  int? id;
  int? verseNumber;
  int? chapterNumber;
  String? slug;
  String? text;
  String? transliteration;
  String? wordMeanings;
  List<Commentary>? translations;
  List<Commentary>? commentaries;

  VModel({
    this.id,
    this.verseNumber,
    this.chapterNumber,
    this.slug,
    this.text,
    this.transliteration,
    this.wordMeanings,
    this.translations,
    this.commentaries,
  });

  factory VModel.fromJson(Map<String, dynamic> json) => VModel(
        id: json["id"],
        verseNumber: json["verse_number"],
        chapterNumber: json["chapter_number"],
        slug: json["slug"],
        text: json["text"],
        transliteration: json["transliteration"],
        wordMeanings: json["word_meanings"],
        translations: json["translations"] == null ? [] : List<Commentary>.from(json["translations"]!.map((x) => Commentary.fromJson(x))),
        commentaries: json["commentaries"] == null ? [] : List<Commentary>.from(json["commentaries"]!.map((x) => Commentary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "verse_number": verseNumber,
        "chapter_number": chapterNumber,
        "slug": slug,
        "text": text,
        "transliteration": transliteration,
        "word_meanings": wordMeanings,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "commentaries": commentaries == null ? [] : List<dynamic>.from(commentaries!.map((x) => x.toJson())),
      };
}

class Commentary {
  int? id;
  String? description;
  AuthorName? authorName;
  Language? language;

  Commentary({
    this.id,
    this.description,
    this.authorName,
    this.language,
  });

  factory Commentary.fromJson(Map<String, dynamic> json) => Commentary(
        id: json["id"],
        description: json["description"],
        authorName: authorNameValues.map[json["author_name"]]!,
        language: languageValues.map[json["language"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author_name": authorNameValues.reverse[authorName],
        "language": languageValues.reverse[language],
      };
}

enum AuthorName {
  DR_S_SANKARANARAYAN,
  SHRI_PUROHIT_SWAMI,
  SRI_ABHINAVGUPTA,
  SRI_ANANDGIRI,
  SRI_DHANPATI,
  SRI_JAYATRITHA,
  SRI_MADHAVACHARYA,
  SRI_MADHUSUDAN_SARASWATI,
  SRI_NEELKANTH,
  SRI_PURUSHOTTAMJI,
  SRI_RAMANUJACHARYA,
  SRI_SHANKARACHARYA,
  SRI_SRIDHARA_SWAMI,
  SRI_VALLABHACHARYA,
  SRI_VEDANTADESHIKACHARYA_VENKATANATHA,
  SWAMI_ADIDEVANANDA,
  SWAMI_CHINMAYANANDA,
  SWAMI_GAMBIRANANDA,
  SWAMI_RAMSUKHDAS,
  SWAMI_SIVANANDA,
  SWAMI_TEJOMAYANANDA
}

final authorNameValues = EnumValues({
  "Dr. S. Sankaranarayan": AuthorName.DR_S_SANKARANARAYAN,
  "Shri Purohit Swami": AuthorName.SHRI_PUROHIT_SWAMI,
  "Sri Abhinavgupta": AuthorName.SRI_ABHINAVGUPTA,
  "Sri Anandgiri": AuthorName.SRI_ANANDGIRI,
  "Sri Dhanpati": AuthorName.SRI_DHANPATI,
  "Sri Jayatritha": AuthorName.SRI_JAYATRITHA,
  "Sri Madhavacharya": AuthorName.SRI_MADHAVACHARYA,
  "Sri Madhusudan Saraswati": AuthorName.SRI_MADHUSUDAN_SARASWATI,
  "Sri Neelkanth": AuthorName.SRI_NEELKANTH,
  "Sri Purushottamji": AuthorName.SRI_PURUSHOTTAMJI,
  "Sri Ramanujacharya": AuthorName.SRI_RAMANUJACHARYA,
  "Sri Shankaracharya": AuthorName.SRI_SHANKARACHARYA,
  "Sri Sridhara Swami": AuthorName.SRI_SRIDHARA_SWAMI,
  "Sri Vallabhacharya": AuthorName.SRI_VALLABHACHARYA,
  "Sri Vedantadeshikacharya Venkatanatha": AuthorName.SRI_VEDANTADESHIKACHARYA_VENKATANATHA,
  "Swami Adidevananda": AuthorName.SWAMI_ADIDEVANANDA,
  "Swami Chinmayananda": AuthorName.SWAMI_CHINMAYANANDA,
  "Swami Gambirananda": AuthorName.SWAMI_GAMBIRANANDA,
  "Swami Ramsukhdas": AuthorName.SWAMI_RAMSUKHDAS,
  "Swami Sivananda": AuthorName.SWAMI_SIVANANDA,
  "Swami Tejomayananda": AuthorName.SWAMI_TEJOMAYANANDA
});

enum Language {
  ENGLISH,
  HINDI,
  SANSKRIT
}

final languageValues = EnumValues({
  "english": Language.ENGLISH,
  "hindi": Language.HINDI,
  "sanskrit": Language.SANSKRIT
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
