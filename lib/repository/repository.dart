part of 'repository_part.dart';

mixin class Repository {
  final ServiceNetwork _service = ServiceNetwork(baseUrl: MyConfig.BASE_URL);

  /// Đăng ký tài khoản
  Future<Result<ModelCreateMember>> createMemberAPI(ResCreateMember body) async {
    return await _service.post<ModelCreateMember>(
        endpoint: "/createMemberAPI",
        data: body.toJson(),
        fromJson: (json) => ModelCreateMember.fromJson(json),
    );
  }

  /// Đăng nhập tài khoản
  Future<Result<ModelUser>> loginAPI(ReqLogin body) async {
    return await _service.post(
        endpoint: "/loginAPI",
        data: body.toJson(),
        fromJson: (json) => ModelUser.fromJson(json),
    );
  }

  /// Lấy thông tin tài khoản của tài khoản đăng nhập
  Future<Result<ModelMyInfo>> getInfoMyAPI() async {
    return await _service.post<ModelMyInfo>(
        endpoint: "/getInfoMyAPI",
        fromJson: (json) => ModelMyInfo.fromJson(json),
        withToken: true
    );
  }

  /// Đăng xuất tài khoản
  Future<Result<ModelLogout>> logoutAPI() async {
    return await _service.post(
        endpoint: "/logoutAPI",
        withToken: true,
        fromJson: (json) => ModelLogout.fromJson(json),
    );
  }

  /// Lấy Otp lấy lại mật khẩu
  Future<Result<int>> requestCodeOtpForgotPassAPI(String number) async {
    return await _service.post(
        endpoint: "/requestCodeForgotPasswordAPI",
        data: {"phone": number},
        fromJson: (json) => json['code'] as int,
    );
  }

  /// Kiểm tra OTP có đúng hay không
  Future<Result<int>> checkCodeOtAPI(String phone, String code) async {
    return await _service.post(
        endpoint: "/checkCodeOtAPI",
        data: {"phone": phone, "code": code},
        fromJson: (json) => json['code'] as int,
    );
  }

  /// Tạo lại mật khẩu mới
  Future<Result<int>> saveNewPassAPI(ReqNewPass body) async {
    return await _service.post(
        endpoint: "/saveNewPassAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
    );
  }

  /// Thay đổi mật khẩu mới
  Future<Result<ModelMyInfo>> changePasswordApi(ReqChangePassModel body) async {
    return await _service.post(
        endpoint: "/changePasswordApi",
        data: body.toJson(),
        fromJson: (json) => ModelMyInfo.fromJson(json),
        withToken: true
    );
  }

  /// Thay đổi thông tin người dùng tài khoản
  Future<Result<ModelMyInfo>> saveInfoMemberAPI(ReqChangeMyInfo body) async {
    return await _service.post(
        endpoint: "/saveInfoMemberAPI",
        data: body.toJson(),
        fromJson: (json) => ModelMyInfo.fromJson(json),
        withToken: true
    );
  }

  /// Lấy danh sách thống kê
  Future<Result<ModelBusinessReport>> businessReportAPI() async {
    return await _service.post(
        endpoint: "/businessReportAPI",
        fromJson: (json) => ModelBusinessReport.fromJson(json),
        withToken: true
    );
  }

  /// khóa tài khoản người dùng
  Future<Result<int>> lockMemberAPI() async {
    return await _service.post(
        endpoint: "/lockMemberAPI",
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy danh sách khác đặt lịch
  Future<Result<ModelListBook>> listBookAPI(ReqListBook request) async {
    return await _service.post(
        endpoint: "/listBookAPI",
        data: request.toJson(),
        fromJson: (json) => ModelListBook.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh sách danh mục khách hàng
  Future<Result<ModelCategoryCustomer>> listCategoryCustomerAPI(int page) async {
    return await _service.post(
        endpoint: "/listCategoryCustomerAPI",
        data: {"page": page },
        fromJson: (json) => ModelCategoryCustomer.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh sách nguồn khách hàng
  Future<Result<ModelListSourceCustom>> listSourceCustomerAPI(int page) async {
    return await _service.post(
        endpoint: "/listSourceCustomerAPI",
        data: {"page": page },
        fromJson: (json) => ModelListSourceCustom.fromJson(json),
        withToken: true
    );
  }

  /// Lấy danh sách khách hàng
  Future<Result<ModelListCustomer>> listCustomerAPI(ReqListCustomer request) async {
    return await _service.post(
        endpoint: "/listCustomerAPI",
        data: request.toJson(),
        fromJson: (json) => ModelListCustomer.fromJson(json),
        withToken: true
    );
  }

  /// Lấy Chi tiết thông tin khách hàng
  Future<Result<ModelDetailCustomer>> detailCustomerAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailCustomerAPI",
        data: {"id": id},
        fromJson: (json) => ModelDetailCustomer.fromJson(json),
        withToken: true
    );
  }

  /// Thông kê danh thu trong tháng
  Future<Result<ModelStatisticalTimeLine>> bilStatisticalAPI() async {
    return await _service.post(
        endpoint: "/biilStatisticalAPI",
        fromJson: (json) => ModelStatisticalTimeLine.fromJson(json),
        withToken: true
    );
  }

  /// Thông kê dịch vụ trong tháng
  Future<Result<ModelStatisticalTimeLine>> userServicestatisticalAPI() async {
    return await _service.post(
        endpoint: "/userServicestatisticalAPI",
        // data: {"id": id},
        fromJson: (json) => ModelStatisticalTimeLine.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa khách hàng mới
  Future<Result<ModelCreateEditCustomer>> addCustomerApi(ReqCreateEditCustomer body) async {
    return await _service.post(
        endpoint: "/addCustomerApi",
        data: body.toJson(),
        fromJson: (json) => ModelCreateEditCustomer.fromJson(json),
        withToken: true
    );
  }

  /// Xóa khách hàng
  Future<Result<int>> deleteCustomerAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteCustomerAPI",
        data: {"id": id},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// xóa nguồn khách hàng
  Future<Result<int>> deleteSourceCustomerAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteSourceCustomerAPI",
        data: {"id": id},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy danh sách spa
  Future<Result<ModelListSpa>> listSpaAPI() async {
    return await _service.post(
        endpoint: "/listSpaAPI",
        fromJson: (json) => ModelListSpa.fromJson(json),
        withToken: true
    );
  }

  /// Chi tiết Spa
  Future<Result<ModelDetailSpa>> detailSpaAPI(int id) async {
    return await _service.post(
        data: {"id": id},
        endpoint: "/detailSpaAPI",
        fromJson: (json) => ModelDetailSpa.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa spa
  Future<Result<ModelAddEditSpa>> addSpaAPI(ReqAddEditSpa request) async {
    return await _service.post(
        data: request.toJson(),
        endpoint: "/addSpaAPI",
        fromJson: (json) => ModelAddEditSpa.fromJson(json),
        withToken: true
    );
  }

  /// Danh sách khách đặt lịch theo lịch
  Future<Result<ModelListBookCalendar>> listBookCalendarAPI(ReqListBookCalendar request) async {
    return await _service.post(
        data: request.toJson(),
        endpoint: "/listBookCalendarAPI",
        fromJson: (json) => ModelListBookCalendar.fromJson(json),
        withToken: true
    );
  }

  /// Danh sách nhân viên
  Future<Result<ModelListStaff>> listStaffAPI(ReqGetListStaff request) async {
    return await _service.post(
        data: request.toJson(),
        endpoint: "/listStaffAPI",
        fromJson: (json) => ModelListStaff.fromJson(json),
        withToken: true
    );
  }

  /// Danh sách giường
  Future<Result<ModelListBed>> listBedAPI() async {
    return await _service.post(
        endpoint: "/listBedAPI",
        fromJson: (json) => ModelListBed.fromJson(json),
        withToken: true
    );
  }

  /// Danh sách dịch vụ
  Future<Result<ModelListService>> listServiceAPI(ReqGetListService request) async {
    return await _service.post(
        data: request.toJson(),
        endpoint: "/listServiceAPI",
        fromJson: (json) => ModelListService.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh mục dịch vụ
  Future<Result<ModelListCategoryService>> listCategoryServiceAPI() async {
    return await _service.post(
        endpoint: "/listCategoryServiceAPI",
        fromJson: (json) => ModelListCategoryService.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh sach phòng
  Future<Result<ModelListRoom>> listRoomAPI() async {
    return await _service.post(
        endpoint: "/listRoomAPI",
        fromJson: (json) => ModelListRoom.fromJson(json),
        withToken: true
    );
  }

  /// tìm kiếm khách hàng
  Future<Result<ModelListCustomer>> searchCustomersApi(String? key) async {
    return await _service.post(
        endpoint: "/searchCustomersApi",
        data: {"key": key},
        fromJson: (json) => ModelListCustomer.fromJson(json),
        withToken: true
    );
  }

  /// thêm lịch hẹn
  Future<Result<ModelAddEditBook>> addBookAPI(ReqAddEditBook body) async {
    return await _service.post(
        endpoint: "/addBookAPI",
        data: body.toJson(),
        fromJson: (json) => ModelAddEditBook.fromJson(json),
        withToken: true
    );
  }

  /// Lấy chi tiết lịch hẹn
  Future<Result<ModelDetailBookCalendar>> detailBookAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailBookAPI",
        data: {"id": id },
        fromJson: (json) => ModelDetailBookCalendar.fromJson(json),
        withToken: true
    );
  }

  /// check - in
  Future<Result<int>> checkinbetBookAPI(ReqCheckInBook body) async {
    return await _service.post(
        endpoint: "/checkinbetBookAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// check - out
  Future<Result<int>> checkoutBedAPI(int? id, String? timeCheckout) async {
    return await _service.post(
        endpoint: "/checkoutBedAPI",
        data: {"id": id, "time_checkout": timeCheckout},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// xoa lich hen
  Future<Result<int>> deleteBookAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteBookAPI",
        data: {"id": id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách nhóm nhân viên
  Future<Result<ModelGroupStaff>> listGroupStaffAPI(int page) async {
    return await _service.post(
        endpoint: "/listGroupStaffAPI",
        data: {"page": page },
        fromJson: (json) => ModelGroupStaff.fromJson(json),
        withToken: true
    );
  }

  /// lấy chi tiết nhân viên
  Future<Result<ModelDetailStaff>> detailStaffAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailStaffAPI",
        data: {"id": id },
        fromJson: (json) => ModelDetailStaff.fromJson(json),
        withToken: true
    );
  }

  /// Khóa tài khoản nhân viên
  Future<Result<int>> lockStaffAPI(int? id, int status) async {
    return await _service.post(
        endpoint: "/lockStaffAPI",
        data: {"id": id, "status": status },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thêm và sửa nhân viên
  Future<Result<int>> addStaffAPI(ReqAddEditStaff request) async {
    return await _service.post(
        endpoint: "/addStaffAPI",
        data: request.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy lanh sách quyền hạnh
  Future<Result<ModelListPermission>> getListPermissionAPI() async {
    return await _service.post(
        endpoint: "/getListPermissionAPI",
        fromJson: (json) => ModelListPermission.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa nhóm nhân viên
  Future<Result<int>> addGroupStaffAPI(int? id, String? name) async {
    return await _service.post(
        endpoint: "/addGroupStaffAPI",
        data: {"id": id, "name": name},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// xóa nhóm nhân viên
  Future<Result<int>> deteleGroupStaffAPI(int? id) async {
    return await _service.post(
        endpoint: "/deteleGroupStaffAPI",
        data: {"id": id},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách ngân hàng
  Future<Result<List<ModelListBanking>>> getLinstBank() async {
    return await _service.post(
        endpoint: "/getLinstBank",
        fromJson: (json) => (json as List).map((e) => ModelListBanking.fromJson(e)).toList(),
    );
  }

  /// thêm sưa thông tin phòng
  Future<Result<int>> addRoomAPI({int? id, String? name}) async {
    return await _service.post(
        endpoint: "/addRoomAPI",
        data: {"id": id, "name": name},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa phòng
  Future<Result<int>> deleteRoomAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteRoomAPI",
        data: {"id": id},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa giường
  Future<Result<int>> deleteBedAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteBedAPI",
        data: {"id": id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Thêm sửa thông tin giường
  Future<Result<int>> addBedAPI({int? id, String? name, int? idRoom}) async {
    return await _service.post(
        endpoint: "/addBedAPI",
        data: {"id": id, "name": name, "id_room": idRoom},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Thêm sưa danh mục dịch vụ
  Future<Result<int>> addCategoryServiceAPI({int? id, String? name}) async {
    return await _service.post(
        endpoint: "/addCategoryServiceAPI",
        data: {"id": id, "name": name },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa danh mục dịch vụ
  Future<Result<int>> deleteCategoryServiceAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteCategoryServiceAPI",
        data: {"id": id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy chi tiết dịch vụ
  Future<Result<ModelDetailService>> detailServiceAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailServiceAPI",
        data: {"id": id },
        fromJson: (json) => ModelDetailService.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sưa thông tin dịch vụ
  Future<Result<int>> addServiceAPI(ReqAddEditService request) async {
    return await _service.postFormData(
      endpoint: "/addServiceAPI",
      data: request.toFormData(),
      fromJson: (json) => json['code'] as int,
      withToken: true,
    );
  }

  /// Xóa dịch vụ
  Future<Result<int>> deleteServiceAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteServiceAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// gia hạn băng pay Apple
  Future<Result<int>> addMoneyApplePayAPI(String? purchaseID, String? productId) async {
    return await _service.post(
        endpoint: "/addMoneyApplePayAPI",
        data: {"purchaseID": purchaseID, "productId": productId },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Gia hạn tài khoản bằng payos
  Future<Result<ModelPayExtendMember>> payExtendMemberAPI(int? year) async {
    return await _service.post(
        endpoint: "/payExtendMemberAPI",
        data: {"year": year },
        fromJson: (json) => ModelPayExtendMember.fromJson(json),
        withToken: true
    );
  }

  /// Lấy danh sách đơn sản phẩm
  Future<Result<ModelListOrderProduct>> listOrderProductAPI(ReqListOrderProduct body) async {
    return await _service.post(
        endpoint: "/listOrderProductAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListOrderProduct.fromJson(json),
        withToken: true
    );
  }

  /// Lấy chi tiết đơn sản phẩm
  Future<Result<ModelOrderProductDetail>> detailOrderProductAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailOrderProductAPI",
        data: {"id" : id},
        fromJson: (json) => ModelOrderProductDetail.fromJson(json),
        withToken: true
    );
  }

  /// danh sách đơn combo liệu trình
  Future<Result<ModelOrderCombo>> listOrderComboAPI(int? page) async {
    return await _service.post(
        endpoint: "/listOrderComboAPI",
        data: {"page" : page},
        fromJson: (json) => ModelOrderCombo.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh sách danh mục sản phẩm
  Future<Result<ModelListCateProduct>> listCategoryProductAPI(int page) async {
    return await _service.post(
        endpoint: "/listCategoryProductAPI",
        data: {"page" : page },
        fromJson: (json) => ModelListCateProduct.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa danh mục sản phẩm
  Future<Result<int>> addCategoryProductAPI({int? id, String? name}) async {
    return await _service.post(
        endpoint: "/addCategoryProductAPI",
        data: {"id" : id, "name": name },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa danh mục sản phẩm
  Future<Result<int>> deleteCategoryProductAPI({int? id}) async {
    return await _service.post(
        endpoint: "/deleteCategoryProductAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy danh sách nhãn hiệu
  Future<Result<ModelListTrademark>> listTrademarkProductAPI(int page) async {
    return await _service.post(
        endpoint: "/listTrademarkProductAPI",
        data: {"page" : page },
        fromJson: (json) => ModelListTrademark.fromJson(json),
        withToken: true
    );
  }
  /// Thêm sửa nhãn hiệu
  Future<Result<int>> addTrademarkProductAPI({int? id, String? name, String? description}) async {
    return await _service.post(
        endpoint: "/addTrademarkProductAPI",
        data: {"id" : id, "name": name, "description": description },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa nhãn hiệu
  Future<Result<int>> deleteTrademarkProductAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteTrademarkProductAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy danh sách sản phẩn
  Future<Result<ModelListProduct>> listProductAPI(ReqListProduct body) async {
    return await _service.post(
        endpoint: "/listProductAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListProduct.fromJson(json),
        withToken: true
    );
  }

  /// thêm sửa sản phẩm
  Future<Result<int>> addProductAPI(ReqCreateProduct body) async {
    return await _service.post(
        endpoint: "/addProductAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// xóa sản phầm
  Future<Result<int>> deleteProductAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteProductAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách gói gia hạn android
  Future<Result<List<ModelListPriceExtend>>> listpriceExtendAPI() async {
    return _service.post(
      endpoint: "/listpriceExtendAPI",
      withToken: true,
      fromJson: (json) => (json as Map<String, dynamic>)
          .entries
          .map((e) => ModelListPriceExtend(yer: int
          .tryParse(e.key), price: e.value))
          .toList(),
    );
  }

  /// thêm sửa danh mục
  Future<Result<int>> addCategoryCustomerAPI({int? id, String? name}) async {
    return await _service.post(
        endpoint: "/addCategoryCustomerAPI",
        data: {"id" : id, "name": name },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa danh mục khách hàng
  Future<Result<int>> deleteCategoryCustomerAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteCategoryCustomerAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thêm và sửa nguồn khách hàng
  Future<Result<int>> addSourceCustomerAPI({int? id, String? name}) async {
    return await _service.post(
        endpoint: "/addSourceCustomerAPI",
        data: {"id" : id, "name": name },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// tạo đơn sản phẩm
  Future<Result<int>> createOrderProductAPI(ReqCreateOrder body) async {
    return await _service.post(
        endpoint: "/createOrderProductAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// tạo đơn sản phẩm
  Future<Result<int>> createOrderServiceAPI(ReqCreateOrder body) async {
    return await _service.post(
        endpoint: "/createOrderServiceAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Tạo đơn Combo lịch trình
  Future<Result<int>> createComboAPI(ReqCreateOrder body) async {
    return await _service.post(
        endpoint: "/createComboAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách đơn dịch vụ
  Future<Result<ModelOrderService>> listOrderServiceAPI(int page) async {
    return await _service.post(
        endpoint: "/listOrderServiceAPI",
        data: {"page" : page },
        fromJson: (json) => ModelOrderService.fromJson(json),
        withToken: true
    );
  }

  /// Lấy danh sách kho
  Future<Result<ModelListRepo>> listWarehouseAPI(int? page) async {
    return await _service.post(
        endpoint: "/listWarehouseAPI",
        data: {"page" : page },
        fromJson: (json) => ModelListRepo.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa kho
  Future<Result<int>> addWarehouseAPI({int? id, String? name, String? description}) async {
    return await _service.post(
        endpoint: "/addWarehouseAPI",
        data: {"id" : id, "name": name, "description": description },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa kho hàng
  Future<Result<int>> deleteWarehouseAPI(int? id) async {
    return await _service.post(
        endpoint: "/deleteWarehouseAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách lịch sử nhập kho
  Future<Result<ModelWarehouseHistory>> importHistorytWarehouseAPI(ReqWarehouseHistory body) async {
    return await _service.post(
        endpoint: "/importHistorytWarehouseAPI",
        data: body.toJson(),
        fromJson: (json) => ModelWarehouseHistory.fromJson(json),
        withToken: true
    );
  }

  /// lấy Danh sách đối tác
  Future<Result<ModelListPartner>> listPartnerAPI(int? page) async {
    return await _service.post(
        endpoint: "/listPartnerAPI",
        data: {"page": page },
        fromJson: (json) => ModelListPartner.fromJson(json),
        withToken: true
    );
  }

  /// lấy Danh sách đối tác
  Future<Result<int>> addPartnerAPI(ReqAEPartner body) async {
    return await _service.post(
        endpoint: "/addPartnerAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// xóa đối tác
  Future<Result<int>> deletePartnerAPI(int? id) async {
    return await _service.post(
        endpoint: "/deletePartnerAPI",
        data: {"id": id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy chi tiết đơn dịch vụ
  Future<Result<ModelDetailOrderService>> detailOrderServiceAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailOrderServiceAPI",
        data: {"id": id },
        fromJson: (json) => ModelDetailOrderService.fromJson(json),
        withToken: true
    );
  }

  /// Nhập sản phẩm vào kho
  Future<Result<int>> addProductWarehouseAPI(ReqImportProduct body) async {
    return await _service.post(
        endpoint: "/addProductWarehouseAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// danh sách phòng và giường
  Future<Result<ModelDiagramRoomBed>> listRoomBedAPI() async {
    return await _service.post(
        endpoint: "/listRoomBedAPI",
        fromJson: (json) => ModelDiagramRoomBed.fromJson(json),
        withToken: true
    );
  }

  /// danh sách phòng và giường
  Future<Result<int>> cancelBedAPI(int? id) async {
    return await _service.post(
        endpoint: "/cancelBedAPI",
        data: {"id": id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy danh sách Combo liệu trình
  Future<Result<ModelListCombo>> listComboAPI(int? page) async {
    return await _service.post(
        endpoint: "/listComboAPI",
        data: {"page": page },
        fromJson: (json) => ModelListCombo.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa combo
  Future<Result<int>> addComboAPI(ReqAddEditCombo body) async {
    return await _service.post(
        endpoint: "/addComboAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Danh sách công nợ phải thu
  Future<Result<ModelDebtCollection>> listCollectionDebtAPI(ReqDebtCollection body) async {
    return await _service.post(
        endpoint: "/listCollectionDebtAPI",
        data: body.toJson(),
        fromJson: (json) => ModelDebtCollection.fromJson(json),
        withToken: true
    );
  }

  /// thanh toán công nợ phải thu
  Future<Result<int>> paymentCollectionBillAPI(ReqPaymentCollection body) async {
    return await _service.post(
        endpoint: "/paymentCollectionBillAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thanh toán công phải trả
  Future<Result<int>> paymentBillAPI(ReqPaymentCollection body) async {
    return await _service.post(
        endpoint: "/paymentBillAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy Danh sách thẻ trả trước
  Future<Result<ModelPrepaidCard>> listPrepayCardAPI(int page) async {
    return await _service.post(
        endpoint: "/listPrepayCardAPI",
        data: {"page": page },
        fromJson: (json) => ModelPrepaidCard.fromJson(json),
        withToken: true
    );
  }

  /// Thêm sửa thẻ trả trước
  Future<Result<int>> addPrepayCardAPI(ReqAddPrepaidCard body) async {
    return await _service.post(
        endpoint: "/addPrepayCardAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Xóa thẻ trả trước
  Future<Result<int>> deletePrepayCardAPI(int? id) async {
    return await _service.post(
        endpoint: "/deletePrepayCardAPI",
        data: {"id" : id },
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy danh sách thưởng và phạt
  Future<Result<ModelStaffBonus>> listStaffBonusAPI(ReqStaffBonus body) async {
    return await _service.post(
        endpoint: "/listStaffBonusAPI",
        data: body.toJson(),
        fromJson: (json) => ModelStaffBonus.fromJson(json),
        withToken: true
    );
  }

  /// thêm và sử tiên thưởn phạt
  Future<Result<int>> addStaffBonusAPI(ReqAddBonusPunish body) async {
    return await _service.post(
        endpoint: "/addStaffBonusAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// danh sách chấm công
  Future<Result<ModelTimeSheet>> listTimesheetAPI(ReqTimesheet body) async {
    return await _service.post(
        endpoint: "/listTimesheetAPI",
        data: body.toJson(),
        fromJson: (json) => ModelTimeSheet.fromJson(json),
        withToken: true
    );
  }

  /// thanh toán tiên tưởng của nhân viên
  Future<Result<int>> payBonusAPI({int? id, String? type}) async {
    return await _service.post(
        endpoint: "/payBonusAPI",
        data: {"id": id, "type_collection_bill": type},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy danh sách hoa hồng nhân viên
  Future<Result<ModelListAgency>> listAgencyAPI(ReqAgency body) async {
    return await _service.post(
        endpoint: "/listAgencyAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListAgency.fromJson(json),
        withToken: true
    );
  }

  /// thanh thoán tiền hoa hồng
  Future<Result<int>> payAgencyAPI({int? id, String? type}) async {
    return await _service.post(
        endpoint: "/payAgencyAPI",
        data: {"id": id, "type_collection_bill": type},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// chấm công
  Future<Result<int>> checktimesheetAPI({String? shift, int? idStaff, String? date}) async {
    return await _service.post(
        endpoint: "/checktimesheetAPI",
        data: {"shift": shift, "id_staff": idStaff, "date": date},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thêm công nợ phải thu
  Future<Result<int>> addCollectionDebtAPI(ReqAddDebtCollection body) async {
    return await _service.post(
        endpoint: "/addCollectionDebtAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thêm công nợ phải trả
  Future<Result<int>> addPayableDebtAPI(ReqAddDebtCollection body) async {
    return await _service.post(
        endpoint: "/addPayableDebtAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// danh sách công nợ phải trả
  Future<Result<ModelDebtCollection>> listPayableDebtAPI(ReqDebtCollection body) async {
    return await _service.post(
        endpoint: "/listPayableDebtAPI",
        data: body.toJson(),
        fromJson: (json) => ModelDebtCollection.fromJson(json),
        withToken: true
    );
  }

  /// lấy bảng lương
  Future<Result<ModelTablePayRoll>> getpayrollstaffAPI(ReqPayRoll body) async {
    return await _service.post(
        endpoint: "/getpayrollstaffAPI",
        data: body.toJson(),
        fromJson: (json) => ModelTablePayRoll.fromJson(json),
        withToken: true
    );
  }

  /// danh sách bảng lương
  Future<Result<ModelListPayRoll>> listPayrollAPI(ReqPayRoll body) async {
    return await _service.post(
        endpoint: "/listPayrollAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListPayRoll.fromJson(json),
        withToken: true
    );
  }

  /// tính lương
  Future<Result<int>> addPayrollAPI(ReqAddPayroll body) async {
    return await _service.post(
        endpoint: "/addPayrollAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Phê duyện bảng lương
  Future<Result<int>> salaryVerificationAPI({int? id, String? status, String? note}) async {
    return await _service.post(
        endpoint: "/salaryVerificationAPI",
        data: {"note_boss": note, "id": id, "status": status},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// thanh toán lương
  Future<Result<int>> salaryPaymentAPI({int? id, String? type, int? idSpa}) async {
    return await _service.post(
        endpoint: "/salaryPaymentAPI",
        data: {"id": id, "type_collection_bill": type, "id_spa": idSpa},
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// lấy thông tin giường đang sử dụng dịch vụ
  Future<Result<ModelActiveBed>> infoRoomBedAPI(int? id) async {
    return await _service.post(
        endpoint: "/infoRoomBedAPI",
        data: {"id": id },
        fromJson: (json) => ModelActiveBed.fromJson(json),
        withToken: true
    );
  }

  /// Lấy danh sách đơn thẻ trả trước
  Future<Result<ModelOrderPrepaidCard>> listCustomerCardAPI({int? id, int? idCustomer}) async {
    return await _service.post(
        endpoint: "/listCustomerCardAPI",
        data: {"id": id, "id_customer": idCustomer },
        fromJson: (json) => ModelOrderPrepaidCard.fromJson(json),
        withToken: true
    );
  }

  /// Tạo đơn Combo lịch trình
  Future<Result<int>> buyPrepayCardAPI(ReqCreateOrder body) async {
    return await _service.post(
        endpoint: "/buyPrepayCardAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Tạo đơn Combo lịch trình
  Future<Result<ModelListCollectBill>> listCollectionBillAPI(ReqListCollectBill body) async {
    return await _service.post(
        endpoint: "/listCollectionBillAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListCollectBill.fromJson(json),
        withToken: true
    );
  }

  /// lấy danh sách phiếu chi
  Future<Result<ModelListSpendBill>> listBillAPI(ReqListCollectBill body) async {
    return await _service.post(
        endpoint: "/listBillAPI",
        data: body.toJson(),
        fromJson: (json) => ModelListSpendBill.fromJson(json),
        withToken: true
    );
  }

  /// Thêm mới phiếu thu
  Future<Result<int>> addCollectionBillAPI(ReqBillCollectAdd body) async {
    return await _service.post(
        endpoint: "/addCollectionBillAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Thêm mới phiếu chi
  Future<Result<int>> addBillAPI(ReqBillCollectAdd body) async {
    return await _service.post(
        endpoint: "/addBillAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

  /// Lấy chi tiết đơn combo liệu trình
  Future<Result<ModelDetailOrderCombo>> detailOrderComboAPI(int? id) async {
    return await _service.post(
        endpoint: "/detailOrderComboAPI",
        data: {"id" : id},
        fromJson: (json) => ModelDetailOrderCombo.fromJson(json),
        withToken: true
    );
  }

  /// Sử dụng đơn combo liệu trình
  Future<Result<int>> addUserServiceAPI(ReqUseCombo body) async {
    return await _service.post(
        endpoint: "/addUserServiceAPI",
        data: body.toJson(),
        fromJson: (json) => json['code'] as int,
        withToken: true
    );
  }

}