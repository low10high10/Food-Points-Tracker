
import UIKit
import Charts

class chartViewController: UIViewController {

    @IBOutlet weak var FPSpentToday: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
       
       var DataValue = PieChartDataEntry(value: 0)
       var data = [PieChartDataEntry]()
       var month : [String:[[String:Any]]] = [:]
       var dictionary : [String:[String:[[String:Any]]]] = [:]
       var dayData : [[String:Any]] = []
       var places : [String:Double] = [:]
       var numPlaces : Int = 0
       var track: Double = 0.0
    var total: Double = 0.0
    
       override func viewDidLoad() {
           super.viewDidLoad()
           pieChart.chartDescription?.text = "Food Point Distribution"
           pieChart.rotationEnabled = false
           pieChart.drawHoleEnabled = false
           pieChart.drawEntryLabelsEnabled = false
           pieChart.usePercentValuesEnabled = true
           
           let file = dataRefiner()
           dictionary = file.getDict()!
           if !dictionary.isEmpty {
                for months in dictionary.keys {
                   month = dictionary[months]!
                   for day in month.keys {
                       dayData = month[day]!
                       for transaction in dayData {
                           if(places[transaction["Location"] as? String ?? ""] == nil){
                               places[transaction["Location"] as? String ?? ""] = Double(transaction["Used"] as? String ?? "")
                           } else {
                               places[transaction["Location"] as? String ?? ""] = places[transaction["Location"] as? String ?? ""]! + Double(transaction["Used"] as? String ?? "")!
                           }
                       }
                   }
            }
               let sortedDict = places.sorted(by: { $0.value > $1.value })
               data = []
            
               for item in sortedDict {
                if sortedDict[0].value/item.value > 5 {
                    track = track + item.value
                } else {
                    data.append(PieChartDataEntry(value: item.value, label: item.key))
                    numPlaces += 1
                }
                total += item.value
//                  if (numPlaces < places.count-10 ) {
//                      track = track + item.value
//                  }
//                  if (numPlaces==places.count-10) {
//                     track = track + item.value
//                     data.append(PieChartDataEntry(value: track, label: "Others"))
//                  }
//                  if (numPlaces>places.count-10) {
//                     data.append(PieChartDataEntry(value: item.value, label: item.key))
//                  }
//                   numPlaces += 1
               }
            numPlaces += 1
            data.append(PieChartDataEntry(value: track, label: "Others"))
            
            FPSpentToday.text = String(total)
               pieChart.animate(xAxisDuration: 1)
               updateData()
           }
       }
       
       func updateData() {
           let chartDataSet = PieChartDataSet(entries: data, label: nil)
        chartDataSet.colors = makeColors(count: data.count)
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
               wavelength = Double(i)*300.0/Double(count - 1) + 400.0
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
               } else if ((wavelength >= 650) && (wavelength <= 750)) {
                   r = 1.0;
                   g = 1.0 - (wavelength - 650.0) / (750.0 - 650.0);
                   b = 0.0;
               }

               colors.append(NSUIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0))
           }
           return colors
       }

}
