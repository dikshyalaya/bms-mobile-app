const baseUrl =
//"http://100.25.49.138/BeaconMobile/api/";
    "https://api-beacon.dikshyalaya.com/api/";
const logInUrl = "Authentication/Login";
const changePasswordUrl = "Authentication/ChangePassword";

const clockInUrl = "PunchCard/ListPunchCardShifts";
const punchInUrl = "PunchCard/PunchIn";
const incompleteActivitiesUrl = "ShiftManagement/CheckIncompleteActivities";
const priorClockInUrl = "PunchCard/ClockinHistory";
const lookingForShiftUrl = "ShiftManagement/LookForShift";
const schedulePeriodUrl = "ShiftManagement/SchedulePeriodsLookingForShift";
const noMealReasonUrl = "ShiftManagement/MasterLookup/NoBreakReason";
const managerPermission = "Authentication/GetPermissions";
const systemSettings = "SystemSettings/DSPSwitchBoardPageSettings";
const createShift = "ShiftManagement/CreateShift";
const cancelShift = "ShiftManagement/CancelMyShift";
const availableShiftForDCList = "ShiftManagement/ListAvailableShiftsForDC";
const availableForShift = "ShiftManagement/AvailableForShift";
const lookingForShift = "ShiftManagement/UpdateLookForShift";
const listHouseForDCAddShift = "ShiftManagement/ListHouseForDCAddShift";
const myScheduleList = "ShiftManagement/GetMySchedules";
const sendOtpByEmail ="Account/RequestResetPassword";
const resetPassword ="Account/SetPasswordWithOTP";


//Manager Dashboard Urls
const accountHouses = "Manager/ShiftManagement/LoadAccounts";
const listShiftsForApproval = "Manager/ShiftManagement/ListShiftsForApproval";
const approveShifts = "Manager/ShiftManagement/ApproveShifts";
const raiseDispute = "Manager/ShiftManagement/RaiseDispute";


// pending invitations =>Shift availibility



//2 apis before landing dash board

// button click

//pending action== popup

// if(pending action>0&&enabled){
//
// }