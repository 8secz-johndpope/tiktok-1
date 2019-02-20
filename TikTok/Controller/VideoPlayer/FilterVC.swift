//
//  FilterVC.swift
//  TikTok
//
//  Created by vishal singh on 29/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class FilterVC: Default {
    
    var typeArr = ["Region","Category","Age","Sort By"]
    var country = ["Country1","Country2","Country3","Country4","Country5","Country6","Country7","Country8","Country9","Country10","Country1","Country2","Country3","Country4","Country5","Country6","Country7","Country8","Country9","Country10"]

    var state = ["State1","State2","State3","State4","State5","State7","State8","State9","State10","State11"]
    
     var valueArrs = [["Global","Country"],["Category Name1","Category Name2","Category Name3","Category Name4","Category Name5","Category Name6","Category Name7","Category Name8"],["Below 14","Above 14"],["Most viewed","Most liked","Top ranked","Recent uploaded"]]
    var selectValues = [[String]]()
    var typeSelected = 0
    var showCountry = false
    var showState = false

    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var tableType: UITableView!
    @IBOutlet weak var tableValue: UITableView!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setBorder(view: tableType)
        setBorder(view: tableValue)
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
        
        // design apply and clear button
        btnClear.backgroundColor = appColor
        btnClear.layer.borderColor = UIColor.gray.cgColor
        btnClear.layer.borderWidth = 0.5
        btnApply.backgroundColor = appColor
        btnApply.layer.borderColor = UIColor.gray.cgColor
        btnApply.layer.borderWidth = 0.5
        
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
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        }else{
            let cell = tableValue.dequeueReusableCell(withIdentifier: "valuecell", for: indexPath) as! FilterValueCell
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?
                .font = UIFont.systemFont(ofSize: 15.0)


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
            if typeSelected == 0{
                if indexPath.row == 1 {
                    // regin - country selected
                    
                    if showCountry != true{
                        showCountry = true
                        typeArr.insert("Country", at: 1)
                        valueArrs.insert(country, at: 1)
                        selectValues.insert(country, at: 1)
                        tableType.reloadData()
                    }else{
                        // already country added
                    }
                    selectValues[typeSelected][1] = "1"
                    selectValues[typeSelected][0] = "0"
                    tableValue.reloadData()

                }else if indexPath.row == 0{
                    if showState == true{
                        typeArr.remove(at: 2)
                        valueArrs.remove(at: 2)
                        selectValues.remove(at: 2)
                        showState = false
                        typeArr.remove(at: 1)
                        valueArrs.remove(at: 1)
                        selectValues.remove(at: 1)
                        showCountry = false
                        tableType.reloadData()
                    }else if showCountry == true{
                        typeArr.remove(at: 1)
                        valueArrs.remove(at: 1)
                        selectValues.remove(at: 1)
                        showCountry = false
                        tableType.reloadData()
                    }else{
                        // regin - globle selected
                    }
                    selectValues[typeSelected][0] = "1"
                    selectValues[typeSelected][1] = "0"
                    tableValue.reloadData()
                }
            }else if typeSelected == 1{
                if showState == true{
                    for i in 0..<valueArrs[typeSelected].count {
                        if i == indexPath.row {
                            selectValues[typeSelected][i] = "1"
                        }else{
                            selectValues[typeSelected][i] = "0"
                            
                        }
                    }
                    tableValue.reloadData()
                }else if showCountry == true{
                    showState = true
                    typeArr.insert("State", at: 2)
                    valueArrs.insert(state, at: 2)
                    selectValues.insert(state, at: 2)
                    tableType.reloadData()
                    
                    
                    
                }else{
                    if tableValue.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                        selectValues[typeSelected][indexPath.row] = "0"
                        tableValue.cellForRow(at: indexPath)?.accessoryType = .none
                    }else{
                        selectValues[typeSelected][indexPath.row] = "1"
                        tableValue.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    }
                }
            }else if typeSelected == typeArr.count - 1{
                for i in 0..<valueArrs[typeSelected].count {
                    if i == indexPath.row {
                        selectValues[typeSelected][i] = "1"
                    }else{
                        selectValues[typeSelected][i] = "0"

                    }
                }
                tableValue.reloadData()
                
            }else{
                if tableValue.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                    selectValues[typeSelected][indexPath.row] = "0"
                    tableValue.cellForRow(at: indexPath)?.accessoryType = .none
                }else{
                    selectValues[typeSelected][indexPath.row] = "1"
                    tableValue.cellForRow(at: indexPath)?.accessoryType = .checkmark
                }
            }
            
            
            
        }else{
           //
            tableType.cellForRow(at: indexPath)?.backgroundColor = UIColor.darkGray
            typeSelected = indexPath.row
            if indexPath.row == 0 || indexPath.row == typeArr.count - 1 {
                tableValue.allowsMultipleSelection = false
            }else{
                if showCountry == true{
                    if indexPath.row == 2{
                        tableValue.allowsMultipleSelection = false
                    }else{
                        tableValue.allowsMultipleSelection = true
                    }
                }else{
                    tableValue.allowsMultipleSelection = true
                }
            }
            tableValue.reloadData()
        }
    }
    
    
    
}
