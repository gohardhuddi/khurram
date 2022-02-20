class ProjectsModel{
  late String projName;
  late String projDec;
  late String proImageUrl;
  ProjectsModel({
   required this.proImageUrl,required this.projDec,required this.projName
});
  factory ProjectsModel.fromJson(Map<String, dynamic> json) {
    return ProjectsModel(
      proImageUrl: json['imgUrl'] ??"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
      projDec: json['dec'] ??"dec",
      projName:  json['name'] ??"name",
    );
  }
}