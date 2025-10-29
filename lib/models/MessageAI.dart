class Messageai {
  final String message;
  final bool IsUser;
  final Map<String, String>? metadata; 

  Messageai({
    required this.message,
    required this.IsUser,
    this.metadata,
  });

  // List <Messageai> mymessage = [

  //   Messageai(message: "HAI APA KHABAR", IsUser: true),
  //   Messageai(message: "SAYA ROBOT", IsUser: false),
  //   Messageai(message: "Okay", IsUser: true),
  //   Messageai(message: "Saya Robot", IsUser: true),

  // ]


}