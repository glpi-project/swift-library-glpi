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

import UIKit
import Glpi

class ViewController: UIViewController {
    
    // MARK: Properties
    
    let cellId = "exampleCell"
    var responseAPI = [AnyObject]()
    
    /// This property contains the configurations for the table view
    lazy var exampleTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor = UIColor.init(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        table.isScrollEnabled = true
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
        return table
    }()

    // MARK: Methods
    
    /// Load the customized view that the controller manages
    override func loadView() {
        super.loadView()
        setupViews()
        addConstraints()
    }
    
    /// Set up the views of the controller
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Glpi API Client Example"
        view.addSubview(exampleTableView)
    }
    
    /// Add the constraints to the views of the controller
    func addConstraints() {
        exampleTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        exampleTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        exampleTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        exampleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func showResponse(index: IndexPath) {
        let responseController = ResponseController()
        responseController.result = self.responseAPI[index.row]["result"] as? String ?? ""
        navigationController?.pushViewController(responseController, animated: true)
    }
    
    func objectToString(_ object: Any) -> String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                print(object)
                return ""
            }
            
        } else {
            print(object)
            return ""
        }
    }
    
    func loadResponse(endpoint: String, result: String) {
        DispatchQueue.main.async {
            var responseAPIData = [String: String]()
            responseAPIData["endpoint"] = endpoint
            responseAPIData["result"] = result
            self.responseAPI.append(responseAPIData as AnyObject)
            self.exampleTableView.reloadData()
        }
    }
    
    func requestInitSession() {
        GlpiRequest.initSessionByUserToken(userToken: "HcA74wARMoEF8IXVfasNsX2FDufzaS7JMFT84FoC") { data, _, _ in
            self.responseAPI = [AnyObject]()
            self.loadResponse(endpoint: "initSession", result: self.objectToString(data as Any))
        }
    }
    
    func requestAllAPIs() {
        GlpiRequest.getMyProfiles { data, _, _ in
            self.loadResponse(endpoint: "getMyProfiles", result: self.objectToString(data as Any))
        }

        GlpiRequest.getActiveProfile { data, _, _ in
            self.loadResponse(endpoint: "getActiveProfile", result: self.objectToString(data as Any))

            GlpiRequest.changeActiveProfile(profileID: "4", completion: { _, _, _ in
                self.loadResponse(endpoint: "changeActiveProfile", result: "")
            })
        }

        GlpiRequest.getMyEntities { data, _, _ in
            self.loadResponse(endpoint: "getMyEntities", result: self.objectToString(data as Any))
        }

        GlpiRequest.getActiveEntities { data, _, _ in
            self.loadResponse(endpoint: "getActiveEntities", result: self.objectToString(data as Any))

            GlpiRequest.changeActiveEntities(entitiesID: "0", completion: { data, _, _ in
                self.loadResponse(endpoint: "changeActiveEntities", result: self.objectToString(data as Any))
            })
        }

        GlpiRequest.getFullSession { data, _, _ in
            self.loadResponse(endpoint: "getFullSession", result: self.objectToString(data as Any))
        }

        GlpiRequest.getAllItems(itemType: .Computer) { data, _, _ in
            self.loadResponse(endpoint: "getAllItems", result: self.objectToString(data as Any))
        }

        GlpiRequest.getItem(itemType: .Computer, itemID: 3) { data, _, _ in
            self.loadResponse(endpoint: "getAnItem", result: self.objectToString(data as Any))
        }

        GlpiRequest.getSubItems(itemType: .Computer, itemID: 3, subItemType: .ComputerModel) { data, _, _ in
            self.loadResponse(endpoint: "getSubItems", result: self.objectToString(data as Any))
        }
        
        GlpiRequest.listSearchOptions(itemType: .Computer) { data, _, _ in
            self.loadResponse(endpoint: "listSearchOptions", result: self.objectToString(data as Any))
        }
        
        GlpiRequest.searchItems(itemType: .Computer) { data, _, _ in
            self.loadResponse(endpoint: "searchItems", result: self.objectToString(data as Any))
        }
        
    }
    
    func requestKillSession() {
        GlpiRequest.killSession(completion: { data, _, _ in
            self.responseAPI = [AnyObject]()
            self.loadResponse(endpoint: "killSession", result: self.objectToString(data as Any))
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    /**
     override `numberOfSections` from super class, get number of sections
     
     - return: number of sections
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     override `numberOfRowsInSection` from super class, get number of row in sections
     
     - return: number of row in sections
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        } else {
            return responseAPI.count
        }
    }
    
    /**
     override `cellForRowAt` from super class, Asks the data source for a cell to insert in a particular location of the table view
     
     - return: `UITableViewCell`
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellId)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "Init Session"
            cell.detailTextLabel?.text = "SubTitle"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.textColor = .darkGray
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.text = "Call APIs"
            cell.detailTextLabel?.text = "SubTitle"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.textColor = .darkGray
        } else if indexPath.section == 0 && indexPath.row == 2 {
            cell.textLabel?.text = "Kill Session"
            cell.detailTextLabel?.text = "SubTitle"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.textColor = .darkGray
        } else {
            cell.textLabel?.text = responseAPI[indexPath.row]["endpoint"] as? String ?? "endpoint"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.textColor = .darkGray
        }

        return cell
    }
    
    /**
     override `cellForRowAt` from super class, Asks the data source for a cell to insert in a particular location of the table view
     
     - return: `UITableViewCell`
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "APIs"
        } else {
            return "RESPONSES"
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    /**
     override `didSelectRowAt` from super class, tells the delegate that the specified row is now selected
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            requestInitSession()
        } else if indexPath.section == 0 && indexPath.row == 1 {
            requestAllAPIs()
        } else if indexPath.section == 0 && indexPath.row == 2 {
            requestKillSession()
        } else if indexPath.section == 1 {
            showResponse(index: indexPath)
        }
    }
    
    /**
     override `willDisplayHeaderView` from super class
     */
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
            headerView.backgroundView?.backgroundColor = UIColor.init(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            textLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.bold)
            textLabel.textColor = UIColor.gray
        }
    }
}
