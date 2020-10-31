class DeptBranchModel {
  List departments;
  List branches;

  DeptBranchModel({
    this.departments,
    this.branches,
  });

  factory DeptBranchModel.fromJson(Map<String, dynamic> json) {
    return DeptBranchModel(
      departments: json['department'],
      branches: json['branch'],
    );
  }
}
