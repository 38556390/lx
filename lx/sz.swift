//
//  ViewController.swift
//  lx
//
//  Created by 吴展灵 on 2018/7/15.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import UIKit
import CryptoSwift
import SQLite
import SCLAlertView
class sz: UIViewController,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate{
   // var data=[[String:AnyObject]]();//存放数据
    var data=[[String]]();//存放数据
    @IBOutlet weak var tv: UITableView!//显示列表
    var idStr="";//用于删除数据的ID值
  
    @IBOutlet var la: UILongPressGestureRecognizer!//长按按钮
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
        
        var textstr1="";//第一个输入框
        var textstr2="";//第二个输入框
        var textstr3="";//确定
        var textstr4="";//添加口令
        var textstr5="";//请输入别名与口令
        var textstr6="";//取消
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="是否确认";
            textstr2="设置默认项目";
            textstr3="确认";
            textstr4="温馨提示";
            textstr5="已默认";
            textstr6="取消";
        }
        else
        {
            textstr1="Confirm";
            textstr2="Default settings";
            textstr3="Done";
            textstr4="Warm tips";
            textstr5="Default";
            textstr6="Cancel";
        }
        
        
         var touch = la.location(in: self.tv)
       
         let cellview=self.tv.indexPathForRow(at: touch)
         if(cellview==nil)
         {}
         else
         {
      
          let cell=tv.cellForRow(at: cellview!)  as! wPaperCell
          idStr=cell.id.text!
            var qu="";
            qu=idStr
     
           let alertController=UIAlertController(title: textstr1, message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);
           let cancelaction=UIAlertAction(title: textstr6, style: UIAlertActionStyle.cancel, handler: nil);
           let deletlaction=UIAlertAction(title: textstr3, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
     
          var database: Database!
        //与数据库建立连接
          database = Database()
         database.Updatesfmr_null(sfmr: 1, newName: 0)
         database.Updatesfmr(id: Int64(qu)!, newValue: 1)
            self.dbtableView();
            //成功提示框
            SCLAlertView().showSuccess(textstr4, subTitle: textstr5)//需有提示框才会及时刷新
            }
        
          alertController.addAction(cancelaction);
          alertController.addAction(deletlaction);
          
        //  self.presentViewController(alertController, animated: true, completion: nil);//添加提示到画面视图上
          self.present(alertController, animated: true, completion: nil);//添加提示到画面视图上
         }
    }
   

    
    //初始化数据到tableView上
    func dbtableView()
    {
        var database: Database!
        // 与数据库建立连接
        database = Database()
   
      
    
        data=database.readTable(address: 0)
       // tv.dataSource=self//前台绑定后，后台则不需要此代码，前台绑定方法是直接把方法拉线到头部像钱币一样的图案上
       // tv.delegate=self//前台绑定后，后台则不需要此代码，前台绑定方法是直接把方法拉线到头部像钱币一样的图案上
     
        
        self.tv.reloadData();
    }
    //获取当前系统语言
    func getCurrentLanguage() -> String {
        // let defs = UserDefaults.standard
        // let languages = defs.object(forKey: "AppleLanguages")
        // let preferredLang = (languages! as AnyObject).object(0)
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        // let preferredLang = (languages! as AnyObject).object(0)
        // Log.debug("当前系统语言:\(preferredLang)")
        switch String(describing: preferredLang)
        {
        case "en-US", "en-CN":
            return "en"//英文
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
    }
    @IBAction func tj(_ sender: Any) {
        
        var textstr1="";//第一个输入框
        var textstr2="";//第二个输入框
        var textstr3="";//确定
        var textstr4="";//添加口令
        var textstr5="";//请输入别名与口令
        var textstr6="";//取消

        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="用于显示的中文名称";
            textstr2="用于加密数据的密码";
            textstr3="确定";
            textstr4="添加口令";
            textstr5="请输入别名与口令";
            textstr6="取消";
        }
        else
        {
            textstr1="The name to display";
            textstr2="Encrypt password";
            textstr3="Done";
            textstr4="Add password";
            textstr5="Please enter a name and password";
            textstr6="Cancel";
        }
        //错误提示框
        //SCLAlertView().showError("温馨提示", subTitle: "添加口令！")
        let alert = SCLAlertView()
        //添加第一个输入框
        let textField1 = alert.addTextField(textstr1)
        //添加第二个输入框
        let textField2 = alert.addTextField(textstr2)
       
        textField2.isSecureTextEntry = true
        alert.addButton(textstr3) {
           // print(textField1.text!, textField2.text!)
           
            var mmjm=textField2.text?.md5();//密码加密
            var database: Database!
            //与数据库建立连接
            database = Database()
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
            let time = dateformatter.string(from: Date())
            
            database.tableLampInsertItem(pxh: 10000, sfmr: 0, kl: mmjm!, bc: textField1.text!, cjsj: time, xgsj: time, bz1: 0,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            
            self.dbtableView()
           
            //遍历列表（检查删除结果）
            database.queryTableLamp()
        }
        alert.showEdit(textstr4, subTitle: textstr5, closeButtonTitle: textstr6)
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

        
 
        var textstr5="";//请输入别名与口令
    
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
   
            textstr5="默认";
          
        }
        else
        {
        
            textstr5="Default";
          
        }
        
        
        //以下使用自室义列布局来显示内容
        let cellIdentifier : String = "PaperCell";//PaperCell为tableViewCell的identifier所取名称
       // let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath as IndexPath)  as! wPaperCell;//使用自定义列(即生成自定义列)
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)  as! wPaperCell;//使用自定义列(即生成自定义列)

        
        
        let row=data[indexPath.row];//获取行数据

       // cell.accessoryType = .DisclosureIndicator;//设置最右边标记类型此类型为一个翦头
        cell.bc.text=row[1] as! String;
        cell.sfmr.text=row[2] as! String;
        if(cell.sfmr.text=="1")
        {
            
            cell.sfmr.text=textstr5;
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
        var textstr5="";//请输入别名与口令
        
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            
            textstr5="删除";
            
        }
        else
        {
            
            textstr5="Delete";
            
        }
        return textstr5
    }
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == UITableViewCellEditingStyle.delete {

            
            var textstr5="";//请输入别名与口令
             var textstr6="";//请输入别名与口令
             var textstr7="";//请输入别名与口令
            if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                
                textstr5="删除成功";
                textstr6="温馨提示";
                textstr7="系统口令不可删除！";
                
            }
            else
            {
                
                textstr5="Deletion succeeded";
                textstr6="Warm tips";
                textstr7="System password cannot be deleted!";
                
            }
            
            let cellIdentifier : String = "PaperCell";//PaperCell为tableViewCell的identifier所取名称
            let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)  as! wPaperCell;//使用自定义列(即生成自定义列)
           // let cellview=self.tv.indexPathForRow(at: touch)
           // let cell=tv.cellForRow(at: cellview!)  as! wPaperCell
            var qu="";
           let row=data[indexPath.row];//获取行数据
              idStr=row[0] as! String;
            qu=idStr;
           
            var database: Database!
            //与数据库建立连接
            database = Database()
          var i = database.readsfks(address: Int64(qu)!)
            if(i==1)
            {
               SCLAlertView().showSuccess(textstr6, subTitle: textstr7)//需有提示框才会及时刷新
                return;
            }
            database.tableLampDeleteItem(id: Int64(qu)!)
            dbtableView()
            // SCLAlertView().showError("温馨提示", subTitle: "删除成功！")
            //成功提示框
            SCLAlertView().showSuccess(textstr6, subTitle: textstr5)//需有提示框才会及时刷新

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

