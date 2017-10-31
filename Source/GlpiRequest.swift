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
    class public func initSessionByUserToken(userToken: String, appToken: String = "", completion: @escaping (_ result: AnyObject?) -> Void) {

        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.initSessionByUserToken(userToken, appToken).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                SESSION_TOKEN = ""
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }

            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    
                    if let session_token = dataJSON["session_token"] {
                        SESSION_TOKEN = session_token as? String ?? ""
                    }
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request a session token to uses other api endpoints.
     - parameter: user
     - parameter: password
     - parameter: app token (optional)
     */
    class public func initSessionByCredentials(user: String, password: String, appToken: String = "", completion: @escaping (_ result: AnyObject?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.initSessionByCredentials(user, password, appToken).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                SESSION_TOKEN = ""
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    
                    if let session_token = dataJSON["session_token"] {
                        SESSION_TOKEN = session_token as? String ?? ""
                    }
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request kill current session
     */
    class public func killSession(completion: @escaping (_ result: AnyObject?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.killSession.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get my profiles
     */
    class public func getMyProfiles(completion: @escaping (_ result: AnyObject?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getMyProfiles.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get active profile
     */
    class public func getActiveProfile(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getActiveProfile.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request change active profile
     */
    class public func changeActiveProfile(profileID: String, completion: @escaping (_ result: Any?) -> Void) {

        var dictionary = [String: AnyObject]()
        dictionary["profiles_id"] = profileID as AnyObject
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.changeActiveProfile(dictionary).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get my entities
     */
    class public func getMyEntities(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getMyEntities.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get active entities
     */
    class public func getActiveEntities(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getMyEntities.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request change active entities
     */
    class public func changeActiveEntities(entitiesID: String, isRecursive: Bool = false, completion: @escaping (_ result: AnyObject?) -> Void) {
        
        var dictionary = [String: AnyObject]()
        dictionary["is_recursive"] = isRecursive as AnyObject
        dictionary["entities_id"] = entitiesID as AnyObject
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.changeActiveProfile(dictionary).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get full session information
     */
    class public func getFullSession(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getFullSession.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get Glpi Configuration
     */
    class public func getGlpiConfig(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getGlpiConfig.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get all items
     */
    class public func getAllItems(itemType: ItemType, queryString: QueryString.GetAllItems?, completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getAllItems(itemType, queryString).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get an item
     */
    class public func getItem(itemType: ItemType, itemID: Int, queryString: QueryString.GetAnItem?, completion: @escaping (_ result: AnyObject?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getItem(itemType, itemID, queryString).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get an item
     */
    class public func getSubItems(itemType: ItemType, itemID: Int, subItemType: ItemType, queryString: QueryString.GetSubItems?, completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getSubItems(itemType, itemID, subItemType, queryString).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request Add Items
     */
    class public func addItems(itemType: ItemType, payload: [String: AnyObject], completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.addItems(itemType, payload).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request Update Items
     */
    class public func updateItems(itemType: ItemType, itemID: Int?, payload: [String: AnyObject], completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.updateItems(itemType, itemID, payload).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request Delete Items
     */
    class public func deleteItems(itemType: ItemType, itemID: Int?, queryString: QueryString.DeleteItems?, payload: [String: AnyObject], completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.deleteItems(itemType, itemID, queryString, payload).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request Lost password
     */
    class public func recoveryPassword(email: String, completion: @escaping (_ result: Any?) -> Void) {
        
        var dictionary = [String: AnyObject]()
        dictionary["email"] = email as AnyObject
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.lostPassword(dictionary).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request reset password
     */
    class public func resetPassword(payload: [String: AnyObject], completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.lostPassword(payload).request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     Request get multiple items
     */
    class public func getMultipleItems(completion: @escaping (_ result: Any?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: Routers.getMultipleItems.request()) { (data, response, error) in
            
            guard error == nil, let responseData = data else {
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                    completion(dataJSON as AnyObject)
                } else {
                    // couldn't create a todo object from the JSON
                    completion(GlpiRequest.handlerError(data) as AnyObject)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completion(GlpiRequest.handlerError(data) as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    /**
     handler Error
     - return: error message
     */
    class func handlerError(_ error: Data?) -> [String: String] {
        
        var errorObj = [String]()
        var errorDict = [String: String]()
        
        if let data = error {
            do {
                errorObj = try JSONSerialization.jsonObject(with: data) as? [String] ?? [String]()
            } catch {
                errorObj = [String]()
            }
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
