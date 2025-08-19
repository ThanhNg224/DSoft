enum ReservationStatus {
  pending,      // Chưa xác nhận
  confirmed,    // Xác nhận
  noShow,       // Không đến
  arrived,      // Đã đến
  cancelled,    // Hủy lịch
}

enum ClosedEnd {end, start}

enum OrderCreateInfoType {
  product,
  service,
  comboTreatment,
  prepaidCard,
}

