class ShiftForAddShiftModel {
    ShiftForAddShiftModel({
        required this.success,
        required this.message,
        required this.data,
        required this.currentPage,
        required this.nextPage,
        required this.previousPage,
        required this.pageSize,
    });

    final bool? success;
    final String? message;
    final List<DatumForAllShift> data;
    final int? currentPage;
    final dynamic nextPage;
    final dynamic previousPage;
    final int? pageSize;

    factory ShiftForAddShiftModel.fromJson(Map<String, dynamic> json){ 
        return ShiftForAddShiftModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<DatumForAllShift>.from(json["data"]!.map((x) => DatumForAllShift.fromJson(x))),
            currentPage: json["currentPage"],
            nextPage: json["nextPage"],
            previousPage: json["previousPage"],
            pageSize: json["pageSize"],
        );
    }

}

class DatumForAllShift {
    DatumForAllShift({
        required this.shiftId,
        required this.shiftName,
        required this.houseId,
        required this.shiftStartTime,
        required this.shiftEndTime,
        required this.isBeacon,
        required this.rowNum,
        required this.totalRows,
    });

    final int? shiftId;
    final String? shiftName;
    final int? houseId;
    final String? shiftStartTime;
    final String? shiftEndTime;
    final bool? isBeacon;
    final int? rowNum;
    final int? totalRows;

    factory DatumForAllShift.fromJson(Map<String, dynamic> json){ 
        return DatumForAllShift(
            shiftId: json["shiftId"],
            shiftName: json["shiftName"],
            houseId: json["houseId"],
            shiftStartTime: json["shiftStartTime"],
            shiftEndTime: json["shiftEndTime"],
            isBeacon: json["isBeacon"],
            rowNum: json["rowNum"],
            totalRows: json["totalRows"],
        );
    }

}
