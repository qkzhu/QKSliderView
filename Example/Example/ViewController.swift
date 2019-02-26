//
//  ViewController.swift
//  Example
//
//  Created by QianKun on 23/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

import UIKit
import QKSliderView

class ViewController: UIViewController
{
    //MARK: - properties
    @IBOutlet weak var sliderViewForLargeCell: QKSliderView!
    @IBOutlet weak var sliderViewForFlatCell: QKSliderView!
    @IBOutlet weak var sliderViewForTwoXTwoCell: QKSliderView!
    
    
    //MARK: data sources
    private let largeCellDS = LargeCellDataSource()
    private let flatCellDS = FlatCellDataSource()
    private let simpleCellDS = SimpleCellDataSource()
    
    
    //MARK: - life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.largeCellDS.config(collectionView: self.sliderViewForLargeCell)
        self.flatCellDS.config(collectionView: self.sliderViewForFlatCell)
        self.simpleCellDS.config(collectionView: self.sliderViewForTwoXTwoCell)
    }
}
