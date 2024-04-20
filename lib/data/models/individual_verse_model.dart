// To parse this JSON data, do
//
//     final individualVerseModel = individualVerseModelFromJson(jsonString);

import 'dart:convert';

IndividualVerseModel individualVerseModelFromJson(String str) => IndividualVerseModel.fromJson(json.decode(str));

String individualVerseModelToJson(IndividualVerseModel data) => json.encode(data.toJson());

class IndividualVerseModel {
  int? id;
  int? verseNumber;
  int? chapterNumber;
  String? slug;
  String? text;
  String? transliteration;
  String? wordMeanings;
  List<Commentary>? translations;
  List<Commentary>? commentaries;

  IndividualVerseModel({
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

  factory IndividualVerseModel.fromJson(Map<String, dynamic> json) => IndividualVerseModel(
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
  String? authorName;
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
        authorName: json["author_name"],
        language: languageValues.map[json["language"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author_name": authorName,
        "language": languageValues.reverse[language],
      };
}

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
