//
//  odooAPI.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 3/31/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import Foundation
import AlamofireXMLRPC
import SWXMLHash
import SwiftyJSON
import Alamofire

class odooAPI: NSObject {
    
    
    @objc class func checkUserIsExist(name: String,completion: @escaping ( _ error:Bool ,_ userIsExistInOdoo: Int)->Void) {
        //        let url = URLS.Login
        
        
        let  db = "osama";
        //        let  username = "admin";
        let  uid = 2;
        let  password = "admin";
        
        let dic : [String:Any] = ["fields":["name", "country_id", "comment"],"limit":1]
        let params = [db,uid,password,"res.partner","search_read",[[["name","=",name]]],dic] as [Any]
        
        
        AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)
            
            .responseString { (response: DataResponse<String>) -> Void in
                
                switch response.result {
                case .success(let value):
                    
                    var xml = SWXMLHash.parse(response.value!)
                    
                    
                    print(xml)
                    let isExist  = xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"]["struct"]["member"].all.count
                    
                    var userOdooId = xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"]["struct"]["member"][0]["value"].element?.innerXML
                    
                    
                    print("user id")
                    print(userOdooId)
            
                    let userOdooIdwithoutTags = userOdooId?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    
                    if let constantUserOdoo = userOdooIdwithoutTags
                    {
                        print("user odoo int")
                        print(constantUserOdoo)
                        helper.saveOdooId(token:Int(constantUserOdoo)!)
                        completion(false,Int(constantUserOdoo)!)

                        print("get odoo id")
                        print(helper.getOdooId())
                        
                    }
                    else{
                        completion(false,0)

                    }
                    

                    print(isExist)
                    
                    
                    break
                case .failure:
                    completion(false,0)
                    
                    break
                }
        }
        
    }
    
    
    @objc class func pushNotifcationToPatient(name: String,title:String,message:String,completion: @escaping ( _ error:Bool ,_ userIsExistInOdoo: String)->Void) {

        
//        asList(
//            db, uid, password,
//            "res.partner", "push_notify_custom",
//            asList(asList(userid),title,messges)
//        )));
        
        
        let  db = "osama";
        //        let  username = "admin";
        let  uid = 2;
        let  password = "admin";
        
        print(name + title + message)

        
        print("i will send notifcation now")
        print(helper.getOdooId())
        
        let params = [db,uid,password,"res.partner","push_notify_custom",[[helper.getOdooId()],title,message]] as [Any]
        
        
        AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)
            
            .responseString { (response: DataResponse<String>) -> Void in
                
                switch response.result {
                case .success(let value):
                    
                    var xml = SWXMLHash.parse(response.value!)
        
                    
                    print(xml)
                 
                    
                    
                    
                    let sucess_Message  = xml["methodResponse"]["params"]["param"]["value"]["struct"]["member"]["value"]["string"].element?.innerXML
                    
                                      let userOdooIdwithoutTags = sucess_Message?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    
                
                    
                    
                    print(sucess_Message)
                    
                    completion(false,sucess_Message!)
                    
                    break
                    case .failure:
                    completion(false,"failurl")
                    
                    break
                }
        }
        
    }
    
//    @objc class func updateUserOdoo(completion: @escaping ( _ error:Bool ,_ userIsExistInOdoo: Int)->Void) {
//        //        let url = URLS.Login
//        
//        
//        let  db = "osama";
//        let  uid = 2;
//        let  password = "admin";
//        
//        if let constantUserOdoo = helper.getDeviceToken()
//        {
//            
//            let dic : [String:Any] = ["user_token":constantUserOdoo]
//            
//            
//            
//            
//            let params = [db,uid,password,"res.partner","write",[[helper.getOdooId()],dic]] as [Any]
//            
//            
//            AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)
//                
//                .responseString { (response: DataResponse<String>) -> Void in
//                    
//                    
//                    switch response.result {
//                    case .success(let value):
//                        
//                        var xml = SWXMLHash.parse(response.value!)
//                        
//                        print("update odoo result")
//                        print(xml)
//                        
//                        //
//                        //                        print(Int(helper.getOdooId()))
//                        //
//                        //
//                        //
//                        //                    print(     helper.getOdooId())
//                        
//                        //                    completion(false,isExist)
//                        
//                        break
//                    case .failure:
//                        completion(false,0)
//                        
//                        break
//                    }
//            }
//        }
//        
//    }
   
class func getPatientOperation(completion: @escaping ( _ error:Bool ,_ userIsExistInOdoo: [PatientOperationOdoo])->Void) {
    
    
    print(helper.getOdooId())
    
    
    


        let  db = "osama";
    
        let  uid = 2;
        let  password = "admin";


            let params = [db,uid,password,"res.partner","get_op",[[helper.getOdooId()]]] as [Any]


            AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)

                .responseString { (response: DataResponse<String>) -> Void in


                    switch response.result {
                    case .success(let value):

                        var xml = SWXMLHash.parse(response.value!)

                        print("odoo result")
                        print(xml)

//
                        
                        var countOfOeration =  xml["methodResponse"]["params"]["param"]["value"]["struct"]["member"]["value"]["array"]["data"]["value"].all.count
                        
                        
                        var operationsPatient = [PatientOperationOdoo]()
                        for n in 0..<countOfOeration {
                               var operationId = xml["methodResponse"]["params"]["param"]["value"]["struct"]["member"]["value"]["array"]["data"]["value"][n]["struct"]["member"][0]["value"].element?.innerXML
                        
                            var operationName = xml["methodResponse"]["params"]["param"]["value"]["struct"]["member"]["value"]["array"]["data"]["value"][n]["struct"]["member"][1]["value"].element?.innerXML
                        
                            
                            let operationNamewithoutTags = operationName?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

                            let operationIdwithoutTags = operationId?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                            
                            
                            
                            
                           
                            operationsPatient.append(PatientOperationOdoo(name: operationNamewithoutTags!, id: operationIdwithoutTags!))
                            
                          
                        }
                        
//                     print(operationsPatient)
                        
                     
                        completion(true,operationsPatient)



                        break
                    case .failure:
                        completion(false,[])

                        break
                    }
            }



    }
    
    
    class func getAllPatientLst(completion: @escaping ( _ error:Bool ,_ allPatientOperation: [PatientOperationOdoo])->Void) {
        //        let url = URLS.Login
        
        
        let  db = "osama";
        let  username = "admin";
        let  uid = 2;
        let  password = "admin";
        
        let dic : [String:Any] = ["fields":["id","name"],"limit":500]
        let params = [db,uid,password,"res.operation","search_read",[],dic] as [Any]
        
        
        let aStr = String(format: "%@/xmlrpc/2/object", "http://3.121.202.246:8071")
        //
        AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)
            
            .responseString { (response: DataResponse<String>) -> Void in
                
                
                switch response.result {
                case .success(let value):
                    
                    var xml = SWXMLHash.parse(response.value!)
//
      print(xml)
                    
                    
                    let countOfOeration =  xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"].all.count
                    
                    
                    
                    var operationsPatient = [PatientOperationOdoo]()
                    
                    print(operationsPatient)
                    
                    
                    
                    
                    for n in 0..<countOfOeration {
                        let operationId = xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"][n]["struct"]["member"][0]["value"].element?.innerXML
                        
                        let operationName = xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"][n]["struct"]["member"][1]["value"].element?.innerXML
                        
                        
                        let operationNamewithoutTags = operationName?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        
                        let operationIdwithoutTags = operationId?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        
                        
                        print(operationNamewithoutTags)
                        
                        print(operationIdwithoutTags)
                        
                        
                        operationsPatient.append(PatientOperationOdoo(name: operationNamewithoutTags!, id: operationIdwithoutTags!))
                        
                        
                    }
//                    print("ppppppppppppp")
//                    print(operationsPatient)
                    
                    print(operationsPatient)
                    
                    completion(true,operationsPatient)
                    
                    
                    break
                case .failure:
                    print(response.error)
                    
                    break
                }
        }
        
        
        
    }
    
    class func subscribeToPatientOperation(operationId:Int,completion: @escaping ( _ error:Bool ,_ allPatientOperation: Int)->Void) {
        //        let url = URLS.Login
        
        print(operationId)
        print(helper.getOdooId())
        
//        db, uid, password,
//        "res.partner", "assign_op",
//        asList(ids,asList(operation_id))
        
        let  db = "osama";
        let  username = "admin";
        let  uid = 2;
        let  password = "admin";
        
        let params = [db,uid,password,"res.partner","assign_op",[helper.getOdooId(),[operationId]]] as [Any]
        
        
        let aStr = String(format: "%@/xmlrpc/2/object", "http://3.121.202.246:8071")
        //
        AlamofireXMLRPC.request("http://3.121.202.246:8071/xmlrpc/2/object", methodName: "execute_kw", parameters: params)
            
            .responseString { (response: DataResponse<String>) -> Void in
                
                
                switch response.result {
                case .success(let value):
                    
                    var xml = SWXMLHash.parse(response.value!)
                    //
                    let countOfOeration =  xml["methodResponse"]["params"]["param"]["value"]["array"]["data"]["value"].all.count
                    
                    print("subscribe")
                    print(xml)
              
                    
                    completion(true,1)
                    
                    
                    break
                case .failure:
                    print(response.error)
                    
                    break
                }
        }
        
        
        
    }
    
    
    
}

/*
 
 // Do any additional setup after loading the view, typically from a nib.

 */

