// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Classifieds {
  final String classfieldOwnerUserId;
  final String classifieldId;
  final String classifieldTitle;
  final String classifieldDescribe;
  final String classifeldImage;
  final DateTime classfieldPublishTime;

  Classifieds(
      this.classfieldOwnerUserId,
      this.classifieldId,
      this.classifieldTitle,
      this.classifieldDescribe,
      this.classifeldImage,
      this.classfieldPublishTime);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classfieldOwnerUserId': classfieldOwnerUserId,
      'classifieldId': classifieldId,
      'classifieldTitle': classifieldTitle,
      'classifieldDescribe': classifieldDescribe,
      'classifeldImage': classifeldImage,
      'classfieldPublishTime': classfieldPublishTime.millisecondsSinceEpoch,
    };
  }

  factory Classifieds.fromMap(Map<String, dynamic> map) {
    return Classifieds(
      map['classfieldOwnerUserId'] as String,
      map['classifieldId'] as String,
      map['classifieldTitle'] as String,
      map['classifieldDescribe'] as String,
      map['classifeldImage'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['classfieldPublishTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Classifieds.fromJson(String source) =>
      Classifieds.fromMap(json.decode(source) as Map<String, dynamic>);
}
