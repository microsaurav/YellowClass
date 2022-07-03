class VideoModel {
  int id;
  String title;
  String videoUrl;
  String thumbnail;

  VideoModel(this.id, this.title, this.videoUrl, this.thumbnail);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        json['id'], json['title'], json['videoUrl'], json['coverPicture']);
  }
}
