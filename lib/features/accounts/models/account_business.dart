class AccountBusiness {
  final String? name;
  final String? document;
  final String? description;
  final String? website;
  final String? address;
  final String? phone;
  final String? category;

  AccountBusiness({
    this.name,
    this.document,
    this.description,
    this.website,
    this.address,
    this.phone,
    this.category,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AccountBusiness &&
        other.name == name &&
        other.document == document &&
        other.description == description &&
        other.website == website &&
        other.address == address &&
        other.phone == phone &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        document.hashCode ^
        description.hashCode ^
        website.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        category.hashCode;
  }
}
