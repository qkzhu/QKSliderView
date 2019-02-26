//
//  FlatCell.swift
//  Example
//
//  Created by qkzhu on 25/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

import UIKit

class FlatCell: UICollectionViewCell
{
    //MARK: - properties
    static let CellID = "FlatCellId"
    
    //MARK: UI Components
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var lblDesc: UILabel = {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.clipsToBounds = true
        
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let iv = UIImageView()
        self.contentView.addSubview(iv)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        
        return iv;
    }()
    
    private lazy var btnPurchase: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        self.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("GET", for: .normal)
        button.setTitleColor(UIColor.blue.withAlphaComponent(0.6), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 12
        
        return button
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
    func config(data: FlatCellData)
    {
        self.lblTitle.text = data.title
        self.lblDesc.text = data.desc
        self.imgView.image = UIImage(named: data.imageName)
    }
    
    //MARK: - private functions
    private func setupUI()
    {
        self.clipsToBounds = true
        self.contentView.clipsToBounds = true
        
        // image view
        self.imgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.imgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        self.imgView.widthAnchor.constraint(equalTo: self.imgView.heightAnchor, multiplier: 1).isActive = true
        
        // purchase button
        self.btnPurchase.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.btnPurchase.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.btnPurchase.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.btnPurchase.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //  title label
        self.lblTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 8).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.btnPurchase.leadingAnchor, constant: 8).isActive = true
        self.lblTitle.setContentHuggingPriority(.required, for: .vertical)
        
        // description label
        self.lblDesc.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 4).isActive = true
        self.lblDesc.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 8).isActive = true
        self.lblDesc.trailingAnchor.constraint(equalTo: self.btnPurchase.leadingAnchor, constant: -8).isActive = true
        let lblDescBottom = self.lblDesc.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        lblDescBottom.priority = .defaultLow
        lblDescBottom.isActive = true
    }
}


class FlatCellDataSource: NSObject, UICollectionViewDataSource
{
    //MARK: - properties
    private var data: [FlatCellData] = []
    
    //MARK: - life cycle
    override init()
    {
        super.init()
        self.setupData()
    }
    
    
    //MARK: - public function
    func config(collectionView: UICollectionView)
    {
        collectionView.register(FlatCell.self, forCellWithReuseIdentifier: FlatCell.CellID)
        collectionView.dataSource = self
    }
    
    
    //MARK: - private functions
    private func setupData()
    {
        self.data.append(FlatCellData(title: "Boost Buddies", desc: "Deceptively Cute and Hardcore!", imageName: "flat0"))
        self.data.append(FlatCellData(title: "Noa Noa!", desc: "Vitural Pet Collector!", imageName: "flat1"))
        self.data.append(FlatCellData(title: "Match Mountain", desc: "A Match Puzzle RPG Adventure", imageName: "flat2"))
        self.data.append(FlatCellData(title: "Mini Metro", desc: "Build a better tube", imageName: "flat3"))
        self.data.append(FlatCellData(title: "Hit the Light", desc: "Magnetic stress killer", imageName: "flat4"))
        self.data.append(FlatCellData(title: "Knights of the Card Table", desc: "A Dungeon Card Crawler", imageName: "flat5"))
        self.data.append(FlatCellData(title: "Flip That Table!", desc: "Need to vent some anger?", imageName: "flat6"))
    }
    
    
    //MARK: - data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlatCell.CellID, for: indexPath) as! FlatCell
        cell.config(data: self.data[indexPath.item])
        
        return cell
    }
}

struct FlatCellData
{
    let title: String
    let desc: String
    let imageName: String
}
