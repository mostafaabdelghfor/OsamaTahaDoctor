
import UIKit
import Alamofire
import SwiftyJSON
import FirebaseFirestore

//class acesssApiBYSessionManger{
//
//
//    private init(){}
//
//  static var Manager : Alamofire.SessionManager = {
//        // Create the server trust policies
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "demo.instahealthsolutions.com": .disableEvaluation
//
//
//        ]
//        // Create custom manager
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        let man = Alamofire.SessionManager(
//            configuration: URLSessionConfiguration.default,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//        return man
//    }()
//
//}
class API: NSObject {
    
    
    
    
    static var Manager : Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "demo.instahealthsolutions.com": .disableEvaluation
            
            
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
    @objc class func Login(mobile_user_id: String,mobile_user_password : String,completion: @escaping ( _ error:Bool ,_ success: Int)->Void) {
        let url = URLS.Login
        let parameters = [
            "hospital_name": "osama_t",
          
        ]
        
        let insta_auth = "\(mobile_user_id):\(mobile_user_password)"
        
        print(insta_auth)
                let header = [
                    "X-insta-auth": insta_auth
                    ]
        
        API.Manager.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    print( "No Internet Connection")
                    completion(true,0)
                }
                response.result.ifSuccess {
                    
            print(response.response?.statusCode)
                    
                    helper.saveDoctorID(token: mobile_user_id )
                    
print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\(helper.getDeviceToken())")
                    let db = Firestore.firestore()

                    db.collection("tokensListDoctor").document(helper.getdoctorID()!).setData([
                        "token": helper.getDeviceToken()

                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    
                    
                    if response.response?.statusCode == 200
                    {
                        completion(false,(response.response?.statusCode)!)
                        let request_handler_key = JSON(response.value)["request_handler_key"]
                        helper.saveRequest_handler_key(token: request_handler_key.string!)
                       
                    }
                    if response.response?.statusCode == 401
                    {
                        completion(false,(response.response?.statusCode)!)
                        
                    }
                    
                }
                
                
        }
        
    }
    
    class func getPatientSearch(request_handler_key: String ,serachDic:[String:String],completion: @escaping (_ success: Int,_ Patients:[Patient]?)->Void) {
        let url = URLS.getPatient
        let header = [
            "request_handler_key": request_handler_key,
            ]
   
//        let parameters = [
//            "first_name": "ah",
//            
//            ]
        API.Manager.request(url, method: .get,  parameters: serachDic , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {
                    
                    let json = JSON(response.value)
                    
                                                            print(json)
                    
                    
                    
                    //                                        print(json["patient_details"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])
                    
                    guard let patientArray = json ["patient_details"].array else {
                        
                        print(json["return_code"] )
                     
                        completion(Int(json["return_code"].string!)! ,[])
                        return
                    }
                    
                    var patients = [Patient]()
                    //
                    for data in patientArray{
                        guard let data  = data.dictionary else{
                            
                            return
                        }
                        
                        print(data["mr_no"]?.string ?? "mo")
                        let patient1 =  Patient(name: data["patient_full_name"]?.string ?? "", mr_no: data["mr_no"]?.string ?? "", dateOfBirth: data["dateofbirth"]?.string ?? "", Phone: data["patient_phone"]?.string ?? "" )
                        
                        patients.append(patient1)
                    }
                    
                    
                    
                    
                    
                    completion((response.response?.statusCode)!,patients)
                    
                }
                
                
        }
        
    }
    
    class func getPatient(request_handler_key: String ,completion: @escaping (_ success: Int,_ Patients:[Patient]?)->Void) {
        let url = URLS.getPatient
        let header = [
            "request_handler_key": request_handler_key,
            ]

        let parameters = [
            "first_name": "ah",
            
            ]
        API.Manager.request(url, method: .get,  parameters: parameters , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {

                    let json = JSON(response.value)

//                                        print(json)

//                                        print(json["patient_details"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])

                    guard let patientArray = json ["patient_details"].array else {

                        completion((response.response?.statusCode)!,nil)
                        return
                    }

                    var patients = [Patient]()
//
                    for data in patientArray{
                        guard let data  = data.dictionary else{

                            return
                        }
                        
                        print(data["patient_full_name"]?.string ?? "mo")
                        print(data["patient_phone"]?.string ?? "mo")

                        let patient1 =  Patient(name: data["patient_full_name"]?.string ?? "", mr_no: data["mr_no"]?.string ?? "", dateOfBirth: data["dateofbirth"]?.string ?? "", Phone: data["patient_phone"]?.string ?? "" )
                        
                        patients.append(patient1)
                    }





                    completion((response.response?.statusCode)!,patients)

                }


        }

    }
    
    
    
    class func getPatientAccessMobile(request_handler_key: String ,mr_no:String,dateOfBirth:String,patientPhone:String,completion: @escaping (_ success: Int,_ Patients:[patientAppintment]?)->Void) {
        let url = URLS.getPatientAccessMobile
        
        print(mr_no)
        let header = [
            "request_handler_key": request_handler_key,
            ]
        
        let parameters = [
            "mr_no": mr_no,
            "date_of_birth":dateOfBirth,
            "mobile_no":patientPhone,
            "gender":"F"
            
            ]
        API.Manager.request(url, method: .get,  parameters: parameters , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {
                    print("Hi Every Body i am in Patient Access Mobile")
                    let json = JSON(response.value)
                    
                    print(response.value)
                    
                    
                    //                    print(json["appointments"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])
                    
                 
                    
                    
                    
                    
                }
                
                
        }
        
    }
    
    
    class func getPatientAppointment(request_handler_key: String ,mr_no:String,completion: @escaping (_ success: Int,_ Patients:[patientAppintment]?)->Void) {
        let url = URLS.getPatinetAppointment
     
        print(mr_no)
        let header = [
            "request_handler_key": request_handler_key,
            ]
        
        let parameters = [
            "mr_no": mr_no,
            
            ]
        API.Manager.request(url, method: .get,  parameters: parameters , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {
                    print("get Patient details statues code")
                    let json = JSON(response.value)
                    
                    print(response.value)
                    
                    
//                    print(json["appointments"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])
                    
                    guard let patientAppointment = json ["appointments"].array else {
                        
                        completion(10,nil)
                        return
                    }
                    
                    var appointments = [patientAppintment]()
                    
                    for data in patientAppointment{
                        guard let data  = data.dictionary else{
                            
                            return
                        }
                        
                        let myAppointmentDeatailsModel  =   patientAppintment(doctorNAme: data["doctor_name"]?.string ?? "", centerName: data["center_name"]?.string ?? "", statues: data["appointment_status"]?.string ?? "", date: data["booked_time"]?.string ?? "" )
                        
                        
                        appointments.append(myAppointmentDeatailsModel)
                    }
                    
                    
                    
                    
                    
                    completion((response.response?.statusCode)!,appointments)
                }
                
                
        }
        
    }
    
    
    
    class func getPatientVista(request_handler_key: String ,mr_no:String,completion: @escaping (_ success: Int,_ Patients:[patientVisitis]?)->Void) {
        let url = URLS.getPatientsVisits
        
        print(mr_no)
        let header = [
            "request_handler_key": request_handler_key,
            ]
        
        let parameters = [
            "mr_no": mr_no,
            
            ]
        API.Manager.request(url, method: .get,  parameters: parameters , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {
                    print("*********************************************************************************************************************************************************************************************************************")
                    let json = JSON(response.value)
                    
                    print(json)
                    
                    
                    print(json["patient_visits_details"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])
                    
                    guard let patientAppointment = json ["patient_visits_details"].array else {
                        
                        completion(10,nil)
                        return
                    }
                    
                    var patient_visits_details = [patientVisitis]()
                    
                    for data in patientAppointment{
                        guard let data  = data.dictionary else{
                            
                            return
                        }
                        
                        
                         let myAppointmentDeatailsModel  =    patientVisitis(doctorNAme: data["DOCTOR_NAME"]?.string ?? "", visitId: data["VISIT_ID"]?.string ?? "", dateVistTime:  data["REG_DATE_TIME"]?.string ?? "")
                        
              
                        
                        
                        patient_visits_details.append(myAppointmentDeatailsModel)
                    }
                    
                    
                    
                    
                    
                    completion((response.response?.statusCode)!,patient_visits_details)
                }
                
                
        }
        
    }
    class func getPatientVistaEMR(request_handler_key: String ,visitId:String,completion: @escaping (_ success: Int,_ Patients:[pdfList]?)->Void) {
        let url = URLS.getPatientsVisitsEMRPDF
        
        
        let header = [
            "request_handler_key": request_handler_key,
            ]
        
        let parameters = [
            "visitId": visitId,
            
            ]
        API.Manager.request(url, method: .get,  parameters: parameters , encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                response.result.ifFailure {
                    completion(0,nil)
                }
                response.result.ifSuccess {
                    print("get Patient details statues code")
                    let json = JSON(response.value)
                    
                    
                    
                    
                    print(response.value)
                    
                    
//                                        print(json["patient_visit_emr_documents"])
                    //                    print(json["hospital_doctors"])
                    //                    print(json["hospital_departments"])
                    
                    guard let patient_visit_emr_documents = json ["patient_visit_emr_documents"].array else {
                        
                        completion(10,nil)
                        return
                    }
//                    print("mostafa")
//                    print(patient_visit_emr_documents[0])
                    var pdfList1 = [pdfList]()
                    
                    for data in patient_visit_emr_documents{
                        print("data")
                        print(data)
                        guard let data  = data[0].dictionary else{
                            
                            return
                        }
                        print("viewDocs")
                        print(data["viewDocs"]![0])
                       
                        
                        guard let viewDocs = data["viewDocs"]![0].dictionary else {

                            completion(10,nil)
                            return
                        }
//
                       print(viewDocs)

                        
                        let pdfListModel  =   pdfList(url: viewDocs["displayUrl"]?.string ?? "", title: viewDocs["title"]?.string ?? "")


                        pdfList1.append(pdfListModel)
                    }
                    
                    
                    
                    
                    
                    completion((response.response?.statusCode)!,pdfList1)
                }
                
                
        }
        
   
    }
    class func getPatientVistaPdf(request_handler_key: String ,mr_no:String,completion: @escaping (_ success: Int,_ Patients:[patientVisitis]?)->String) {
        let url = URLS.getPatientsVisitsPDF
        
        print(mr_no)
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

        let header = [
            "request_handler_key": request_handler_key,
            ]
        
        let parameters = [
            "visitId": "IP000103",
            "logoHeader": "H"
            
            ]
   
        
        API.Manager.download(
            url,
            method: .get,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: header,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                
                
                print(DefaultDownloadResponse.response)
            })
        
    }
    
}
extension UIViewController {
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print ("YES")
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

