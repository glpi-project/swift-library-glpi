//
/*
 * Copyright © 2017 Teclib. All rights reserved.
 *
 * QueryGetAllItems.swift is part of Glpi
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
 * @date      24/10/17
 * @copyright Copyright © 2017 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/[name]
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */
 

import Foundation

public enum orderType {
    case ASC
    case DESC
}

public struct QueryGetAllItems {
    public var expandDropdowns: Bool?
    public var getHateoas: Bool?
    public var onlyId: Bool?
    public var range: String?
    public var sort: Int?
    public var order: orderType?
    public var searchText: String?
    public var isDeleted: Bool?
    
    public init() {}
    
    var queryString: [String: AnyObject] {
        get {
            var query = [String: AnyObject]()
            if expandDropdowns != nil {
                query["expand_dropdowns"] = expandDropdowns as AnyObject
            }
            if getHateoas != nil {
                query["get_hateoas"] = getHateoas as AnyObject
            }
            if onlyId != nil {
                query["only_id"] = onlyId as AnyObject
            }
            if range != nil {
                query["range"] = range as AnyObject
            }
            if sort != nil {
                query["sort"] = sort as AnyObject
            }
            if order != nil {
                query["order"] = order as AnyObject
            }
            if searchText != nil {
                query["searchText"] = searchText as AnyObject
            }
            if isDeleted != nil {
                query["is_deleted"] = isDeleted as AnyObject
            }
            return query
        }
    }
}
