import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:spa_project/base_project/package.dart';

class ReqAddEditService {
  int? id;
  String? name;
  int? idCategory;
  String? description;
  int? price;
  int? status;
  int? duration;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? commissionAffiliateFix;
  int? commissionAffiliatePercent;
  File? image;
  String? code;

  ReqAddEditService(
      {this.id,
        this.name,
        this.idCategory,
        this.description,
        this.price,
        this.status,
        this.duration,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.commissionAffiliateFix,
        this.image,
        this.code,
        this.commissionAffiliatePercent});

  ReqAddEditService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idCategory = json['id_category'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    duration = json['duration'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    commissionAffiliateFix = json['commission_affiliate_fix'];
    commissionAffiliatePercent = json['commission_affiliate_percent'];
    image = json['image'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['id_category'] = idCategory;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['duration'] = duration;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['commission_affiliate_fix'] = commissionAffiliateFix;
    data['commission_affiliate_percent'] = commissionAffiliatePercent;
    data['image'] = image;
    data['code'] = code;
    return data;
  }
}

extension ReqAddEditServiceFormData on ReqAddEditService {
  FormData toFormData() {
    final map = {
      'commission_staff_percent': commissionStaffPercent,
      'commission_affiliate_percent': commissionAffiliatePercent,
      'duration': duration,
      'status': status,
      'name': name,
      'id': id,
      'commission_affiliate_fix': commissionAffiliateFix,
      'commission_staff_fix': commissionStaffFix,
      'description': description,
      'id_category': idCategory,
      'price': price,
      'code': code,
    };

    final formData = FormData.fromMap(map);

    if (image != null && image!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(
          image!.path,
          filename: image!.path.split('/').last,
          contentType: MediaType("image", "jpeg"),
        ),
      ));
    }

    return formData;
  }
}

