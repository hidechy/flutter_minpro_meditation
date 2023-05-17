class MeditationTime {
  final int timeMinutes;
  final String timeDisplayString;

//<editor-fold desc="Data Methods">
  const MeditationTime({
    required this.timeMinutes,
    required this.timeDisplayString,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeditationTime &&
          runtimeType == other.runtimeType &&
          timeMinutes == other.timeMinutes &&
          timeDisplayString == other.timeDisplayString);

  @override
  int get hashCode => timeMinutes.hashCode ^ timeDisplayString.hashCode;

  @override
  String toString() {
    return 'MeditationTime{' +
        ' timeMinutes: $timeMinutes,' +
        ' timeDisplayString: $timeDisplayString,' +
        '}';
  }

  MeditationTime copyWith({
    int? timeMinutes,
    String? timeDisplayString,
  }) {
    return MeditationTime(
      timeMinutes: timeMinutes ?? this.timeMinutes,
      timeDisplayString: timeDisplayString ?? this.timeDisplayString,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeMinutes': this.timeMinutes,
      'timeDisplayString': this.timeDisplayString,
    };
  }

  factory MeditationTime.fromMap(Map<String, dynamic> map) {
    return MeditationTime(
      timeMinutes: map['timeMinutes'] as int,
      timeDisplayString: map['timeDisplayString'] as String,
    );
  }

//</editor-fold>
}
