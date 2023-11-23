class GetAllProjectsResponseModel {
  GetAllProjectsResponseModel({
    required this.status,
    required this.message,
    required this.response,
  });
  late final int status;
  late final String message;
  late final List<AllProjectsResponse> response;

  GetAllProjectsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = List.from(json['response'])
        .map((e) => AllProjectsResponse.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['response'] = response.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AllProjectsResponse {
  AllProjectsResponse({
    required this.id,
    required this.title,
    required this.clientId,
    required this.pocId,
    required this.countryId,
    required this.cityId,
    required this.projectBillingId,
    required this.contactPersonNo,
    required this.contactPersonEmail,
    required this.officialNo,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.projectDuration,
    required this.projectBudget,
    required this.billingDate,
    required this.variableBilling,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.client,
    required this.clientPoc,
    required this.isNew,
    required this.sameAsClient,
    this.newPoc,
  });
  late final int id;
  late final String title;
  late final int clientId;
  late final int pocId;
  late final int countryId;
  late final int cityId;
  late final int projectBillingId;
  late final String contactPersonNo;
  late final String contactPersonEmail;
  late final String officialNo;
  late final String projectStartDate;
  late final String projectEndDate;
  late final String projectDuration;
  late final String projectBudget;
  late final int billingDate;
  late final bool variableBilling;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;
  late final Client client;
  late final ClientPoc clientPoc;
  late final bool isNew;
  late final bool sameAsClient;
  late final Null newPoc;

  AllProjectsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    clientId = json['client_id'];
    pocId = json['poc_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    projectBillingId = json['project_billing_id'];
    contactPersonNo = json['contact_person_no'];
    contactPersonEmail = json['contact_person_email'];
    officialNo = json['official_no'];
    projectStartDate = json['project_start_date'];
    projectEndDate = json['project_end_date'];
    projectDuration = json['project_duration'];
    projectBudget = json['project_budget'];
    billingDate = json['billing_date'];
    variableBilling = json['variable_billing'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    client = Client.fromJson(json['client']);
    clientPoc = ClientPoc.fromJson(json['client_poc']);
    isNew = json['is_new'];
    sameAsClient = json['same_as_client'];
    newPoc = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['client_id'] = clientId;
    _data['poc_id'] = pocId;
    _data['country_id'] = countryId;
    _data['city_id'] = cityId;
    _data['project_billing_id'] = projectBillingId;
    _data['contact_person_no'] = contactPersonNo;
    _data['contact_person_email'] = contactPersonEmail;
    _data['official_no'] = officialNo;
    _data['project_start_date'] = projectStartDate;
    _data['project_end_date'] = projectEndDate;
    _data['project_duration'] = projectDuration;
    _data['project_budget'] = projectBudget;
    _data['billing_date'] = billingDate;
    _data['variable_billing'] = variableBilling;
    _data['is_active'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['client'] = client.toJson();
    _data['client_poc'] = clientPoc.toJson();
    _data['is_new'] = isNew;
    _data['same_as_client'] = sameAsClient;
    _data['new_poc'] = newPoc;
    return _data;
  }
}

class Client {
  Client({
    required this.id,
    this.businessTypeId,
    required this.countryId,
    required this.cityId,
    this.organizationTypeId,
    required this.name,
    required this.primaryEmail,
    required this.secondaryEmail,
    required this.primaryContactNo,
    this.secondaryContactNo,
    this.landlineNo,
    required this.postalCode,
    required this.asIndividual,
    this.ntnNo,
    this.strnNo,
    this.incNo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final Null businessTypeId;
  late final int countryId;
  late final int cityId;
  late final Null organizationTypeId;
  late final String name;
  late final String primaryEmail;
  late final String secondaryEmail;
  late final String primaryContactNo;
  late final Null secondaryContactNo;
  late final Null landlineNo;
  late final int postalCode;
  late final bool asIndividual;
  late final Null ntnNo;
  late final Null strnNo;
  late final Null incNo;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessTypeId = null;
    countryId = json['country_id'];
    cityId = json['city_id'];
    organizationTypeId = null;
    name = json['name'];
    primaryEmail = json['primary_email'];
    secondaryEmail = json['secondary_email'];
    primaryContactNo = json['primary_contact_no'];
    secondaryContactNo = null;
    landlineNo = null;
    postalCode = json['postal_code'];
    asIndividual = json['as_individual'];
    ntnNo = null;
    strnNo = null;
    incNo = null;
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['business_type_id'] = businessTypeId;
    _data['country_id'] = countryId;
    _data['city_id'] = cityId;
    _data['organization_type_id'] = organizationTypeId;
    _data['name'] = name;
    _data['primary_email'] = primaryEmail;
    _data['secondary_email'] = secondaryEmail;
    _data['primary_contact_no'] = primaryContactNo;
    _data['secondary_contact_no'] = secondaryContactNo;
    _data['landline_no'] = landlineNo;
    _data['postal_code'] = postalCode;
    _data['as_individual'] = asIndividual;
    _data['ntn_no'] = ntnNo;
    _data['strn_no'] = strnNo;
    _data['inc_no'] = incNo;
    _data['is_active'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class ClientPoc {
  ClientPoc({
    required this.id,
    required this.clientId,
    required this.name,
    required this.primaryEmail,
    required this.secondaryEmail,
    required this.isMain,
    required this.primaryContactNo,
    this.secondaryContactNo,
    required this.postalCode,
    this.designation,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int clientId;
  late final String name;
  late final String primaryEmail;
  late final String secondaryEmail;
  late final bool isMain;
  late final String primaryContactNo;
  late final String? secondaryContactNo;
  late final String postalCode;
  late final String? designation;
  late final bool isActive;
  late final String createdAt;
  late final String updatedAt;

  ClientPoc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    name = json['name'];
    primaryEmail = json['primary_email'];
    secondaryEmail = json['secondary_email'];
    isMain = json['is_main'];
    primaryContactNo = json['primary_contact_no'];
    secondaryContactNo = null;
    postalCode = json['postal_code'];
    designation = null;
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['client_id'] = clientId;
    _data['name'] = name;
    _data['primary_email'] = primaryEmail;
    _data['secondary_email'] = secondaryEmail;
    _data['is_main'] = isMain;
    _data['primary_contact_no'] = primaryContactNo;
    _data['secondary_contact_no'] = secondaryContactNo;
    _data['postal_code'] = postalCode;
    _data['designation'] = designation;
    _data['is_active'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}
