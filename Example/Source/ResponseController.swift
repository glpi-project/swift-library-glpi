/*
 * LICENSE
 *
 * ResponseController.swift is part of the GLPI API Client Library for Swift,
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
 * @author    Hector Rondon <hrondon@teclib.com>
 * @date      27/10/17
 * @copyright Copyright © 2017-2018 Teclib. All rights reserved.
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/glpi-project/swift-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
 */

import UIKit

class ResponseController: UIViewController {
    
    // MARK: Properties
    
    var result: String?
    
    let webViewRespponse: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    // MARK: Methods
    
    /// Load the customized view that the controller manages
    override func loadView() {
        super.loadView()
        setupViews()
        addConstraints()
        webViewRespponse.loadHTMLString(result ?? "", baseURL: nil)
//        webViewRespponse.load(result!.data(using: String.Encoding.utf8, allowLossyConversion: true)!, mimeType: "application/json", textEncodingName: "UTF-8", baseURL: nil)
        
    }
    
    /// Set up the views of the controller
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(webViewRespponse)
    }
    
    /// Add the constraints to the views of the controller
    func addConstraints() {
        webViewRespponse.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webViewRespponse.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webViewRespponse.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webViewRespponse.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
