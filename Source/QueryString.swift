//
/*
 * Copyright © 2017 Teclib. All rights reserved.
 *
 * QueryString.swift is part of Glpi
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
 * @link      https://github.com/glpi-project/swift-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */
 

import Foundation

public struct QueryString {
    
    public init() {}
    
    public enum orderType {
        case ASC
        case DESC
    }
    
    public struct GetAllItems {
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
    
    public struct GetAnItem {
        public var expandDropdowns: Bool?
        public var getHateoas: Bool?
        public var getSha1: Bool?
        public var withDevices: Bool?
        public var withDisks: Bool?
        public var withSoftwares: Bool?
        public var withConnections: Bool?
        public var withNetworkports: Bool?
        public var withInfocoms: Bool?
        public var withContracts: Bool?
        public var withDocuments: Bool?
        public var withTickets: Bool?
        public var withProblems: Bool?
        public var withChanges: Bool?
        public var withNotes: Bool?
        public var withLogs: Bool?
        
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
                if getSha1 != nil {
                    query["get_sha1"] = getSha1 as AnyObject
                }
                if withDevices != nil {
                    query["with_devices"] = withDevices as AnyObject
                }
                if withDisks != nil {
                    query["with_disks"] = withDisks as AnyObject
                }
                if withSoftwares != nil {
                    query["with_softwares"] = withSoftwares as AnyObject
                }
                if withConnections != nil {
                    query["with_connections"] = withConnections as AnyObject
                }
                if withNetworkports != nil {
                    query["with_networkports"] = withNetworkports as AnyObject
                }
                if withInfocoms != nil {
                    query["with_infocoms"] = withInfocoms as AnyObject
                }
                if withContracts != nil {
                    query["with_contracts"] = withContracts as AnyObject
                }
                if withDocuments != nil {
                    query["with_documents"] = withDocuments as AnyObject
                }
                if withTickets != nil {
                    query["with_tickets"] = withTickets as AnyObject
                }
                if withProblems != nil {
                    query["with_problems"] = withProblems as AnyObject
                }
                if withChanges != nil {
                    query["with_changes"] = withChanges as AnyObject
                }
                if withNotes != nil {
                    query["with_notes"] = withNotes as AnyObject
                }
                if withLogs != nil {
                    query["with_logs"] = withLogs as AnyObject
                }
                return query
            }
        }
    }
    
    public struct GetSubItems {
        public var expandDropdowns: Bool?
        public var getHateoas: Bool?
        public var onlyId: Bool?
        public var range: String?
        public var sort: Int?
        public var order: orderType?
        
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
                return query
            }
        }
    }
    
    public struct DeleteItems {
        public var forcePurge: Bool?
        public var history: Bool?
        
        public init() {}
        
        var queryString: [String: AnyObject] {
            get {
                var query = [String: AnyObject]()
                if forcePurge != nil {
                    query["force_purge"] = forcePurge as AnyObject
                }
                if history != nil {
                    query["history"] = history as AnyObject
                }
                return query
            }
        }
    }
}
