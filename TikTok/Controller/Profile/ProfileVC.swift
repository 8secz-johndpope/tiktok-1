//
//  ProfileVC.swift
//  TikTok
//
//  Created by vishal singh on 07/12/18.
//  Copyright © 2018 Deep. All rights reserved.
//

import UIKit

class ProfileVC: Default {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewNav: NavigationBarView!
    @IBOutlet weak var heightNav: NSLayoutConstraint!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var viewTab: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        

        collection.delegate = self
        collection.dataSource = self
        
        setBorder(view: viewTab)
       // setBorder(view: viewNav)
        imgProfile.layer.cornerRadius = 40
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.layer.borderWidth = 0.5
        
        btnFollow.layer.cornerRadius = 4
        lblDescription.sizeToFit()
        lblDescription.text = "Bio \nWrite your\nTest description"
        viewNav.btnBack.isHidden = true
      //  heightProfileView.constant = 170 + (lblDescription.bounds.height)
        self.view.layoutIfNeeded()
        //set navigation height
        heightNav.constant = getDevice()
        self.view.layoutIfNeeded()
        
        viewNav.btnOption.addTarget(self, action: #selector(self.showOption), for: .touchUpInside)
        
    
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func showOption(){
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "option") as! OptionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func AchievementAction(_ sender: UIButton) {
        let board = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "award") as! AwardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileGridCell
       // cell.lblLikes.addImage(imageName: "like")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (displyWidth - 0) / 3, height: ((displyWidth - 0) / 3) * 1.25)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
}
extension UILabel
{
    func addImage(imageName: String)
    {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
      //  attachmentString.append(myString)
        let temp:NSMutableAttributedString = attachmentString as! NSMutableAttributedString
        temp.append(myString)
        self.attributedText = temp
    }
}
