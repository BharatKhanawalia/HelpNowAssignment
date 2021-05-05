class FormData {
  int id;
  String name;
  String mobile;
  String productType;
  String amount;
  String amountType;
  DateTime date;
  String printDate;
  // String image;

  formMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['mobile'] = mobile;
    mapping['productType'] = productType;
    mapping['amount'] = amount;
    mapping['amountType'] = amountType;
    mapping['date'] = '${date.day}/${date.month}/${date.year}';
    // mapping['image'] = image;
    return mapping;
  }
}
