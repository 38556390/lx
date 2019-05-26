//
//  sz2.swift
//  lximessage
//
//  Created by 吴展灵 on 2018/7/29.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import UIKit
import CryptoSwift
import SQLite

class sz2: UIViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate{
//class sz2: MSMessagesAppViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate{
    // var data=[[String:AnyObject]]();//存放数据
    var data=[[String]]();//存放数据
 
    @IBOutlet var la: UILongPressGestureRecognizer!//长按按钮
    @IBOutlet weak var tv: UITableView!//显示列表
    var idStr="";//用于删除数据的ID值
    
  
    // let tableview = UITableView(frame: ScreenRect, style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dbtableView()
        // self.tv.isEditing=true;//开启可编辑功能（开启后左边会有个红色减号按按，去掉则不会有，直接右滑再出删除键，效果更好）
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //长按手势
    @IBAction func longpressmy(_ sender: Any) {
        //说明：使用纯代码无法长按事件会报错，只能拖一个长按控件出来，再用控件生成事件则不报错
        var touch = la.location(in: self.tv)
        
        let cellview=self.tv.indexPathForRow(at: touch)
        if(cellview==nil)
        {}
        else
        {
            
            let cell=tv.cellForRow(at: cellview!)  as! wPaperCell2
            idStr=cell.id.text!
            var qu="";
            qu=idStr
            
            let alertController=UIAlertController(title: "是否确认!", message: "设置默认项目", preferredStyle: UIAlertControllerStyle.actionSheet);
            let cancelaction=UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil);
            let deletlaction=UIAlertAction(title: "确认", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                
                var database: dbimessage!
                //与数据库建立连接
                database = dbimessage()
                database.Updatesfmr_null(sfmr: 1, newName: 0)
                database.Updatesfmr(id: Int64(qu)!, newValue: 1)
                self.dbtableView();
                //成功提示框
               // SCLAlertView().showSuccess("温馨提示", subTitle: "已默认")//需有提示框才会及时刷新
                self.alert(value: "已默认");
                
                
            }
            
            alertController.addAction(cancelaction);
            alertController.addAction(deletlaction);
            
            //  self.presentViewController(alertController, animated: true, completion: nil);//添加提示到画面视图上
            self.present(alertController, animated: true, completion: nil);//添加提示到画面视图上
        }
    }
    //提示函数
    func alert(value:String)
    {
        
        let alertController = UIAlertController(title: "温馨提示",
                                                message: value, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }
    
    
    //初始化数据到tableView上
    func dbtableView()
    {
        var database: dbimessage!
        // 与数据库建立连接
        database = dbimessage()
        
        
        
        data=database.readTable(address: 0)
        // tv.dataSource=self//前台绑定后，后台则不需要此代码，前台绑定方法是直接把方法拉线到头部像钱币一样的图案上
        // tv.delegate=self//前台绑定后，后台则不需要此代码，前台绑定方法是直接把方法拉线到头部像钱币一样的图案上
        
        
        self.tv.reloadData();
    }
    //添加口令
    @IBAction func tj(_ sender: Any) {
        
        
        
        //错误提示框
        //SCLAlertView().showError("温馨提示", subTitle: "添加口令！")
       // let alert = SCLAlertView()
        //添加第一个输入框
       // let textField1 = alert.addTextField("用于显示的中文名称")
        //添加第二个输入框
       // let textField2 = alert.addTextField("用于加密数据的密码")
       // var mmjm=textField2.text?.md5();//密码加密
      //  textField2.isSecureTextEntry = true
       // alert.addButton("确定") {
            // print(textField1.text!, textField2.text!)
           // var database: dbimessage!
            //与数据库建立连接
           // database = dbimessage()
           // let dateformatter = DateFormatter()
           // dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
           // let time = dateformatter.string(from: Date())
            
          //  database.tableLampInsertItem(pxh: 10000, sfmr: 0, kl: mmjm!, bc: textField1.text!, cjsj: time, xgsj: time, bz1: 0,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            
           // self.dbtableView()
            
            //遍历列表（检查删除结果）
            //database.queryTableLamp()
       // }
      //  alert.showEdit("添加口令", subTitle: "请输入别名与口令", closeButtonTitle: "取消")
        
        let alertController = UIAlertController(title: "添加口令",
                                                message: "请输入别名与口令", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "用于显示的中文名称"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "用于加密数据的密码"
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let login = alertController.textFields!.first!
            let password = alertController.textFields!.last!
           // print("用户名：\(login.text) 密码：\(password.text)")
            
            // print(textField1.text!, textField2.text!)
            var database: dbimessage!
            //与数据库建立连接
            database = dbimessage()
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
            let time = dateformatter.string(from: Date())
            var mmjm=password.text?.md5();//密码加密
            database.tableLampInsertItem(pxh: 10000, sfmr: 0, kl: mmjm!, bc: login.text!, cjsj: time, xgsj: time, bz1: 0,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            
            self.dbtableView()
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    /*以下是tableView常用事件*/
    //设置节数（即分组数）
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    //设置行数
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count ;
    }
    //设置表单元中的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //以下使用自带排版方法来显示内容
        // .Default,    // 默认风格，自带标题和一个图片视图，图片在左
        // .Value1,     // 只有标题和副标题 副标题在右边
        // .Value2,     // 只有标题和副标题，副标题在左边标题的下边
        // .Subtitle    // 自带图片视图和主副标题，主副标题都在左边，副标题在下
        
        
        //以下使用自室义列布局来显示内容
        let cellIdentifier : String = "PaperCell";//PaperCell为tableViewCell的identifier所取名称
        // let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath as IndexPath)  as! wPaperCell;//使用自定义列(即生成自定义列)
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)  as! wPaperCell2;//使用自定义列(即生成自定义列)
        
        
        
        let row=data[indexPath.row];//获取行数据
        
        // cell.accessoryType = .DisclosureIndicator;//设置最右边标记类型此类型为一个翦头
        cell.bc.text=row[1] as! String;
        cell.sfmr.text=row[2] as! String;
        if(cell.sfmr.text=="1")
        {
            
            cell.sfmr.text="默认";
        }
        if(cell.sfmr.text=="0")
        {
            
            cell.sfmr.text="";
        }
        cell.id.text=row[0] as! String;
        cell.id.isHidden=true;//隐藏ID列
        return cell;
    }
    //设置表单元格的编辑风格必须在初始化时开启tableView.editing=true才能生效)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    //在这里修改删除按钮的文字
    //func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
    // return "删除"
    // }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let cellIdentifier : String = "PaperCell";//PaperCell为tableViewCell的identifier所取名称
            let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)  as! wPaperCell2;//使用自定义列(即生成自定义列)
            // let cellview=self.tv.indexPathForRow(at: touch)
            // let cell=tv.cellForRow(at: cellview!)  as! wPaperCell
            var qu="";
            let row=data[indexPath.row];//获取行数据
            idStr=row[0] as! String;
            qu=idStr;
            
            var database: dbimessage!
            //与数据库建立连接
            database = dbimessage()
            var i = database.readsfks(address: Int64(qu)!)
            if(i==1)
            {
                 self.alert(value: "通用口令不可删除！");
               // SCLAlertView().showSuccess("温馨提示", subTitle: "通用口令不可删除！")//需有提示框才会及时刷新
                return;
            }
            database.tableLampDeleteItem(id: Int64(qu)!)
            dbtableView()
            // SCLAlertView().showError("温馨提示", subTitle: "删除成功！")
            //成功提示框
           // SCLAlertView().showSuccess("温馨提示", subTitle: "删除成功")//需有提示框才会及时刷新
              self.alert(value: "删除成功！");
            // UIRefreshControl
        }
    }
    //编辑事件(必须在初始化时开启tableView.editing=true才能生效)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //设置行高事件
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;//设置行高值
    }
    
    
}

