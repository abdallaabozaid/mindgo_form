class FormModel {
  String name;
  String email;
  String phone;
  String companyName;
  List<String> products;

  FormModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.companyName,
      required this.products});
}
