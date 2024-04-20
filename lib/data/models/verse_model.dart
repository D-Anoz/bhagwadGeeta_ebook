// To parse this JSON data, do
//
//     final verseModel = verseModelFromJson(jsonString);

import 'dart:convert';

VerseModel verseModelFromJson(String str) => VerseModel.fromJson(json.decode(str));

String verseModelToJson(VerseModel data) => json.encode(data.toJson());

class VerseModel {
  int? id;
  String? name;
  String? slug;
  String? nameTransliterated;
  String? nameTranslated;
  int? versesCount;
  int? chapterNumber;
  String? nameMeaning;
  String? chapterSummary;
  String? chapterSummaryHindi;

  VerseModel({
    this.id,
    this.name,
    this.slug,
    this.nameTransliterated,
    this.nameTranslated,
    this.versesCount,
    this.chapterNumber,
    this.nameMeaning,
    this.chapterSummary,
    this.chapterSummaryHindi,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        nameTransliterated: json["name_transliterated"],
        nameTranslated: json["name_translated"],
        versesCount: json["verses_count"],
        chapterNumber: json["chapter_number"],
        nameMeaning: json["name_meaning"],
        chapterSummary: json["chapter_summary"],
        chapterSummaryHindi: json["chapter_summary_hindi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "name_transliterated": nameTransliterated,
        "name_translated": nameTranslated,
        "verses_count": versesCount,
        "chapter_number": chapterNumber,
        "name_meaning": nameMeaning,
        "chapter_summary": chapterSummary,
        "chapter_summary_hindi": chapterSummaryHindi,
      };
}
