//
//  LoadDataViewController.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/18.
//

import UIKit

class LoadDataViewController: UIViewController,UITextFieldDelegate {

 // TableView
    @IBOutlet weak var TableView: UITableView!
    // Search text box
    @IBOutlet weak var txtSearch: UITextField!
    // this data set use for get all data
    var dataList = [Data]()
    // this data set use for after search iteams those items insert
    var filetreData = [Data]()
    //this use for search item fileter
    var isFiltered  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // customaize tableview cell registering
        TableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        // loading data function
       loadingData()
    }
    

    func loadingData(){
        // give url for retriving data
        let hotelUrl = "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json"
        // create url
        if let url = URL(string: hotelUrl){
            URLSession.shared.dataTask(with:URLRequest(url: url)){(data,response,error) in
                do{
                    let result = try JSONDecoder().decode(getdata.self, from: data!)
                    DispatchQueue.main.async {
                       // adding data to dataList
                        self.dataList = result.data
                        // Table View Reload
                        self.TableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }.resume()
        }
    }
    // searching
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       // string cancatination white space removing
        if let text  = textField.text{
            filterText(text+string)
            
            }
            return true
    }
    // filter funtion calling
    func filterText(_ query:String){
        filetreData.removeAll()
        for data in dataList{
            // searching
            if data.title.lowercased().starts(with: query.lowercased()){
                filetreData.append(data)
            }
        }
        TableView.reloadData()
       
        isFiltered = true
       
    }

}
extension LoadDataViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if fileter or not get count relavant dataList
        if !filetreData.isEmpty{
            return filetreData.count
        }
        return isFiltered ? 0 : dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // customize table view cell add to table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        
        
        // check if search or not
        if !filetreData.isEmpty{
           
            cell.OnBind(data:filetreData[indexPath.row])
           
        }
        else
        {
            cell.OnBind(data:dataList[indexPath.row])
        }
        
        
     
        return cell
    }
    // tableView delegate function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // calling segue method
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails"{
             let destinationVC = segue.destination as!
             DetailViewController
            destinationVC.Image = dataList[TableView.indexPathForSelectedRow!.row].image.small
            destinationVC.det_title = dataList[TableView.indexPathForSelectedRow!.row].title
            destinationVC.lati = dataList[TableView.indexPathForSelectedRow!.row].latitude
            destinationVC.long = dataList[TableView.indexPathForSelectedRow!.row].longitude
            destinationVC.det_description = dataList[TableView.indexPathForSelectedRow!.row].description
            destinationVC.det_address = dataList[TableView.indexPathForSelectedRow!.row].address
            
    }
}
}
