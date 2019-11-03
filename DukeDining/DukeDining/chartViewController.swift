//
//  chartViewController.swift
//  DukeDining
//
//  Created by Oliver Adolfo Rodas on 11/2/19.
//  Copyright © 2019 Duke University. All rights reserved.
//

import UIKit
import Charts

class chartViewController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
       
       var DataValue = PieChartDataEntry(value: 0)
       var data = [PieChartDataEntry]()
       var month : [String:[[String:Any]]] = [:]
       var dictionary : [String:[String:[[String:Any]]]] = [:]
       var dayData : [[String:Any]] = []
       var places : [String:Double] = [:]
       var numPlaces : Int = 0
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           pieChart.chartDescription?.text = "Food Point Distribution"
           pieChart.rotationEnabled = false
           pieChart.drawHoleEnabled = false
           pieChart.drawEntryLabelsEnabled = false
           
           let file = dataRefiner()
           dictionary = file.getDict()!
           if !dictionary.isEmpty {
                for months in dictionary.keys {
                   month = dictionary[months]!
                   for day in month.keys {
                       dayData = month[day]!
                       for transaction in dayData {
                           if(places[transaction["Location"] as? String ?? ""] == nil){
                               places[transaction["Location"] as? String ?? ""] = Double(transaction["Cost"] as? String ?? "")
                           } else {
                               places[transaction["Location"] as? String ?? ""] = places[transaction["Location"] as? String ?? ""]! + Double(transaction["Cost"] as? String ?? "")!
                           }
                           
                       }
                   }
            }
               let sortedDict = places.sorted(by: { $0.value < $1.value })
               data = []
               for item in sortedDict {
                   data.append(PieChartDataEntry(value: item.value, label: item.key))
                   numPlaces += 1
               }
               
               
               
               pieChart.animate(xAxisDuration: 1)
               print(data)
               updateData()
           }
       }
       
       func updateData() {
           let chartDataSet = PieChartDataSet(entries: data, label: nil)
           chartDataSet.colors = makeColors(count: numPlaces)
           chartDataSet.valueTextColor = NSUIColor.black
           pieChart.data = PieChartData(dataSet: chartDataSet)
       }
       
       func makeColors(count : Int) -> [NSUIColor] {
           var colors : [NSUIColor] = []
           var r : Double = 0
           var g : Double = 0
           var b : Double = 0
           var wavelength : Double = 0
           for i in 0 ..< count {
               wavelength = Double(i)*300.0/Double(count) + 400.0
               if ((wavelength >= 400) && (wavelength < 450)) {
                   r = 1.0;
                   g = 0;
                   b = (wavelength - 400.0)/(450.0 - 400.0);
               } else if ((wavelength >= 450) && (wavelength < 500)) {
                   r = 1.0 - (wavelength - 450.0) / (500.0 - 450.0);
                   g = 0.0;
                   b = 1.0;
               } else if ((wavelength >= 500) && (wavelength < 550)) {
                   r = 0.0;
                   g = (wavelength - 500.0) / (550.0 - 500.0);
                   b = 1.0;
               } else if ((wavelength >= 550) && (wavelength < 600)) {
                   r = 0.0;
                   g = 1.0;
                   b = 1.0 - (wavelength - 550.0) / (600.0 - 550.0);
               } else if ((wavelength >= 600) && (wavelength < 650)) {
                   r = (wavelength - 600.0) / (650.0 - 600.0);
                   g = 1.0;
                   b = 0.0;
               } else if ((wavelength >= 650) && (wavelength <= 700)) {
                   r = 1.0;
                   g = 1.0 - (wavelength - 650.0) / (700.0 - 650.0);
                   b = 0.0;
               }
               colors.append(NSUIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0))
           }
           return colors
       }

}
