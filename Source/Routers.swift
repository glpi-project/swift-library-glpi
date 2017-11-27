//
/*
 * LICENSE
 *
 * Routers.swift is part of the GLPI API Client Library for Swift,
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
 * @author    Hector Rondon
 * @date      31/10/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/glpi-project/swift-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */
 

import Foundation

public enum Routers: URLRequestDelegate {
    
    /// GET /initSession
    case initSessionByUserToken(String, String)
    /// GET /initSession
    case initSessionByCredentials(String, String, String)
    /// GET /killSession
    case killSession
    /// GET /getMyProfiles
    case getMyProfiles
    /// GET /getActiveProfile
    case getActiveProfile
    /// POST /changeActiveProfile
    case changeActiveProfile([String: AnyObject])
    /// GET /getMyEntities
    case getMyEntities
    /// GET /getActiveEntities
    case getActiveEntities
    /// POST /changeActiveEntities
    case changeActiveEntities([String: AnyObject])
    /// GET /getFullSession
    case getFullSession
    /// GET /getGlpiConfig
    case getGlpiConfig
    /// GET /:itemtype
    case getAllItems(ItemType, QueryString.GetAllItems?)
    /// GET /:itemtype/:id
    case getItem(ItemType, Int, QueryString.GetAnItem?)
    /// GET /:itemtype/:id/:sub_itemtype
    case getSubItems(ItemType, Int, ItemType, QueryString.GetSubItems?)
    /// GET /getMultipleItems
    case getMultipleItems
    /// POST /:itemtype
    case addItems(ItemType, [String: AnyObject])
    /// PUT /:itemtype/:id
    case updateItems(ItemType, Int?, [String: AnyObject])
    /// DELETE /:itemtype/:id
    case deleteItems(ItemType, Int?, QueryString.DeleteItems?, [String: AnyObject])
    /// PUT /lostPassword
    case lostPassword([String: AnyObject])
    
    /// get HTTP Method
    var method: HTTPMethod {
        switch self {
        case .initSessionByUserToken, .initSessionByCredentials, .killSession, .getMyProfiles, .getActiveProfile,
             .getMyEntities, .getActiveEntities, .getFullSession, .getGlpiConfig,
             .getMultipleItems, .getAllItems, .getItem, .getSubItems:
            return .get
        case .changeActiveProfile, .changeActiveEntities, .addItems:
            return .post
        case .updateItems, .lostPassword:
            return .put
        case .deleteItems:
            return .delete
        }
    }
    
    /// build up and return the URL for each endpoint
    var path: String {
        
        switch self {
        case .initSessionByUserToken, .initSessionByCredentials:
            return "/initSession"
        case .killSession:
            return "/killSession"
        case .getMyProfiles:
            return "/getMyProfiles"
        case .getActiveProfile:
            return "/getActiveProfile"
        case .changeActiveProfile:
            return "/changeActiveProfile"
        case .getMyEntities:
            return "/getMyEntities"
        case .getActiveEntities:
            return "/getActiveEntities"
        case .changeActiveEntities:
            return "/changeActiveEntities"
        case .getFullSession:
            return "/getFullSession"
        case .getGlpiConfig:
            return "/getGlpiConfig"
        case .getAllItems(let itemType, _):
            return "/\(itemType)"
        case .getItem(let itemType, let itemID, _):
            return "/\(itemType)/\(itemID)"
        case .getSubItems(let itemType, let itemID, let subItemType, _):
            return "/\(itemType)/\(itemID)/\(subItemType)"
        case .getMultipleItems:
            return "/getMultipleItems"
        case .addItems(let itemType, _):
            return "/\(itemType)"
        case .updateItems(let itemType, let itemID, _):
            if let id = itemID {
                return "/\(itemType)/\(id)"
            } else {
                return "/\(itemType)"
            }
        case .deleteItems(let itemType, let itemID, _, _):
            if let id = itemID {
                return "/\(itemType)/\(id)"
            } else {
                return "/\(itemType)"
            }
        case .lostPassword:
            return "/lostPassword"
        }
    }
    
    /// build up and return the query for each endpoint
    var query: [URLQueryItem]? {

        switch self {
        case .initSessionByUserToken, .initSessionByCredentials, .killSession, .getMyProfiles, .getActiveProfile,
             .changeActiveProfile, .getMyEntities, .getActiveEntities, .changeActiveEntities,
             .getFullSession, .getGlpiConfig, .getMultipleItems, .addItems, .updateItems, .lostPassword:
            return  nil
        case .getAllItems(_, let queryString):
            if queryString != nil {
                return queryString?.queryString.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                return nil
            }
        case .getItem(_, _, let queryString):
            
            if queryString != nil {
                return queryString?.queryString.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                return nil
            }
        case .getSubItems(_, _, _, let queryString):
            if queryString != nil {
                return queryString?.queryString.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                return nil
            }
        case .deleteItems(_, _, let queryString, _):
            if queryString != nil {
                return queryString?.queryString.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                return nil
            }
        }
    }
    
    /// build up and return the header for each endpoint
    var header: [String: String] {
        
        var dictHeader = [String: String]()
        dictHeader["Content-Type"] = "application/json"
        
        switch self {
        case .initSessionByUserToken(let userToken, let appToken) :
            
            dictHeader["Authorization"] = "user_token \(userToken)"
            
            if !appToken.isEmpty {
                dictHeader["App-Token"] = appToken
            }
            return dictHeader
        case .initSessionByCredentials(let user, let password, let appToken):
            let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let base64Credentials = credentialData.base64EncodedString()
            
            dictHeader["Authorization"] = "Basic \(base64Credentials)"
            
            if !appToken.isEmpty {
                dictHeader["App-Token"] = appToken
            }
            return dictHeader
        default:
            
            dictHeader["Session-Token"] = SESSION_TOKEN
            return dictHeader
        }
    }
    
    /**
     Returns a URL request or throws if an `Error` was encountered
     
     - throws: An `Error` if the underlying `URLRequest` is `nil`.
     - returns: A URL request.
     */
    public func request() -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dev.flyve.org"
        urlComponents.path = "/glpi/apirest.php" + path
        urlComponents.queryItems = query

        var urlRequest = URLRequest(url: urlComponents.url!)
        
        urlRequest.httpMethod = method.rawValue
        
        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        switch self {
        case .changeActiveProfile(let parameters), .changeActiveEntities(let parameters), .addItems(_, let parameters), .updateItems(_, _, let parameters), .lostPassword(let parameters), .deleteItems(_, _, _, let parameters):

            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    urlRequest.httpBody = jsonString.data(using: .utf8)
                }
            }
            return urlRequest
        default:
            return urlRequest
        }
    }
}

/// Types adopting the `URLRequestDelegate` protocol can be used to construct URL requests.
public protocol URLRequestDelegate {
    
    /// Returns a URL request
    ///
    /// - returns: A URL request.
    func request() -> URLRequest
}

public enum HTTPMethod : String {
    
    case options
    
    case get
    
    case head
    
    case post
    
    case put
    
    case patch
    
    case delete
    
    case trace
    
    case connect
}
