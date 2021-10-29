class AppUpdateModel {
  String addTime;
  String content;
  String contentEn;
  int dataId;
  int id;
  int isEnable;
  int model;
  int type;
  String url;
  int version;

  AppUpdateModel({this.addTime, this.content, this.contentEn, this.dataId, this.id, this.isEnable, this.model, this.type, this.url, this.version});

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) {
    return AppUpdateModel(
      addTime: json['addTime'],
      content: json['content'],
      contentEn: json['contentEn'],
      dataId: json['dataId'],
      id: json['id'],
      isEnable: json['isEnable'],
      model: json['model'],
      type: json['type'],
      url: json['url'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addTime'] = this.addTime;
    data['content'] = this.content;
    data['contentEn'] = this.contentEn;
    data['dataId'] = this.dataId;
    data['id'] = this.id;
    data['isEnable'] = this.isEnable;
    data['model'] = this.model;
    data['type'] = this.type;
    data['url'] = this.url;
    data['version'] = this.version;
    return data;
  }

  @override
  String toString() {
    return 'Data{addTime: $addTime, content: $content, contentEn: $contentEn, dataId: $dataId, id: $id, isEnable: $isEnable, model: $model, type: $type, url: $url, version: $version}';
  }
}

