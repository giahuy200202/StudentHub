import 'package:flutter_riverpod/flutter_riverpod.dart';

class Company {
  int? id;
  String? companyName;
  String? website;
  String? description;
  String? email;
  int? size;

  Company({
    this.id,
    this.companyName,
    this.website,
    this.description,
    this.email,
    this.size,
  });
}

class CompanyNotifier extends StateNotifier<Company> {
  CompanyNotifier() : super(Company(
            // id: 0,
            // companyName: '',
            // website: '',
            // description: '',
            // email: '',
            // size: 0,
            ));

  void setCompanyData(int id, String companyName, String website, String description, String email, int size) {
    Company temp = Company(
      id: state.id,
      companyName: state.companyName,
      website: state.website,
      description: state.description,
      email: state.email,
      size: state.size,
    );
    temp.id = id;
    temp.companyName = companyName;
    temp.website = website;
    temp.description = description;
    temp.size = size;
    temp.email = email;
    state = temp;
  }
}

final companyProvider = StateNotifierProvider<CompanyNotifier, Company>((ref) => CompanyNotifier());
