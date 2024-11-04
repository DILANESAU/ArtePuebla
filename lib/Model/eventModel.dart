class Event {
  final String nameEvent;
  final String typeEvent;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String address;
  final String place;
  final double cost;
  final String publicType;
  final String description;
  //final String urlImg;

  Event({
    required this.nameEvent,
    required this.typeEvent,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.place,
    required this.cost,
    required this.publicType,
    required this.description,
    //required this.urlImg,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      nameEvent: json['nameEvent'],
      typeEvent: json['typeEvent'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      address: json['address'],
      place: json['place'],
      cost: json['cost'].toDouble(),
      publicType: json['publicType'],
      description: json['description'],

    );
  }
}
