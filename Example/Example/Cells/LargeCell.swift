//
//  LargeCell.swift
//  Example
//
//  Created by QianKun on 24/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

import UIKit

class LargeCell: UICollectionViewCell
{
    //MARK: - properties
    static let CellID = "LargeCellId"
    
    //MARK: UI Components
    private lazy var lblCategory: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .blue
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var lblName: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var lblDesc: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let iv = UIImageView()
        self.contentView.addSubview(iv)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 4
        
        return iv;
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
    func config(data: LargeCellData)
    {
        self.lblCategory.text = data.category
        self.lblName.text = data.name
        self.lblDesc.text = data.desc
        self.imgView.image = UIImage(named: data.imageName)
    }
    
    //MARK: - private functions
    private func setupUI()
    {
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        self.layer.cornerRadius = 4
        
        // category label
        self.lblCategory.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4).isActive = true
        self.lblCategory.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.lblCategory.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.lblCategory.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        // name label
        self.lblName.topAnchor.constraint(equalTo: self.lblCategory.bottomAnchor, constant: 4).isActive = true
        self.lblName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.lblName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.lblName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // description label
        self.lblDesc.topAnchor.constraint(equalTo: self.lblName.bottomAnchor, constant: 4).isActive = true
        self.lblDesc.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.lblDesc.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.lblDesc.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // image view
        self.imgView.topAnchor.constraint(equalTo: self.lblDesc.bottomAnchor, constant: 4).isActive = true
        self.imgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imgView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}


class LargeCellDataSource: NSObject, UICollectionViewDataSource
{
    //MARK: - properties
    private var data: [LargeCellData] = []
    
    //MARK: - life cycle
    override init()
    {
        super.init()
        self.setupData()
    }
    
    
    //MARK: - public function
    func config(collectionView: UICollectionView)
    {
        collectionView.register(LargeCell.self, forCellWithReuseIdentifier: LargeCell.CellID)
        collectionView.dataSource = self
    }
    
    
    //MARK: - private functions
    private func setupData()
    {
        self.data.append(LargeCellData(category: "EXCLUSIVE", name: "PUBG MOBILE",
                                       desc: "It's a Resident Evil 2 invasion", imageName: "large0"))
        self.data.append(LargeCellData(category: "NEW UPDATE", name: "LUMINO CITY",
                                       desc: "A handmade puzzle adventure", imageName: "large1"))
        self.data.append(LargeCellData(category: "NEW UPDATE", name: "BRAWL STARS",
                                       desc: "Team up and jump into battle!", imageName: "large2"))
        self.data.append(LargeCellData(category: "LIMITED TIME", name: "TRANSISTOR",
                                       desc: "Supergiant Games, LLC", imageName: "large3"))
        self.data.append(LargeCellData(category: "NEW UPDATE", name: "SPICY PIGGY",
                                       desc: "The hardest platformer ever!", imageName: "large4"))
    }
    
    //MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCell.CellID, for: indexPath) as! LargeCell
        cell.config(data: self.data[indexPath.item])
        return cell
    }
}

struct LargeCellData
{
    let category: String
    let name: String
    let desc: String
    let imageName: String
}
