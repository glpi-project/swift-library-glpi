//
/*
 * Copyright © 2017 Teclib. All rights reserved.
 *
 * Request.swift is part of the GLPI API Client Library for Swift,
 * a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 * Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon - <hrondon@teclib.com>
 * @date      18/10/17
 * @copyright (C) 2017 Teclib' and contributors
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/[name]
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */
 

import Foundation
import Alamofire

/// Session Token
public var SESSION_TOKEN = String()

public class GlpiRequest {

    /**
     Request a session token to uses other api endpoints.
     - parameter: user token
     - parameter: app token (optional)
     */
    class public func initSession(userToken: String, appToken: String = "", completion: @escaping (_ result: Any?) -> Void) {

        Alamofire.request(Routers.initSession(userToken, appToken))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    if let data = result as? [String: AnyObject]  {
                        if let session_token = data["session_token"] {
                            SESSION_TOKEN = session_token as? String ?? ""
                        }
                        completion(result)
                    }
                case .failure(_ ):
                    SESSION_TOKEN = ""
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request a session token to uses other api endpoints.
     - parameter: user
     - parameter: password
     - parameter: app token (optional)
     */
    class public func initSession(user: String, password: String, appToken: String = "", completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.initSessionByBasicAuth(user, password, appToken))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    do {
                        if let data = (result as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                                
                                if let session_token = json["session_token"] {
                                    SESSION_TOKEN = session_token
                                }
                                completion(result)
                            }
                        }
                    } catch {
                        completion(GlpiRequest.handlerError(response.data))
                    }
                case .failure(_ ):
                    SESSION_TOKEN = ""
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request kill current session
     */
    class public func killSession(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.killSession)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    SESSION_TOKEN = ""
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get my profiles
     */
    class public func getMyProfiles(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getMyProfiles)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get active profile
     */
    class public func getActiveProfile(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getActiveProfile)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request change active profile
     */
    class public func changeActiveProfile(profileID: String, completion: @escaping (_ result: Any?) -> Void) {

        var dictionary = [String: AnyObject]()
        dictionary["profiles_id"] = profileID as AnyObject
        
        Alamofire.request(Routers.changeActiveProfile(dictionary))
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get my entities
     */
    class public func getMyEntities(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getMyEntities)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get active entities
     */
    class public func getActiveEntities(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getActiveEntities)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request change active entities
     */
    class public func changeActiveEntities(entitiesID: String, isRecursive: Bool = false, completion: @escaping (_ result: Any?) -> Void) {
        
        var dictionary = [String: AnyObject]()
        dictionary["is_recursive"] = isRecursive as AnyObject
        dictionary["entities_id"] = entitiesID as AnyObject
        
        Alamofire.request(Routers.changeActiveProfile(dictionary))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get full session information
     */
    class public func getFullSession(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getFullSession)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get Glpi Configuration
     */
    class public func getGlpiConfig(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getGlpiConfig)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get all items
     */
    class public func getAllItems(itemType: ItemType, queryString: QueryString.GetAllItems?, completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getAllItems(itemType, queryString))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     Request get multiple items
     */
    class public func getMultipleItems(completion: @escaping (_ result: Any?) -> Void) {
        
        Alamofire.request(Routers.getMultipleItems)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let result):
                    completion(result)
                case .failure(_ ):
                    completion(GlpiRequest.handlerError(response.data))
                }
        }
    }
    
    /**
     handler Error
     - return: error message
     */
    class func handlerError(_ error: Data?) -> [String: String] {
        
        var errorObj = [String]()
        var errorDict = [String: String]()
        
        if let data = error {
            errorObj = try! JSONSerialization.jsonObject(with: data) as? [String] ?? [String]()
        }
        
        if errorObj.count == 2 {
            errorDict["error"] = errorObj[0]
            errorDict["message"] = errorObj[1]
        } else {
            errorDict["error"] = ""
            errorDict["message"] = ""
        }
        
        return errorDict
    }
}
