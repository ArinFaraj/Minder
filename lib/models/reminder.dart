import 'dart:convert';

class Reminder {
  String? text;
  DateTime? time = DateTime.now().add(Duration(days: 1));
  DateTime? timeCreated = DateTime.now();
  bool? isDone = false;
  int? postponeTimes = 0;

  Reminder({
    this.text,
    this.time,
    this.timeCreated,
    this.isDone = false,
    this.postponeTimes,
  });

  Reminder copyWith({
    String? text,
    DateTime? time,
    DateTime? timeCreated,
    bool? isDone,
    int? postponeTimes,
  }) {
    return Reminder(
      text: text ?? this.text,
      time: time ?? this.time,
      timeCreated: timeCreated ?? this.timeCreated,
      isDone: isDone ?? this.isDone,
      postponeTimes: postponeTimes ?? this.postponeTimes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'time': time?.millisecondsSinceEpoch,
      'timeCreated': timeCreated?.millisecondsSinceEpoch,
      'isDone': isDone,
      'postponeTimes': postponeTimes,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {

    return Reminder(
      text: map['text'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      timeCreated: DateTime.fromMillisecondsSinceEpoch(map['timeCreated']),
      isDone: map['isDone'],
      postponeTimes: map['postponeTimes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reminder.fromJson(String source) => Reminder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Reminder(text: $text, time: $time, timeCreated: $timeCreated, isDone: $isDone, postponeTimes: $postponeTimes)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Reminder &&
        o.text == text &&
        o.time == time &&
        o.timeCreated == timeCreated &&
        o.isDone == isDone &&
        o.postponeTimes == postponeTimes;
  }

  @override
  int get hashCode {
    return text.hashCode ^ time.hashCode ^ timeCreated.hashCode ^ isDone.hashCode ^ postponeTimes.hashCode;
  }
}
