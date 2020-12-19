import 'dart:convert';

Dictionary dictionaryFromJson(String str) => Dictionary.fromJson(json.decode(str));

String dictionaryToJson(Dictionary data) => json.encode(data.toJson());

class Dictionary{
  String Amharic;
  String Kistanigna;
  String English;
  String Definition;

  Dictionary({
    this.Amharic,
    this.Kistanigna,
    this.English,
    this.Definition,
  });

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
    Amharic: json['Amharic'],
    Kistanigna: json['Kistanigna'],
    English: json['English'],
    Definition: json['Definition'],
);

  Map<String, dynamic> toJson() =>{
    "Amharic": Amharic,
    "Kistanigna": Kistanigna,
    "English": English,
    "Definition": Definition,
  };
}