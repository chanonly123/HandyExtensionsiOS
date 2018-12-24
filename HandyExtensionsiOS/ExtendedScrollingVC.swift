//
//  ExtendedScrolingVC.swift
//  HandyExtensionsiOS
//
//  Created by Chandan on 23/12/18.
//  Copyright © 2018 Chandan. All rights reserved.
//

import UIKit

class ExtendedScrollingVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var selectedType: LayoutTypes!
    
    var arrImgs1: [UIImage] = []
    var arrImgs2: [UIImage] = []
    
    var arrLbl1: [String] = []
    var arrLbl2: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        selectedType = .horizontalScale
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        
        arrLbl1 = ["Your Profile Is Anonymous", "Answer Questions Win Money", "Win Real Money Directly To Wallet", "Your Profile Is Anonymous", "Answer Questions Win Money", "Win Real Money Directly To Wallet"]
        arrImgs1 = [#imageLiteral(resourceName: "Onboarding_screen1_background"), #imageLiteral(resourceName: "Onboarding_screen2_background"), #imageLiteral(resourceName: "Onboarding_screen3_background"), #imageLiteral(resourceName: "Onboarding_screen1_background"), #imageLiteral(resourceName: "Onboarding_screen2_background"), #imageLiteral(resourceName: "Onboarding_screen3_background")]
        arrImgs2 = [#imageLiteral(resourceName: "Onboarding_screen1_designelements"), #imageLiteral(resourceName: "Onboarding_screen2_designelements"), #imageLiteral(resourceName: "Onboarding_screen3_designelements"), #imageLiteral(resourceName: "Onboarding_screen1_designelements"), #imageLiteral(resourceName: "Onboarding_screen2_designelements"), #imageLiteral(resourceName: "Onboarding_screen3_designelements")]
        arrLbl2 = ["Be your true self and chat with strangers and enjoy unlimited fun with Poll, Play & much more", "Tap the answer out of 3 options in 10 seconds", "Play the game everyday and win", "Be your true self and chat with strangers and enjoy unlimited fun with Poll, Play & much more", "Tap the answer out of 3 options in 10 seconds", "Play the game everyday and win"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Types", style: .plain, target: self, action: #selector(switchTypes))
    }
    
    @objc func switchTypes() {
        let sheet = UIAlertController(title: "Types", message: "Select type", preferredStyle: UIAlertControllerStyle.actionSheet)
        sheet.addAction(UIAlertAction(title: LayoutTypes.horizontalScale.rawValue, style: UIAlertActionStyle.default, handler: { [weak self] _ in
            self?.selectedType = LayoutTypes.horizontalScale
            self?.invalidateLayout(vertical: false)
        }))
        sheet.addAction(UIAlertAction(title: LayoutTypes.verticalScale.rawValue, style: UIAlertActionStyle.default, handler: { [weak self] _ in
            self?.selectedType = LayoutTypes.verticalScale
            self?.invalidateLayout(vertical: true)
        }))
        present(sheet, animated: true, completion: nil)
    }
    
    func invalidateLayout(vertical: Bool) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = vertical ? .vertical : .horizontal
            layout.invalidateLayout()
            collectionView.reloadData()
        }
    }
}

extension ExtendedScrollingVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach { cell in
            if let cell = cell as? CollViewCell {
                let moveX = (cell.index * scrollView.bounds.width) - scrollView.contentOffset.x
                let ratioX = abs(moveX / scrollView.bounds.width)
                
                let moveY = (cell.index * scrollView.bounds.height) - scrollView.contentOffset.y
                let ratioY = abs(moveY / scrollView.bounds.height)
                
                print("moveX: \(moveX), ratioX: \(ratioX), moveY: \(moveY), ratioY: \(ratioY)")
                
                switch selectedType {
                case .horizontalScale?:
                    cell.contentView.alpha = 1 - ratioX
                    
                    let ratioNewX = 1 - ratioX / 3
                    
                    cell.img1.transform = CGAffineTransform(translationX: moveX * 0.2, y: 0).concatenating(CGAffineTransform(scaleX: ratioNewX, y: ratioNewX))
                    cell.img2.transform = CGAffineTransform(translationX: moveX * 0.6, y: 0)
                    cell.lbl1.transform = CGAffineTransform(translationX: moveX * 0.1, y: ratioX * 20)
                    cell.lbl2.transform = CGAffineTransform(translationX: moveX * 0.3, y: ratioX * 30)
                    
                case .verticalScale?:
                    cell.contentView.alpha = 1 - ratioY
                    
                    let ratioNewY = 1 - ratioY / 2
                    
                    cell.img1.transform = CGAffineTransform(translationX: moveY, y: moveY * 0.2)
                    cell.img2.transform = CGAffineTransform(translationX: -moveY, y: moveY * 0.1)
                    cell.lbl1.transform = CGAffineTransform(translationX: 0, y: moveY * 0.15).concatenating(CGAffineTransform(scaleX: ratioNewY, y: ratioNewY))
                    cell.lbl2.transform = CGAffineTransform(translationX: 0, y: moveY * 0.2)
                    
                case .none:
                    break
                }
            }
        }
    }
}

extension ExtendedScrollingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgs1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollViewCell", for: indexPath) as! CollViewCell
        
        cell.img1.image = arrImgs1[indexPath.item]
        cell.img2.image = arrImgs2[indexPath.item]
        cell.lbl1.text = arrLbl1[indexPath.item]
        cell.lbl2.text = arrLbl2[indexPath.item]
        cell.index = CGFloat(indexPath.item)
        
        return cell
    }
}

extension ExtendedScrollingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class CollViewCell: UICollectionViewCell {
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    var index: CGFloat = 0
}

fileprivate enum LayoutTypes: String {
    case verticalScale = "Vertical scale"
    case horizontalScale = "Horizontal scale"
}
