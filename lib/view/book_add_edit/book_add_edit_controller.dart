import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_book_add_edit_model.dart';
import 'package:spa_project/model/common/model_drop_dow_bed.dart';
import 'package:spa_project/model/common/model_drop_dow_service.dart';
import 'package:spa_project/model/common/model_drop_dow_staff.dart';
import 'package:spa_project/model/common/model_drop_dow_status.dart';
import 'package:spa_project/model/common/model_search_customer.dart';
import 'package:spa_project/model/request/req_add_edit_book.dart';
import 'package:spa_project/model/request/req_get_list_service.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/response/model_add_edit_book.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as list_bed;
import 'package:spa_project/model/response/model_list_category_service.dart' as category_service;
import 'package:spa_project/model/response/model_list_room.dart' as list_room;
import 'package:spa_project/model/response/model_list_service.dart' as list_service;
import 'package:spa_project/model/response/model_list_staff.dart' as list_staff;
import 'package:spa_project/view/book_add_edit/bloc/book_add_edit_bloc.dart';
import 'package:spa_project/view/book_add_edit/bloc/view_search_cubit.dart';
import 'package:spa_project/view/book_add_edit/view_search_customer.dart';

class BookAddEditController extends BaseController<ToBookAddEditModel> with Repository {
  BookAddEditController(super.context);

  Widget errorWidget = const SizedBox();
  late TextEditingController cEmail = TextEditingController();
  late TextEditingController cPhone = TextEditingController();
  late TextEditingController cNote = TextEditingController();
  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  List<ModelDropDowStaff> listStaffDrop = [];
  List<ModelDropDowStatus> statusDrop = [
    ModelDropDowStatus(name: "Chưa xác nhận", id: 0),
    ModelDropDowStatus(name: "Xác nhận", id: 1),
    ModelDropDowStatus(name: "Không đến", id: 2),
    ModelDropDowStatus(name: "Đã đến", id: 3),
    ModelDropDowStatus(name: "Hủy lịch", id: 4),
  ];

  ModelSearchCustomer nameCustomer = ModelSearchCustomer();
  DateTime dateTimeValue = DateTime.now();

  late GetListStaff listStaff = GetListStaff(this);
  late GetListBed listBed = GetListBed(this);
  late GetListService listService = GetListService(this);
  late GetListCategoryService categoryService = GetListCategoryService(this);
  late GetListRoom listRoom = GetListRoom(this);

  @override
  void onDispose() {
    cEmail.dispose();
    cPhone.dispose();
    cNote.dispose();
    super.onDispose();
  }

  @override
  void onInitState() {
    onGetMultiApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(args?.dateTime != null) dateTimeValue = args?.dateTime ?? DateTime.now();
      if(args?.dataBook != null) {
        final data = args?.dataBook;
        final bloc = context.read<BookAddEditBloc>();
        nameCustomer = ModelSearchCustomer(
            phone: data?.phone,
            email: data?.email,
            name: data?.name,
            id: data?.idCustomer
        );
        cPhone = TextEditingController(text: data?.phone);
        cEmail = TextEditingController(text: data?.email);
        cNote = TextEditingController(text:  data?.note);
        dateTimeValue = data?.timeBook?.toDateTime ?? DateTime.now();
        bloc.add(ChoseDropDowBookAddEditEvent(
            statusValue: ModelDropDowStatus(
                name: Utilities.statusCodeSpaToMes(args?.dataBook?.status),
                id: args?.dataBook?.status
            )
        ));
        bloc.add(SetBookingTypeBookAddEditEvent(
          isConsultation: data?.type1 == 1,
          isTreatmentPlan: data?.type4 == 1,
          isTherapy: data?.type3 == 1,
          isCare: data?.type2 == 1,
        ));
        bloc.add(SetTitleScreenBookAddEditEvent(
            titleButton: "Cập nhật",
            titleAppbar: "Sửa lịch hẹn"
        ));
      }
      if(args?.dataCustom != null) {
        final data = args?.dataCustom;
        nameCustomer = ModelSearchCustomer(
            phone: data?.phone,
            email: data?.email,
            name: data?.name,
            id: data?.id
        );
        cPhone = TextEditingController(text: data?.phone);
        cEmail = TextEditingController(text: data?.email);
      }
    });
    super.onInitState();
  }

  void onGetMultiApi() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => loadingFullScreen());
    setScreenState = screenStateLoading;
    final lists = await Future.wait([
      listStaff.perform(),
      listBed.perform(),
      listService.perform(),
      categoryService.perform(),
      listRoom.perform(),
    ]);
    for(var item in lists) {
      if(!item.isNotError) {
        hideLoading();
        setScreenState = screenStateError;
        errorWidget = item.logo;
        return;
      }
    }
    hideLoading();
    setScreenState = screenStateOk;
  }

  List<ModelDropDowService> serviceDrop() {
    final state = context.read<BookAddEditBloc>().state;
    List<category_service.Data> listCategory = List.from(state.listCateService);
    List<list_service.Data> listService = List.from(state.listService);
    List<ModelDropDowService> result = [];
    for (var category in listCategory) {
      List<list_service.Data> services = listService
          .where((service) => service.idCategory == category.id)
          .toList();
      if (services.isNotEmpty) {
        result.add(ModelDropDowService(name: category.name, id: category.id, isCategory: true));
        result.addAll(services.map((service) =>
            ModelDropDowService(name: service.name, id: service.id)));
      }
    }
    return result;
  }

  List<ModelDropDowBed> bedDrop() {
    final state = context.read<BookAddEditBloc>().state;
    List<list_room.Data> listRoom = List.from(state.listRoom);
    List<list_bed.Data> listBed = List.from(state.listBed);
    List<ModelDropDowBed> result = [];
    for (var category in listRoom) {
      List<list_bed.Data> bed = listBed
          .where((item) => item.idRoom == category.id)
          .toList();
      if (bed.isNotEmpty) {
        result.add(ModelDropDowBed(name: category.name, id: category.id, isCategory: true));
        result.addAll(bed.map((service) =>
            ModelDropDowBed(name: service.name, id: service.id)));
      }
    }
    return result;
  }

  void onOpenViewSearch() {
    Navigator.push(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, _, __) => BlocProvider(
        create: (_)=> ViewSearchCubit(),
        child: const ViewSearchCustomer(isLimitedByRegion: true),
      ),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    )).then((value) {
      if(value == null) return;
      final data = value as ModelSearchCustomer;
      nameCustomer.name = data.name ?? "";
      nameCustomer.id = data.id;
      cPhone = TextEditingController(text: data.phone);
      cEmail = TextEditingController(text: data.email);
      onTriggerEvent<BookAddEditBloc>().add(SetValidateBookAddEditEvent(vaName: ""));
    });
  }

  void onOpenSelectDateTime() async {
    DateTime? initTime = args?.dataBook?.timeBook?.toDateTime ?? args?.dateTime;
    final time = await dateTimePicker.open(context, initTime: initTime);
    dateTimeValue = time;
  }

  void onCreateEdit() => CreateEditDataBookAddEdit(this).perform();
}

class GetListStaff {
  final BookAddEditController _internal;
  GetListStaff(this._internal);
  
  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listStaffAPI(ReqGetListStaff());
    if(response is Success<list_staff.ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<list_staff.ModelListStaff>) {
      return ExceptionMultiApi.error(
        logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }
  
  void _onSuccess(List<list_staff.Data> listStaff) {
    _internal.context.read<BookAddEditBloc>().add(GetStaffBookAddEditEvent(listStaff));
    int index = listStaff.indexWhere((e) => e.id == _internal.args?.dataBook?.members?.id);
    for(var item in listStaff) {
      _internal.listStaffDrop.add(ModelDropDowStaff(
        id: item.id,
        name: item.name
      ));
    }
    if(index == -1) return;
    _internal.context.read<BookAddEditBloc>().add(ChoseDropDowBookAddEditEvent(
      staffValue: ModelDropDowStaff(
        name: listStaff[index].name,
        id: listStaff[index].id,
      )
    ));
  }
}

class GetListBed {
  final BookAddEditController _internal;
  GetListBed(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listBedAPI();
    if(response is Success<list_bed.ModelListBed>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<list_bed.ModelListBed>) {
      return ExceptionMultiApi.error(
        logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<list_bed.Data> listBed) {
    _internal.context.read<BookAddEditBloc>().add(GetBedBookAddEditEvent(listBed));
    int index = listBed.indexWhere((e) => e.id == _internal.args?.dataBook?.beds?.id);
    if(index == -1) return;
    _internal.context.read<BookAddEditBloc>().add(ChoseDropDowBookAddEditEvent(
      bedValue: ModelDropDowBed(
        id: listBed[index].id,
        name: listBed[index].name
      )
    ));
  }
}

class GetListService {
  final BookAddEditController _internal;
  GetListService(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listServiceAPI(ReqGetListService());
    if(response is Success<list_service.ModelListService>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<list_service.ModelListService>) {
      return ExceptionMultiApi.error(
        logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<list_service.Data> listService) {
    _internal.context.read<BookAddEditBloc>()
        .add(GetServiceBookAddEditEvent(listService));
    int index = listService.indexWhere((e) => e.id == _internal.args?.dataBook?.services?.id);
    if(index == -1) return;
    _internal.context.read<BookAddEditBloc>().add(ChoseDropDowBookAddEditEvent(
      serviceValue: ModelDropDowService(
        id: listService[index].id,
        name: listService[index].name,
      )
    ));
  }
}

class GetListCategoryService {
  final BookAddEditController _internal;
  GetListCategoryService(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listCategoryServiceAPI();
    if(response is Success<category_service.ModelListCategoryService>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
            logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<category_service.ModelListCategoryService>) {
      return ExceptionMultiApi.error(
          logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<category_service.Data> response) => _internal.context.read<BookAddEditBloc>().add(
    GetListCategoryServiceBookAddEditEvent(response)
  );
}

class GetListRoom {
  final BookAddEditController _internal;
  GetListRoom(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listRoomAPI();
    if(response is Success<list_room.ModelListRoom>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<list_room.ModelListRoom>) {
      return ExceptionMultiApi.error(
          logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<list_room.Data> response) => _internal.context.read<BookAddEditBloc>().add(
      GetListRoomBookAddEditEvent(response)
  );
}

class CreateEditDataBookAddEdit {
  final BookAddEditController _internal;
  CreateEditDataBookAddEdit(this._internal);

  ReqAddEditBook _request() {
    final state = _internal.context.read<BookAddEditBloc>().state;
    return ReqAddEditBook(
      phone: _internal.cPhone.text,
      idBed: state.bedValue?.id,
      id: _internal.args?.dataBook?.id,
      /// 1 là chọn
      /// 0 là không chọn
      idService: state.serviceValue?.id,
      type1: state.isConsultation ? 1 : 0, /// Lịch tư vấn
      type2: state.isCare ? 1 : 0, /// Lịch chăm sóc
      type3: state.isTreatmentPlan ? 1 : 0, /// Lịch liệu trình
      type4: state.isTherapy ? 1 : 0, /// Lịch điều trị
      idCustomer: _internal.nameCustomer.id,
      status: state.statusValue?.id,
      idStaff: state.staffValue?.id,
      timeBook: _internal.dateTimeValue.formatDateTime()
    );
  }

  bool _isValidate() {
    final state = _internal.context.read<BookAddEditBloc>().state;
    String vaName = _internal.nameCustomer.id == null ? "Vui lòng nhập tên khách hàng" : "";
    String vaPhone = _internal.cPhone.text.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    String vaBed = state.bedValue?.id == null ? "Vui lòng chọn phòng & giường" : "";
    String vaStaff = state.staffValue?.id == null ? "Vui lòng chọn nhân viên" : "";
    String vaService = state.serviceValue?.id == null ? "Vui lòng chọn dịch vụ" : "";
    _internal.context.read<BookAddEditBloc>().add(SetValidateBookAddEditEvent(
      vaName: vaName,
      vaPhone: vaPhone,
      vaBed: vaBed,
      vaStaff: vaStaff,
      vaService: vaService,
    ));
    return vaName.isEmpty && vaPhone.isEmpty && vaBed.isEmpty && vaStaff.isEmpty && vaService.isEmpty;
  }

  void perform() async {
    if(!_isValidate()) return;
    _internal.loadingFullScreen();
    final response = await _internal.addBookAPI(_request());
    if(response is Success<ModelAddEditBook>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.code);
      } else {
        _internal.hideLoading();
        _internal.popup(content: Utilities.errorMesWidget("Đã có lỗi xảy ra!"));
      }
    }
    if(response is Failure<ModelAddEditBook>) {
      _internal.hideLoading();
      _internal.popup(content: Utilities.errorCodeWidget(response.errorCode));
    }
    
  }
  
  void _onSuccess(int? value) {
    _internal.hideLoading();
    Navigator.pop(_internal.context, value);
    _internal.successSnackBar(message: "Bạn vừa đặt lịch thành công");
  }
}
