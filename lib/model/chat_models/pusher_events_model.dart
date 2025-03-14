
class PusherEventModel {
  int? fromId;
  String? toId;
  Message? message;
  String? type;

  PusherEventModel({this.fromId, this.toId, this.message, this.type});

  PusherEventModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    fromId = json['from_id'];
    toId = json['to_id'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_id'] = fromId;
    data['to_id'] = toId;
    if (message != null) {
      data['message'] = message!.toJson();
    }
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
  int? seen;

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
  String? fileSize;
  String? pages;
  bool? isDownloaded;

  Attachment({this.file, this.title, this.type, this.isDownloaded});

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
