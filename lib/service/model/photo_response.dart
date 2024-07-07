class PhotoResponse {
  // final String title, thumbnail, id;
  final String type, setup;

// named constructor
  PhotoResponse.fromJson(Map<String, dynamic> json)
      // : title = json["title"],
      //   thumbnail = json["thumbnail"],
      //   id = json["id"];
      : type = json["type"],
        setup = json["setup"];
}
