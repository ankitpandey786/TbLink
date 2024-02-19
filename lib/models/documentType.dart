class Data
{
  List<DocumentTypeModel>? data;
  Data({
    this.data,
  });

  factory Data.fromJSON(List d) => Data(
      data: List<DocumentTypeModel>.from(d.map((x) => DocumentTypeModel.fromJson(x)))
  );
}

class DocumentTypeModel {
  DocumentTypeModel({
    this.rowId,
    this.type,
  });

  int? rowId;
  String? type;

  factory DocumentTypeModel.fromJson(Map<String, dynamic> json) => DocumentTypeModel(
    rowId: json["row_Id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "row_Id": rowId,
    "type": type,
  };
}