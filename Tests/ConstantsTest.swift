//
/*
 * LICENSE
 *
 * ConstantsTest.swift is part of Glpi
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
 * @author    Hector Rondon <hrondon@teclib.com>
 * @date      26/10/17
 * @copyright Copyright © 2017-2018 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/glpi-project/swift-library-glpi
 * @link      https://glpi-project.github.io/swift-library-glpi/
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */
 

import Foundation
@testable import Glpi

class Constants {
    
    static var initSessionTesting: [String: String] {
        var dictionary = [String: String]()
        dictionary["userToken"] = "pe90W27ebPXIeYXsj2mYE0nMrRz9q1AlguKhbhcI"
        dictionary["appToken"] = ""
        dictionary["method"] = "GET"
        return dictionary
    }
}
