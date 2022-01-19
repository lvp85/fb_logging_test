//
//  DataTableViewCell.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/18.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // create rounded imageview 
        ImageView.layer.cornerRadius = ImageView.frame.size.width/2
        ImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // data bind for tabview custamize cell
    func OnBind(data:Data){
        lblTitle.text = data.title
        lblAddress.text = data.address
        let url = data.image.small
       print(url)
       
        let dataImage =  url.data(using:.utf8)!
        self.ImageView.image = UIImage(data: dataImage)
        
    
      }
}

