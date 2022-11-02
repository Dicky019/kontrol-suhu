class ModelKontrolSuhu {
  final num kelembapan;
  final bool kontrol;
  final bool mode;
  final num suhu;

  ModelKontrolSuhu(this.kelembapan, this.kontrol, this.mode, this.suhu);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Kelembapan': kelembapan,
      'Kontrol': kontrol,
      'Mode': mode,
      'Suhu': suhu,
    };
  }

  factory ModelKontrolSuhu.fromMap(Map<String, dynamic> map) {
    return ModelKontrolSuhu(
      map['Kelembapan'] as num,
      map['Kontrol'] as bool,
      map['Mode'] as bool,
      map['Suhu'] as num,
    );
  }

  factory ModelKontrolSuhu.empty() {
    return ModelKontrolSuhu(
      0,
      false,
      false,
      0,
    );
  }

  @override
  String toString() {
    return 'ModelKontrolSuhu(kelembapan: $kelembapan, kontrol: $kontrol, mode: $mode, suhu: $suhu)';
  }
}

// id: 1,
// name: "Rick Sanchez",
// status: "Alive",
// species: "Human",