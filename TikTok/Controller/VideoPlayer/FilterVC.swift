//
//  FilterVC.swift
//  TikTok
//
//  Created by vishal singh on 29/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class FilterVC: Default {
    
    var typeArr = ["type1","type2","type3","type4"]
    
     var valueArrs = [["type1 value","type1 value","type1 value","type1 value"],["type2 value","type2 value","type2 value","type2 value"],["type3 value","type3 value","type3 value","type3 value"],["type4 value","type4 value","type4 value","type4 value"]]
    var selectValues = [[String]]()
    var typeSelected = 0

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var tableType: UITableView!
    @IBOutlet weak var tableValue: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewNav.btnOption.isHidden = true
        viewNav.lblTitle.text = "Filter"
        viewNav.btnBack.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()
        
        tableType.delegate = self
        tableType.dataSource = self
        tableValue.delegate = self
        tableValue.dataSource = self
        tableType.tableFooterView = UIView()
        tableValue.tableFooterView = UIView()
        tableValue.allowsMultipleSelection = true
        selectValues = valueArrs
        
        // Do any additional setup after loading the view.
    }

    @IBAction func clearAction(_ sender: UIButton) {
        selectValues = valueArrs
        tableValue.reloadData()
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableType{
            return typeArr.count
        }else{
            return valueArrs[typeSelected].count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableType{
            let cell = tableType.dequeueReusableCell(withIdentifier: "typecell", for: indexPath) as! FilterTypeCell
            cell.textLabel?.text = typeArr[indexPath.row]
            
            return cell
        }else{
            let cell = tableValue.dequeueReusableCell(withIdentifier: "valuecell", for: indexPath) as! FilterValueCell
            cell.textLabel?.text = valueArrs[typeSelected][indexPath.row]
            if selectValues[typeSelected][indexPath.row] == "1"{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }

            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != tableType{
            if tableValue.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                selectValues[typeSelected][indexPath.row] = "0"
                tableValue.cellForRow(at: indexPath)?.accessoryType = .none
            }else{
                selectValues[typeSelected][indexPath.row] = "1"
                tableValue.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
        }else{
            typeSelected = indexPath.row
            tableValue.reloadData()
        }
    }
    
    
    
}
