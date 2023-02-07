class DataModel {
  late double air;
  late double alcohol;
  late double co;
  late double humidity;
  late double lpg;
  late double temperature;
  late String fAir;
  late String fAlcohol;
  late String fCO;
  late String fLPG;

  DataModel({
    this.air = 0,
    this.alcohol = 0,
    this.co = 0,
    this.humidity = 0,
    this.lpg = 0,
    this.temperature = 0,
    this.fAir = '',
    this.fAlcohol = '',
    this.fCO = '',
    this.fLPG = '',
  });

  DataModel.fromJson(Map json) {
    air = double.parse(json['Air'].toString());
    alcohol = double.parse(json['Alcohol'].toString());
    co = double.parse(json['CO2'].toString());
    humidity = double.parse(json['Humidity'].toString());
    lpg = double.parse(json['LPG'].toString());
    temperature = double.parse(json['Temperature'].toString());
    fAir = json['f_Air'] ?? '';
    fAlcohol = json['f_Alcohol'] ?? '';
    fCO = json['f_CO2'] ?? '';
    fLPG = json['f_LPG'] ?? '';
  }
}
