//
//  DetailViewController.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
 
   
    @IBOutlet weak var btnLoadGmap: UIBarButtonItem!
    
    // create variable for catch value (send by segue)
    var lati: String?
    var long: String?
    var Image: String?
    var det_title: String?
    var det_description: String?
    var det_address : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // add data
        lblTitle.text = det_title
        lblDescription.text = det_description
        let dataImage =  Image!.data(using:.utf8)!
        self.ImageView.image = UIImage(data: dataImage)
        
    }
    
// create anthorsegue to locate google map
    @IBAction func load_Gmap(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "googleMap", sender: self)
    }
 
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "googleMap"{
             let destinationVC = segue.destination as!
             GoogleMapViewController
            // string to double 
            let numberFormatter = NumberFormatter()
            let number = numberFormatter.number(from: lati!)
            let f_lat =  number?.doubleValue

           
            let number1 = numberFormatter.number(from: long!)
            let f_log =  number1?.doubleValue
            destinationVC.G_lati = f_lat!
            destinationVC.G_long = f_log!
            destinationVC.G_address = det_address
        }
    }
}
