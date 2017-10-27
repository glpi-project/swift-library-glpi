/*
 * LICENSE
 *
 * ViewController.swift is part of the GLPI API Client Library for Swift,
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
 * @date      13/10/17
 * @copyright (C) 2017 Teclib' and contributors
 * @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 * @link      https://github.com/flyve-mdm/ios-library-glpi
 * @link      http://www.glpi-project.org/
 * ------------------------------------------------------------------------------
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
        table.rowHeight = UITableViewAutomaticDimension
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
    
    func requestInitSession() {
        GlpiRequest.initSession(userToken: "L8B3f4iiNIjg8W2Kla1AXFjJsYrWxVqDozMzq2G7") { response in
            
            let jsonData = try? JSONSerialization.data(withJSONObject: response as Any, options: .prettyPrinted)
            let jsonString = String(data: jsonData!, encoding: .utf8)!
            
            var responseAPIData = [String: String]()
            responseAPIData["endpoint"] = "initSession"
            responseAPIData["result"] = jsonString
            self.responseAPI.append(responseAPIData as AnyObject)
            self.exampleTableView.reloadData()
        }
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
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
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
