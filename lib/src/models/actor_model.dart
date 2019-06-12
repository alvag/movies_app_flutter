class Cast {
  List<Actor> actors = new List();

  Cast();

  Cast.fromJsonList(List<dynamic> list) {
    if (list == null) return;
    for (var item in list) {
      final actor = new Actor.fromJsonMap(item);
      actors.add(actor);
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    id = json['id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getProfileImage() {
    if (profilePath == null) {
      return 'assets/images/generic-avatar.png';
    }
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}
