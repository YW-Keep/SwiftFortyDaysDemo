//
//  LocationViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/23.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var showTwoLabel: UILabel!
    let locateManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locateManager.delegate = self
        // 获取定位权限
        self.locateManager.requestWhenInUseAuthorization()
        // 判读是不是有定位权限
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied {
            self.showLabel.text = "请打开定位！！！"
        }
        // 精准度
        locateManager.desiredAccuracy = kCLLocationAccuracyBest
        // Do any additional setup after loading the view.
    }

    @IBAction func localizeAction(_ sender: UIButton) {
      //开始定位
      locateManager.startUpdatingLocation()
    }
    @IBAction func changeAction(_ sender: Any) {
        
        if inputTextField.text != nil {
            CLGeocoder().geocodeAddressString(inputTextField.text!, completionHandler: { (pms, err) in
                if pms != nil {
                    let placemark:CLPlacemark = (pms?.last)!
                    self.showTwoLabel.text = "latitude:" + String(describing: placemark.location!.coordinate.latitude) + "\n" + "longitude:" + String(describing: placemark.location!.coordinate.longitude) + "\n" +  placemark.name!
                }
            })
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 获取最后一个位置
        if let location = locations.last {
            // 反编码显示
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (pms, err) in
                if pms != nil {
                    let placemark:CLPlacemark = (pms?.last)!
                    self.showLabel.text = placemark.country! + placemark.administrativeArea! + placemark.locality! + placemark.subLocality! + placemark.name!
                }
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
