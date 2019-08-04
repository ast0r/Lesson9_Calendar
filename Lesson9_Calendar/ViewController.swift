//
//  ViewController.swift
//  Lesson9_Calendar
//
//  Created by Pavel Ivanov on 4/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lbYear: UILabel!
    
    var selectYear: Int = Int()
    var items:[Any] = []
    
    let viewModel = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.dataSource = self
        collectionView.delegate = self
        
        var dateComponents: DateComponents
        let dateYear = Date()
        let calendar = Calendar(identifier: .gregorian)
        dateComponents = calendar.dateComponents([.year], from: dateYear)
        lbYear.text = String(dateComponents.year!)
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //return 12
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 31
        return viewModel.numberOfRows(for: section, year: selectYear)
    }
    //MARK: - Collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  collectionView.frame.size.width / 7
        
        return CGSize(width: cellWidth, height: 70
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.contentView.backgroundColor = .white
        
        if let label = cell.contentView.viewWithTag(10) as? UILabel{
            
            label.text = ""
            
            let prewDayCount = self.viewModel.numberOfPrewDay(for: indexPath.section, year: selectYear)
            
            if (indexPath.row > prewDayCount - 1) {
                
                label.text = String(indexPath.row + 1 - prewDayCount)
            }
            
            
        }
        
        return cell
        
    }
    //MARK:- Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionFooter){
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            
            return footer
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! CalendarHeaderView
        
        header.lbHeader.text = viewModel.titleOfMonth(for: indexPath.section)
        
        return header
    }
    
    @IBAction func btMinusYear(_ sender: UIButton) {
        
        let strYear = lbYear.text
        var output = Int(strYear!)
        output = output!-1
        selectYear = output!
        DispatchQueue.main.async {
            self.lbYear.text = String(output!)
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func btPlusYear(_ sender: UIButton) {
        
        let strYear = lbYear.text
        var output = Int(strYear!)
        output = output!+1
        selectYear = output!
        DispatchQueue.main.async {
            self.lbYear.text = String(output!)
           // self.
        }
        
        collectionView.reloadData()
    }
}
