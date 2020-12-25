class PrayerTimingModel {
  String fajar;
  String sunrise;

  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String imsak;
  String midnight;
  String readableDate;
  String day;
  int month;
  String year;
  String hijriDay;
  String hijriMonth;
  String hijriYear;
  // String prayerId;
  // int prayerTimeEpoch;
  // String date;
  // String location;
  // String country;
  // String continent;

  PrayerTimingModel(
      {this.fajar,
      this.sunrise,
      this.dhuhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha,
      this.imsak,
      this.midnight,
      this.readableDate,
      this.day,
      this.month,
      this.year,
      this.hijriDay,
      this.hijriMonth,
      this.hijriYear});
}

PrayerTimingModel prayerTimingModel = PrayerTimingModel();
