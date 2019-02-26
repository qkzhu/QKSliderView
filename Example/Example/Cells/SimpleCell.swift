//
//  SimpleCell.swift
//  Example
//
//  Created by QianKun on 25/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

import UIKit

class SimpleCell: UICollectionViewCell
{
    //MARK: - properties
    static let CellID = "SimpleCellId"
    
    //MARK: UI Components
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.clipsToBounds = true
        
        return label
    }()
    
    
    //MARK: - life cycle
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - public functions
    func config(data: SimpleCellData)
    {
        self.lblTitle.text = data.title
    }
    
    //MARK: - private functions
    private func setupUI()
    {
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        //  title label
        self.lblTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
}


class SimpleCellDataSource: NSObject, UICollectionViewDataSource
{
    //MARK: - properties
    private var data: [SimpleCellData] = []
    
    //MARK: - life cycle
    override init()
    {
        super.init()
        self.setupData()
    }
    
    
    //MARK: - public function
    func config(collectionView: UICollectionView)
    {
        collectionView.register(SimpleCell.self, forCellWithReuseIdentifier: SimpleCell.CellID)
        collectionView.dataSource = self
    }
    
    
    //MARK: - private functions
    private func setupData()
    {
        for i in 0..<17
        {
            self.data.append(SimpleCellData(title: String(format: "%.2lu", i)))
        }
    }
    
    private func randomColor() -> UIColor
    {
        return UIColor(displayP3Red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue: CGFloat(arc4random()) / CGFloat(UInt32.max), alpha: 1)
    }
    
    //MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCell.CellID, for: indexPath) as! SimpleCell
        cell.config(data: self.data[indexPath.item])
        cell.backgroundColor = self.randomColor()
        
        return cell
    }
}

struct SimpleCellData
{
    let title: String
}
