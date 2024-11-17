//
//  LettersCollectionHandler.swift
//

import UIKit

class LettersCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categories = [String]()
    var didSelect: ((IndexPath) -> Void)? = nil


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LetterCell.className, for: indexPath) as! LetterCell
        
        cell.titleLbl.text = categories[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: 0)) as! LetterCell
        
        cell.viewBg.backgroundColor = UIColor(named: "themeblue")

        
        self.didSelect?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: 0)) as! LetterCell
        
        cell.viewBg.backgroundColor = UIColor(named: "themelightgray")

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / 4) - 10  // 4 items per row with spacing
        return CGSize(width: width, height: width)
        
    }
    
}
