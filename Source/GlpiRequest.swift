//
/*
 * Copyright © 2017 Teclib. All rights reserved.
 *
 * Request.swift is part of Glpi
 *
 * Glpi is a subproject of Flyve MDM. Flyve MDM is a mobile
 * device management software.
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
 * @date      18/10/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/[name]
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */
 

import Foundation
import Alamofire

public class GlpiRequest {
    
    public init() {}
    
    /**
     Request a session token to uses other api endpoints.
     - parameter: user token
     - parameter: app token (optional)
     */
    public func initSession(userToken: String, appToken: String = "", completion: @escaping (_ result: Any?) -> Void) {

        Alamofire.request(Routers.initSession(userToken, appToken))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(_ ):
                    completion(self.handlerError(response))
                }
        }
    }
    
    /**
     handler Error
     - return: error message
     */
    func handlerError(_ response: DataResponse<Any>) -> [String: String] {
        
        var errorObj = [String]()
        var errorDict = [String: String]()
        
        if let data = response.data {
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
