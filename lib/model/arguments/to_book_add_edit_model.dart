import 'package:spa_project/model/response/model_list_book_calendar.dart' as book;
import 'package:spa_project/model/response/model_list_customer.dart' as custom;

class ToBookAddEditModel {
  book.Data? dataBook;
  DateTime? dateTime;
  custom.Data? dataCustom;

  ToBookAddEditModel({
    this.dataBook,
    this.dataCustom,
    this.dateTime
  });
}