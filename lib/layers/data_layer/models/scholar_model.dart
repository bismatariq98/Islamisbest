class ScholarModel {
  String scholarName;
  String scholarLocation;
  String scholarId;
  String scholarInfo;
  String scholarContactInfo;
  String scholarLanguage;
  String scholarImage;

  ScholarModel(
      {this.scholarImage,
      this.scholarContactInfo,
      this.scholarId,
      this.scholarInfo,
      this.scholarLanguage,
      this.scholarLocation,
      this.scholarName});
}

ScholarModel scholarModel = ScholarModel();
