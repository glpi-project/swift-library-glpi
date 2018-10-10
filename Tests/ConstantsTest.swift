/**
 *  LICENSE
 *
 *  This file is part of the GLPI API Client Library for Swift,
 *  a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 *  Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  -----------------------------------------------------------------------------------
 *  @author    Hector Rondon - <hrondon@teclib.com>
 *  @copyright Copyright Teclib. All rights reserved.
 *  @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 *  @link      https://github.com/glpi-project/swift-library-glpi
 *  @link      https://glpi-project.github.io/swift-library-glpi/
 *  @link      http://www.glpi-project.org/
 *  -----------------------------------------------------------------------------------
 */

import Foundation
@testable import Glpi

class Constants {
    
    static var initSessionTesting: [String: String] {
        var dictionary = [String: String]()
        dictionary["userToken"] = "Zpel0XYzHP1GwTibOEDAY5VJvz8rfnPCE1FlYusu"
        dictionary["appToken"] = ""
        dictionary["method"] = "GET"
        return dictionary
    }
}
