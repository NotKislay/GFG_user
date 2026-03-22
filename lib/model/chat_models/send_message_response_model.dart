class SendMessageResponse {
  String? status;
  Error? error;
  Message? message;
  String? tempID;

  SendMessageResponse({this.status, this.error, this.message, this.tempID});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'] != null ?  Error.fromJson(json['error']) : null;
    message =
    json['message'] != null ? Message.fromJson(json['message']) : null;
    tempID = json['tempID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['tempID'] = tempID;
    return data;
  }
}

class Error {
  int? status;
  String? message;

  Error({this.status, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Message {
  String? id;
  int? fromId;
  String? toId;
  String? message;
  Attachment? attachment;
  String? type;
  String? timeAgo;
  String? createdAt;
  bool? isSender;
  String? seen;

  Message(
      {this.id,
        this.fromId,
        this.toId,
        this.message,
        this.attachment,
        this.type,
        this.timeAgo,
        this.createdAt,
        this.isSender,
        this.seen});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    message = json['message'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
    type = json['type'];
    timeAgo = json['timeAgo'];
    createdAt = json['created_at'];
    isSender = json['isSender'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['message'] = message;
    if (attachment != null) {
      data['attachment'] = attachment!.toJson();
    }
    data['type'] = type;
    data['timeAgo'] = timeAgo;
    data['created_at'] = createdAt;
    data['isSender'] = isSender;
    data['seen'] = seen;
    return data;
  }
}

class Attachment {
  String? file;
  String? title;
  String? type;

  Attachment({this.file, this.title, this.type});

  Attachment.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
