const int THEME_ID_SILENCE = 0;
const int THEME_ID_CAVE = 1;
const int THEME_ID_SPRING = 2;
const int THEME_ID_SUMMER = 3;
const int THEME_ID_AUTUMN = 4;
const int THEME_ID_STREAM = 5;
const int THEME_ID_WIND_BELLS = 6;
const int THEME_ID_BONFIRE = 7;

class MeditationTheme {
  final int themeId;
  final String themeName;
  final String imagePath;
  final String? soundPath;

//<editor-fold desc="Data Methods">
  const MeditationTheme({
    required this.themeId,
    required this.themeName,
    required this.imagePath,
    this.soundPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeditationTheme &&
          runtimeType == other.runtimeType &&
          themeId == other.themeId &&
          themeName == other.themeName &&
          imagePath == other.imagePath &&
          soundPath == other.soundPath);

  @override
  int get hashCode =>
      themeId.hashCode ^
      themeName.hashCode ^
      imagePath.hashCode ^
      soundPath.hashCode;

  @override
  String toString() {
    return 'MeditationTheme{' +
        ' themeId: $themeId,' +
        ' themeName: $themeName,' +
        ' imagePath: $imagePath,' +
        ' soundPath: $soundPath,' +
        '}';
  }

  MeditationTheme copyWith({
    int? themeId,
    String? themeName,
    String? imagePath,
    String? soundPath,
  }) {
    return MeditationTheme(
      themeId: themeId ?? this.themeId,
      themeName: themeName ?? this.themeName,
      imagePath: imagePath ?? this.imagePath,
      soundPath: soundPath ?? this.soundPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeId': this.themeId,
      'themeName': this.themeName,
      'imagePath': this.imagePath,
      'soundPath': this.soundPath,
    };
  }

  factory MeditationTheme.fromMap(Map<String, dynamic> map) {
    return MeditationTheme(
      themeId: map['themeId'] as int,
      themeName: map['themeName'] as String,
      imagePath: map['imagePath'] as String,
      soundPath: map['soundPath'] as String,
    );
  }

//</editor-fold>
}
