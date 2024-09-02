class RequestedDspModel {
    RequestedDspModel({
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
    final List<RequestedDspDatum> data;
    final int? currentPage;
    final dynamic nextPage;
    final dynamic previousPage;
    final int? pageSize;

    factory RequestedDspModel.fromJson(Map<String, dynamic> json){ 
        return RequestedDspModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? [] : List<RequestedDspDatum>.from(json["data"]!.map((x) => RequestedDspDatum.fromJson(x))),
            currentPage: json["currentPage"],
            nextPage: json["nextPage"],
            previousPage: json["previousPage"],
            pageSize: json["pageSize"],
        );
    }

}

class RequestedDspDatum {
    RequestedDspDatum({
        required this.empDetail,
        required this.emPId,
        required this.dontSendInvite,
    });

    final String? empDetail;
    final int? emPId;
    final int? dontSendInvite;

    factory RequestedDspDatum.fromJson(Map<String, dynamic> json){ 
        return RequestedDspDatum(
            empDetail: json["empDetail"],
            emPId: json["emP_ID"],
            dontSendInvite: json["dontSendInvite"],
        );
    }

}
