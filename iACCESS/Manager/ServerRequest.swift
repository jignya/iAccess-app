//
//  ServerRequest.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation
import Alamofire
import ImShExtensions
import SwiftyJSON
import Firebase

import SWXMLHash
import StringExtensionHTML
import AEXML


class ServerRequest {
    
    /// Singleton object
    static let shared = ServerRequest()
    
    class var isConnected: Bool {
        let manager = NetworkReachabilityManager.init(host: "www.google.com")
        return manager?.isReachable ?? false
    }

    /// - Parameters:
    ///   - delegate: ServerRequestDelegate
    ///   - completion: ()
    ///   - failure: Error msg if any, String
   
    //MARK:- Soap Api function
    
    //MARK:------------------  Create Account -----------------------------
    func CreatePersonalAccount(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:a3w=\"http://sap.com/xi/AP/CustomerExtension/BYD/A3WID\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"xmlns:glob1=\"http://sap.com/xi/AP/Globalization\"><soapenv:Header /><soapenv:Body><glob:CustomerBundleMaintainRequest_sync_V1><BasicMessageHeader /><Customer><Person><NameFormatCountryCode>%@</NameFormatCountryCode><GenderCode>%@</GenderCode><FamilyName>%@</FamilyName><FormOfAddressCode>%@</FormOfAddressCode><GivenName>%@</GivenName></Person><AddressInformation><Address><Telephone><MobilePhoneNumberIndicator>%@</MobilePhoneNumberIndicator><FormattedNumberDescription>%@</FormattedNumberDescription></Telephone><PostalAddress><StreetName>%@</StreetName><CountyName>%@</CountyName><CityName>%@</CityName></PostalAddress><EmailURI>%@</EmailURI><telephoneListCompleteTransmissionIndicator>%@</telephoneListCompleteTransmissionIndicator></Address></AddressInformation><ProspectIndicator>true</ProspectIndicator><ContactAllowedCode>true</ContactAllowedCode><CategoryCode>%@</CategoryCode><LifeCycleStatusCode>%@</LifeCycleStatusCode><addressInformationListCompleteTransmissionIndicator>%@</addressInformationListCompleteTransmissionIndicator><CustomerIndicator>%@</CustomerIndicator></Customer> </glob:CustomerBundleMaintainRequest_sync_V1></soapenv:Body></soapenv:Envelope>","IN","1","Panchal","0005","Jignya","true","45621245","Ahmedabad","Ahmedabad","Ahmedabad","test@gmail.com","true","1","false","true","true")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/managecustomerin1?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/CheckMaintainBundleRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            
            if response != nil {
                print(response?.description as Any)
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            
            //            self.mutableData.append(data!)
        })
        
        task.resume()
    }
    
    //MARK:------------------  Get Profile -----------------------------

    func GetCustomerDetail(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"><soapenv:Body><glob:CustomerReadCustomerReadByIDQuery_sync><Customer><InternalID>%@</InternalID></Customer></glob:CustomerReadCustomerReadByIDQuery_sync></soapenv:Body></soapenv:Envelope>", "P00012")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/yyaj9cu4yy_readcustomer?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://0031178908-one-off.sap.com/YAJ9CU4YY_/YAJ9CU4YY_ReadCustomer/ReadRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let session = URLSession.shared
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            if response != nil {

                print(response?.description as Any)
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            
        })
        task.resume()
    }
    //MARK:------------------  Add Property -----------------------------

    func AddProperty(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:a3w=\"http://sap.com/xi/AP/CustomerExtension/BYD/A3WID\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"xmlns:glob1=\"http://sap.com/xi/AP/Globalization\"><soapenv:Header /><soapenv:Body><glob:CustomerBundleMaintainRequest_sync_V1><BasicMessageHeader /><Customer><Person><NameFormatCountryCode>%@</NameFormatCountryCode><GenderCode>%@</GenderCode><FamilyName>%@</FamilyName><FormOfAddressCode>%@</FormOfAddressCode><GivenName>%@</GivenName></Person><AddressInformation><Address><Telephone><MobilePhoneNumberIndicator>%@</MobilePhoneNumberIndicator><FormattedNumberDescription>%@</FormattedNumberDescription></Telephone><PostalAddress><StreetName>%@</StreetName><CountyName>%@</CountyName><CityName>%@</CityName></PostalAddress><EmailURI>%@</EmailURI><telephoneListCompleteTransmissionIndicator>%@</telephoneListCompleteTransmissionIndicator></Address></AddressInformation><ProspectIndicator>true</ProspectIndicator><ContactAllowedCode>true</ContactAllowedCode><CategoryCode>%@</CategoryCode><LifeCycleStatusCode>%@</LifeCycleStatusCode><addressInformationListCompleteTransmissionIndicator>%@</addressInformationListCompleteTransmissionIndicator><CustomerIndicator>%@</CustomerIndicator></Customer> </glob:CustomerBundleMaintainRequest_sync_V1></soapenv:Body></soapenv:Envelope>","IN","1","Panchal","0005","Jignya","true","45621245","Ahmedabad","Gujarat","India","test@gmail.com","true","3","false","true","true")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/managecustomerin1?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/CheckMaintainBundleRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            
            if response != nil {
                print(response?.description as Any)
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            
            //            self.mutableData.append(data!)
        })
        
        task.resume()
    }
    
    //MARK:------------------  Cancel Job request -----------------------------
    
    func cancelJobRequest(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"><soapenv:Header/><soapenv:Body><glob:OpportunityBundleMaintainRequest_sync><Opportunity actionCode=02><ID>%@</ID></Opportunity></glob:OpportunityBundleMaintainRequest_sync></soapenv:Body></soapenv:Envelope>","99")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/manageopportunityin1?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/CheckMaintainBundleRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            
            if response != nil {
                print(response?.description as Any)
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            
            //            self.mutableData.append(data!)
        })
        
        task.resume()
    }
    
    
//    func getCountries(completion: (_ result: [String]) -> Void) -> Void {
//
//        var result = [String]()
//        let soapRequest = AEXMLDocument()
//
//        let envelopeAttributes = ["-xmlns:soapenv": "http://schemas.xmlsoap.org/soap/envelope/",
//                                  "-xmlns:glob": "http://sap.com/xi/SAPGlobal20/Global",
//                                  "-xmlns:a3w": "http://sap.com/xi/AP/CustomerExtension/BYD/A3WID",
//                                  "-xmlns:glob1": "http://sap.com/xi/AP/Globalization"]
//
//        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: envelopeAttributes)
//
//        let header = envelope.addChild(name: "soapenv:Header")
//        let body = header.addChild(name: "soapenv:Body")
//
//        let dictBody = ["Customer":["CategoryCode":"1","ProspectIndicator":1, "CustomerIndicator":1,"LifeCycleStatusCode":0,"ContactAllowedCode":"1","addressInformationListCompleteTransmissionIndicator":1,"Person":["GenderCode":"1","FormOfAddressCode":"0002", "GivenName":"Jignya","FamilyName":"Panchal","NameFormatCountryCode":"IN"],"AddressInformation":["Address":["telephoneListCompleteTransmissionIndicator":1,"EmailURI":"test@gmail.com","PostalAddress":["StreetName":"Ahmedabad","CityName":"Ahmedabad","CountyName":"Ahmedabad"],"Telephone":["FormattedNumberDescription":"4562124562","MobilePhoneNumberIndicator":true]]]] ,"BasicMessageHeader":[]] as [String : Any]
//
//        body.addChild(name: "CustomerBundleMaintainRequest_sync_V1", value: dictBody.description)
//
//        let username = "_PHIXE_TEST"
//        let password = "Solex123"
//        let loginString = String(format: "%@:%@", username, password)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//
//
//        print(body)
//
//
//        let soapLenth = String(soapRequest.xml.count)
//        let theURL = NSURL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/managecustomerin1?sap-vhost=my350404.sapbydesign.com")
//
//        var mutableR = URLRequest(url: theURL! as URL)
//        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        mutableR.addValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
//        mutableR.httpMethod = "POST"
//        mutableR.httpBody = soapRequest.xml.data(using: .utf8)
//        mutableR.addValue("http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/CheckMaintainBundleRequest", forHTTPHeaderField: "soapAction")
//        mutableR.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//
//        Alamofire.request(mutableR as URLRequestConvertible)
//            .responseString { response in
//                if let xmlString = response.result.value {
//                    print(xmlString)
//                    let xml = SWXMLHash.parse(xmlString)
//                    let body =  xml["soap:Envelope"]["soap:Body"]
//                    if let countriesElement = body["GetCountriesResponse"]["GetCountriesResult"].element {
//                        let getCountriesResult = countriesElement.text
//                        let xmlInner = SWXMLHash.parse(getCountriesResult.stringByDecodingHTMLEntities)
//                        for element in xmlInner["NewDataSet"]["Table"].all {
//                            if let nameElement = element["Name"].element {
//                            }
//                        }
//                    }
//
//                    print(result)
////                    completion(result)
//                }else{
//                    print("error fetching XML")
//                }
//            }
//    }

    
    func soapApiData1()
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"><soapenv:Body><glob:CustomerReadCustomerReadByIDQuery_sync><Customer><InternalID>%@</InternalID></Customer></glob:CustomerReadCustomerReadByIDQuery_sync></soapenv:Body></soapenv:Envelope>", "P00012")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/yyaj9cu4yy_readcustomer?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://0031178908-one-off.sap.com/YAJ9CU4YY_/YAJ9CU4YY_ReadCustomer/ReadRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        
        
        let session = URLSession.shared
        
        
        
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                
                return
                
            }
            
            
            
            if response != nil {

                print(response?.description)
            }
            
            
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print(dataString!)
            
            
            
//            self.mutableData.append(data!)
            
            
            
        })
        
        task.resume()
        
        
    }
    
    func soapApiData2()
    {
        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let soapMessage = String(format: "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:a3w=\"http://sap.com/xi/AP/CustomerExtension/BYD/A3WID\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"xmlns:glob1=\"http://sap.com/xi/AP/Globalization\"><soapenv:Header /><soapenv:Body><glob:CustomerBundleMaintainRequest_sync_V1><BasicMessageHeader /><Customer><Person><NameFormatCountryCode>IN</NameFormatCountryCode><GenderCode>1</GenderCode><FamilyName>Panchal</FamilyName><FormOfAddressCode>0005</FormOfAddressCode><GivenName>Jignya</GivenName></Person><AddressInformation><Address><Telephone><MobilePhoneNumberIndicator>true</MobilePhoneNumberIndicator><FormattedNumberDescription>45621245</FormattedNumberDescription></Telephone><PostalAddress><StreetName>Ahmedabad</StreetName><CountyName>Ahmedabad</CountyName><CityName>Ahmedabad</CityName></PostalAddress><EmailURI>test@gmail.com</EmailURI><telephoneListCompleteTransmissionIndicator>true</telephoneListCompleteTransmissionIndicator></Address></AddressInformation><ProspectIndicator>true</ProspectIndicator><ContactAllowedCode>true</ContactAllowedCode><CategoryCode>true</CategoryCode><LifeCycleStatusCode>fasle</LifeCycleStatusCode><addressInformationListCompleteTransmissionIndicator>true</addressInformationListCompleteTransmissionIndicator><CustomerIndicator>true</CustomerIndicator></Customer> </glob:CustomerBundleMaintainRequest_sync_V1></soapenv:Body></soapenv:Envelope>")
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/managecustomerin1?sap-vhost=my350404.sapbydesign.com")!
        var theRequest = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        theRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        theRequest.addValue("http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/CheckMaintainBundleRequest", forHTTPHeaderField: "SOAPAction")
        
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            
            if response != nil {
                print(response?.description as Any)
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataString!)
            
//            self.mutableData.append(data!)
        })
        
        task.resume()
    }
    
    func soapApiData()
    {
        let soap = SOAPEngine()
        
        soap.authorizationMethod = .AUTH_BASICAUTH
        soap.username = "_PHIXE_TEST"
        soap.password = "Solex123"
        soap.actionNamespaceSlash = true
//        soap.responseHeader = true // use only for non standard MS-SOAP service
        
//        soap.envelope =  "-xmlns:soapenv: http://schemas.xmlsoap.org/soap/envelope/,-xmlns:glob: http://sap.com/xi/SAPGlobal20/Global,-xmlns:a3w : http://sap.com/xi/AP/CustomerExtension/BYD/A3WID,-xmlns:glob1: http://sap.com/xi/AP/Globalization"
        
        
        soap.envelope = String(format: "<?xml version=\"1.0\" encoding=\"UTF-8\"?> <soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:a3w=\"http://sap.com/xi/AP/CustomerExtension/BYD/A3WID\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\" xmlns:glob1=\"http://sap.com/xi/AP/Globalization\"><soapenv:Header /> <soapenv:Body> <glob:CustomerBundleMaintainRequest_sync_V1> <BasicMessageHeader /> <Customer> <Person> <NameFormatCountryCode>IN</NameFormatCountryCode> <GenderCode>1</GenderCode> <FamilyName>Panchal</FamilyName> <FormOfAddressCode>0005</FormOfAddressCode> <GivenName>Jignya</GivenName> </Person> <AddressInformation> <Address> <Telephone> <MobilePhoneNumberIndicator>true</MobilePhoneNumberIndicator> <FormattedNumberDescription>45621245</FormattedNumberDescription> </Telephone> <PostalAddress> <StreetName>Ahmedabad</StreetName> <CountyName>Ahmedabad</CountyName> <CityName>Ahmedabad</CityName> </PostalAddress> <EmailURI>test@gmail.com</EmailURI> <telephoneListCompleteTransmissionIndicator>true</telephoneListCompleteTransmissionIndicator> </Address> </AddressInformation> <ProspectIndicator>true</ProspectIndicator> <ContactAllowedCode>true</ContactAllowedCode> <CategoryCode>true</CategoryCode> <LifeCycleStatusCode>fasle</LifeCycleStatusCode> <addressInformationListCompleteTransmissionIndicator>true</addressInformationListCompleteTransmissionIndicator> <CustomerIndicator>true</CustomerIndicator> </Customer> </glob:CustomerBundleMaintainRequest_sync_V1> </soapenv:Body> </soapenv:Envelope>")
                
        
//        let dictBody = ["Customer":["CategoryCode":"1","ProspectIndicator":1, "CustomerIndicator":1,"LifeCycleStatusCode":0,"ContactAllowedCode":"1","addressInformationListCompleteTransmissionIndicator":1,"Person":["GenderCode":"1","FormOfAddressCode":"0002", "GivenName":"Jignya","FamilyName":"Panchal","NameFormatCountryCode":"IN"],"AddressInformation":["Address":["telephoneListCompleteTransmissionIndicator":1,"EmailURI":"test@gmail.com","PostalAddress":["StreetName":"Ahmedabad","CityName":"Ahmedabad","CountyName":"Ahmedabad"],"Telephone":["FormattedNumberDescription":"4562124562","MobilePhoneNumberIndicator":true]]]] ,"BasicMessageHeader":[]] as [String : Any]
//
//        soap.setValue(dictBody.description, forKey: "CustomerBundleMaintainRequest_sync_V1")
//
//        soap.requestWSDL("https://homefinch.viitor.cloud/wsdl/ManageOpportunityIn.wsdl", operation: "MaintainBundle_V1") { (statusCode : Int, dict : [AnyHashable : Any]?) -> Void in
//
//                let result:Dictionary = dict! as Dictionary
//                print(result)
//
//        } failWithError: { (error : Error?) -> Void in
//
//            print(error.debugDescription)
//        }
        
        soap.requestURL("https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/managecustomerin1?sap-vhost=my350404.sapbydesign.com",
            soapAction: "http://sap.com/xi/AP/CRM/Global/ManageOpportunityIn/MaintainBundleRequest",
            completeWithDictionary: { (statusCode : Int,
                                 dict : [AnyHashable : Any]?) -> Void in

                let result:Dictionary = dict! as Dictionary
                print(result)

            }) { (error : Error?) -> Void in

            print(error.debugDescription)
        }

    }

}

@objc protocol ServerRequestDelegate: class {
    func isLoading(loading: Bool)
    @objc optional func progress(value: Double)
}

extension JSON {
    func getRespMsg() -> String {
        return self["message"].stringValue
    }
}
