//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Smita Tamboli on 8/20/15.
//  Copyright (c) 2015 Cybage. All rights reserved.
//

import UIKit

class WeatherTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var weatherDetail:[WeatherReport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        var networkManager = NetworkManager()
        var searchText:String = searchBar.text
        
        searchBar.resignFirstResponder()
        
        networkManager.makeConnection(searchText, complition: { (weatherReport, error, errorMessage) -> Void in
            
            if let err = error as NSError? {
                
                let alertController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
                    //Do some stuff
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else if !(errorMessage == "") {
                
                let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .Alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
                    //Do some stuff
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else if let weatherArray = weatherReport as [WeatherReport]? {
                self.weatherDetail = weatherArray
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDetail.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CellTableViewCell
        
        var weatherReportObject:WeatherReport = self.weatherDetail[indexPath.row] as WeatherReport
        cell.weatherImage.image = nil
        cell.weatherImage.image = UIImage(named: "\(weatherReportObject.icon).png")
        cell.dayLabel.text = weatherReportObject.dt_txt
        cell.minTempLabel.text = "Min:\(weatherReportObject.temp_min)"
        cell.maxTempLabel.text = "Max:\(weatherReportObject.temp_max)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 78;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
