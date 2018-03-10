class Publication {
  Publication(String photo, String title, String detail) {
    this.photo = photo;
    this.title = title;
    this.detail = detail;
  }

  String photo;
  String title;
  String detail;

  bool get isValid => photo != null && title != null && detail != null;
}
