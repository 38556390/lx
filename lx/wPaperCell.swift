//
//  wPaperCell.swift
//  lx
//
//  Created by 吴展灵 on 2018/7/18.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import UIKit

class wPaperCell: UITableViewCell {
    
    

    
    @IBOutlet weak var id: UILabel!//
    @IBOutlet weak var sfmr: UILabel!//是否默认
    @IBOutlet weak var bc: UILabel!//别称（中文显示名称）
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
