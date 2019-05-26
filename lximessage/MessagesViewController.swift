//
//  MessagesViewController.swift
//  lximessage
//
//  Created by 吴展灵 on 2018/7/29.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import UIKit
import Messages
import CryptoSwift
import SQLite


class MessagesViewController: MSMessagesAppViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var dataqj=[[String]]();//存放数据
    var dataMr=[[String]]();//默认存放数据
    var mkl="";//密秘口令
    var pickerView:UIPickerView!
    var jmkl="";//解密口令
    var jamkl="";//加密口令
    
    @IBOutlet weak var btjm: UIButton!//加密啦按钮
    @IBOutlet weak var nr: UITextView!//内容
    @IBOutlet weak var mltitle: UIButton!//密令显示标题
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 键盘出现的通知
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
         
        // 键盘消失的通知
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHiden(_:)), name: .UIKeyboardWillHide, object: nil)
        nr.isHidden=false;
        btjm.isHidden=false;
        nr.isEditable=true;
       
        btjm.isEnabled=true;
        
        btjm.layer.borderWidth = 0;
        btjm.layer.cornerRadius = 16;
        
          if (self.presentationStyle==MSMessagesAppPresentationStyle.compact) {
            nr.isHidden=true;
            nr.isEditable=false;
            btjm.isHidden=false;
            btjm.isEnabled=true;
        }
        else
          {
            
            nr.isHidden=false;
            nr.isEditable=true;
            btjm.isHidden=true;
            btjm.isEnabled=false;
        }
        var database: dbimessage!
        // 与数据库建立连接
        database = dbimessage()
        
        // 建立列表（有列表后不再建立）
        database.tableLampCreate()
        
        // 无时插入数据，有数据时不插入(条件是否存在不可修改数据)
        if (database.readBz1(address: 1)==1) {
            
        }
        else
        {
            
            var textstr1="";//通用口令
           
            
            if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                textstr1="通用口令";
              
            }
            else
            {
                textstr1="Password";
              
            }
            
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
            let time = dateformatter.string(from: Date())
            
            database.tableLampInsertItem(pxh: 100, sfmr: 1, kl: "wzloyxlxjmkl_20180709_slwovjekaocpr", bc: textstr1, cjsj: time, xgsj: time, bz1: 1,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            // 遍历列表（检查删除结果）
            // database.queryTableLamp()
        }
        
        //   var database: Database!
        // 与数据库建立连接
        //database = Database()
        dataqj=database.readTable(address: 0)
        dataMr=database.readTableMr(address: 1)
        var i=database.readsfmr(address: 1)
        if(i>0)//大于则存在默认项
        {
            mkl=dataMr[0][3]//口令
            jmkl=dataMr[0][3]//口令
            jamkl=dataMr[0][3]//口令
            mltitle.setTitle(dataMr[0][1], for:.normal)//显示别称
        }
        else
        {
            mkl=dataqj[0][3]//口令
            jmkl=dataqj[0][3]//口令
            jamkl=dataqj[0][3]//口令
            mltitle.setTitle(dataqj[0][1], for:.normal)//显示别称
        }
        let tap = UITapGestureRecognizer(target:self,action:#selector(self.ssj))
        tap.numberOfTapsRequired=2;
        nr.addGestureRecognizer(tap)
       
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
    //双击清空内容
    @objc func ssj() {
        nr.text="";
    }
    
    //添加口令按下方法
    @IBAction func sztjkl(_ sender: Any) {
        
        var textstr1="";//第一个输入框
        var textstr2="";//第二个输入框
        var textstr3="";//确定
        var textstr4="";//添加口令
        var textstr5="";//请输入别名与口令
        var textstr6="";//取消
        var textstr7="";//添加成功
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="用于显示的中文名称";
            textstr2="用于加密数据的密码";
            textstr3="确定";
            textstr4="添加口令";
            textstr5="请输入别名与口令";
            textstr6="取消";
            textstr7="添加成功";//添加成功
        }
        else
        {
            textstr1="The name to display";
            textstr2="Encrypt password";
            textstr3="Done";
            textstr4="Add password";
            textstr5="Please enter a name and password";
            textstr6="Cancel";
            textstr7="Success";//添加成功
        }
        
        
        if (self.presentationStyle==MSMessagesAppPresentationStyle.compact) {
            //当发送加密信息时界面是紧凑型的，就转换成扩展型的
            self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)
        }
        
        let alertController = UIAlertController(title: textstr4,
                                                message: textstr5, preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = textstr1
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = textstr2
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: textstr6, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: textstr3, style: .default, handler: {
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
           //"c9f0f895fb98ab9159f51fd0297e236d"
            // var mmjm=textField2.text?.md5();//密码加密

            database.tableLampInsertItem(pxh: 10000, sfmr: 0, kl: mmjm!, bc: login.text!, cjsj: time, xgsj: time, bz1: 0,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            self.dataqj=database.readTable(address: 0)
            //pickerView.reloadData
            //self.pickerView.reloadAllComponents()
            self.alert(value: textstr7);
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //提示函数
    func alert(value:String)
    {
        var textstr1="";//温馨提示
        var textstr2="";//确定
     
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="温馨提示";
            textstr2="确定";
           
        }
        else
        {
            textstr1="Warm tips";
            textstr2="Done";
           
           
           
        }
        
        
        let alertController = UIAlertController(title: textstr1,
                                                message: value, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: textstr2, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }
    //加密啦按钮按下事件
    @IBAction func btjmchick(_ sender: Any) {
        //当界面是紧凑型的，就转换成扩展型的
        self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)
        nr.isHidden=false;
        nr.isEditable=true;
        btjm.isHidden=true;
        btjm.isEnabled=false;
        //nr.becomeFirstResponder();//获取焦点
    }
    
    //2.键盘监听方法
    @objc func keyboardWasShown(_ notification: Notification?) {

        
        if (self.presentationStyle==MSMessagesAppPresentationStyle.compact) {
        
            //当界面是紧凑型的，就转换成扩展型的
            self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)

        }
    }
    @objc func keyboardWillBeHiden(_ notification: Notification?) {
       // textFiledScrollView.frame = CGRect(x: 0, y: 64, width: kViewWidth, height: 455.5)
  
    }

   // deinit {
       // NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
   // }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createImageForMessage() -> UIImage? {
        
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        background.backgroundColor = UIColor.white
        
        
        
        let label = UILabel(frame: CGRect(x: 75, y: 75, width: 150, height: 150))
        
        label.font = UIFont.systemFont(ofSize: 56.0)
        
        label.backgroundColor = UIColor.red
        
        label.textColor = UIColor.white
        
        label.text = "1"
        
        label.textAlignment = .center
        
        label.layer.cornerRadius = label.frame.size.width/2.0
        
        label.clipsToBounds = true
        
        
        
        background.addSubview(label)
        
        background.frame.origin = CGPoint(x: view.frame.size.width, y: view.frame.size.height)
        
        view.addSubview(background)
        
        
        
        UIGraphicsBeginImageContextWithOptions(background.frame.size, false, UIScreen.main.scale)
        
        background.drawHierarchy(in: background.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        
        background.removeFromSuperview()
        
        
        
        return image
        
    }
    //加密事件
    @IBAction func jmsj(_ sender: Any) {
        do {
            var textstr1="";
            var textstr2="";
            var textstr3="";
            var textstr4="";
            var textstr5="";
            if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                textstr1="信息已本地加密可放心传输！";
                textstr2="灵馨加密信息";
                textstr3="温馨提示";
                textstr4="加密错误";
                textstr5="确定";
              
            }
            else
            {
                textstr1="Information is encrypted locally";
                textstr2="LX Encrypt Information";
                textstr3="Warm tips";
                textstr4="Encryption error";
                textstr5="Done";
               
            }
            
            
           // let temp = Int(arc4random()%30)+1   //随机取数字图片名称
            let temp = Int(arc4random_uniform(32))+1 //随机取数字图片名称
            let imgname=String(temp)+".png";
            let image = createImageForMessage()
            let layout = MSMessageTemplateLayout()
            //layout.image = image
            layout.image = UIImage(named:imgname)//使使用这种方法才能固定背景图位置
            layout.imageTitle="";//图片标题
            layout.caption=textstr1;
            let mms=MSMessage.init();
            
            //let kl="密令123456sfghjasasxxdxdj,.;d".bytes.md5();//密令
            mkl=jamkl;
            let kl=mkl.bytes.md5();//密令
            let ivkl="a8b9r9c6z3r1s6v9y4s6f2y1a3k6z9d0".bytes;//IV密令(必需三十二位)
            let iv="g8z9e3b6s9m2".bytes;//偏移量(必需十二位)
            // let iv: Array<UInt8> = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
            let aesstr=try AES(key: kl, blockMode: ECB());//AES加密
            // let nrstr = nr.text?.bytes;
            let nrstr = nr.text.bytes;
            let encrypted1 = try aesstr.encrypt(nrstr);
            
            let ch=try ChaCha20(key: ivkl, iv: iv)//chacha20加密
            let ch1=try ch.encrypt(encrypted1);
            
            //使用Rabbit加密模式
            let ra=try Rabbit(key: kl);
            let ra1 = try ra.encrypt(ch1);
            
            //使用Blowfish加密模式
            let bkl="dkeic8&dks,w?)jssjwjev2g6n98s5w3x8w9".bytes;
            let bf=try Blowfish(key: bkl, padding: .noPadding)
            let  bf1 = try bf.encrypt(ra1)

            mms.accessibilityLabel=bf1.toHexString();
            mms.summaryText=textstr2;
            mms.layout=layout;
            let con=activeConversation;
            con?.insert(mms, completionHandler: { error in
                print(error)         })
            // nr.text="";//清空内容
            if (self.presentationStyle==MSMessagesAppPresentationStyle.expanded) {
                //当发送加密信息时界面是扩展型的，就转换成紧凑型的
                self.requestPresentationStyle(MSMessagesAppPresentationStyle.compact)
            }
        } catch {
            
            //错误提示框
           // SCLAlertView().showError("温馨提示", subTitle: "加密错误！")
            let alertController = UIAlertController(title: "温馨提示",
                                                    message: "加密错误", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
            
        }
    }
    // MARK: - Conversation Handling
     //解密事件
    @IBAction func jiemisj(_ sender: Any) {
        
        do {
            
            var textstr1="";
            var textstr2="";
            var textstr3="";
           
            if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                textstr1="温馨提示";
                textstr2="解密口令错误";
                textstr3="确定";
             
                
            }
            else
            {
                textstr1="Warm tips";
                textstr2="Decryption Password Error"
                textstr3="Done";
              
                
            }
          
            let bytes = Array<UInt8>(hex: nr.text) // [1,2,3]
          
            mkl=jmkl
            // mkl=jamkl;
            let kl=mkl.bytes.md5();//密令
            let ivkl="a8b9r9c6z3r1s6v9y4s6f2y1a3k6z9d0".bytes;//IV密令(必需三十二位)
            let iv="g8z9e3b6s9m2".bytes;//偏移量(必需十二位)
            
            //使用Blowfish解密模式
            let bkl="dkeic8&dks,w?)jssjwjev2g6n98s5w3x8w9".bytes;
            let bf=try Blowfish(key: bkl, padding: .noPadding)
            let  bf1 = try bf.decrypt(bytes)
            
            //使用Rabbit解密模式
            let ra=try Rabbit(key: kl);
            let ra1 = try ra.encrypt(bf1);
            
            
            //CHACHA20开始解密
            let ch=try ChaCha20(key: ivkl, iv: iv)//chacha20加密
            let ch1 = try ch.decrypt(ra1);
          
            
            
            //使用AES-128-ECB加密模式
            let aes = try AES(key: kl, blockMode: ECB());
            let decrypted = try aes.decrypt(ch1);
            // print("解密结果：\(String(data: Data(decrypted), encoding: .utf8)!)")
          
            
            
            var sbx = String(data: Data(decrypted), encoding: .utf8)//先转换一次进行空值捕捉，否则会出现致命错误
            if(sbx==nil)
            {
                //错误提示框
               // SCLAlertView().showError("温馨提示", subTitle: "解密口令错误！")
                //弹出普通消息提示框
               // UIAlertController.showAlert(message: "解密口令错误!")
                let alertController = UIAlertController(title: textstr1,
                                                        message: textstr2, preferredStyle: .alert)
                  let cancelAction = UIAlertAction(title: textstr3, style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                return
                
            }
            nr.text=(String(data: Data(decrypted), encoding: .utf8)!)
            
            
            
            
        } catch {
            
            //错误提示框
           // SCLAlertView().showError("温馨提示", subTitle: "解密口令错误！")
            let alertController = UIAlertController(title: "温馨提示",
                                                    message: "解密口令错误", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
    }
    
    
    
    func getTrueLength(isWidth:Bool)->CGFloat{
        
        // var myRect:CGRect = UIScreen.mainScreen().bounds;
        var myRect:CGRect = UIScreen.main.bounds;
        //得到系统的版本号
        // var myDeviceVersion:Float = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        var myDeviceVersion:Float = (UIDevice.current.systemVersion as NSString).floatValue
        var length:CGFloat = 0.0
        
        //如果版本号小于8.0，而且是横屏的话
        // if(myDeviceVersion < 8.0&&(self.interfaceOrientation == UIInterfaceOrientation.LandscapeLeft||self.interfaceOrientation == UIInterfaceOrientation.LandscapeRight)){
        if(myDeviceVersion < 8.0&&(self.interfaceOrientation == UIInterfaceOrientation.landscapeLeft||self.interfaceOrientation == UIInterfaceOrientation.landscapeRight)){
            if(isWidth){
                
                length = myRect.size.height
                
            }else{
                
                length = myRect.size.width
                
            }
            
        }
        else{
            
            if(isWidth){
                
                length = myRect.size.width
            }
            else{
                
                length = myRect.size.height
            }
        }
        return length;
    }
    var alertController=UIAlertController(title: "请选择本地口令!\n\n\n\n\n\n\n\n\n\n\n\n", message: "选择本地口令进行加解密", preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
    var xlzt=0;//下拉状态判断
    //选择口令事件
    @IBAction func klxz(_ sender: Any) {

        var textstr1="";//第一个输入框
        var textstr2="";//第二个输入框
        var textstr3="";//确定
        var textstr4="";//添加口令
        var textstr5="";//请输入别名与口令
        var textstr6="";//取消
        var textstr7="";//添加成功
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="请选择本地口令";
            textstr2="选择本地口令进行加解密";
            textstr3="选择";
            textstr4="选择并默认";
           
            textstr6="取消";
          
        }
        else
        {
            textstr1="The name to display";
            textstr2="Select and add decryption";
            textstr3="Choose";
            textstr4="Select and Default";
       
            textstr6="Cancel";
           
        }
        
        
      var widthstr:CGFloat = alertController.view.bounds.size.width-20
                if (self.presentationStyle==MSMessagesAppPresentationStyle.compact) {
                    //当选择口令是紧凑型的，就转换成扩展型的
                    self.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)
                  //  widthstr=widthstr/2+20+10;
                   // nr.resignFirstResponder();//取消录入界面
                     widthstr=widthstr/1.48+20/1.48;
                }
         pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: widthstr, height: 300))
       // pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: widthstr, height: heightstr))
        //  pickerView = UIPickerView(frame: CGRect())
        //将dataSource设置成自己
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self

        //let cancelaction=UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil);
        let cancelaction=UIAlertAction(title: textstr6, style: UIAlertActionStyle.cancel) { (UIAlertAction)->Void in
             self.alertController=UIAlertController(title: textstr1+"!\n\n\n\n\n\n\n\n\n\n\n\n", message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
        }
        let deletlaction=UIAlertAction(title: textstr3, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.getPickerViewValue();
             self.alertController=UIAlertController(title: textstr1+"!\n\n\n\n\n\n\n\n\n\n\n\n", message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
            //成功提示框
            // SCLAlertView().showSuccess("温馨提示", subTitle: "已默认")//需有提示框才会及时刷新
        }
        let mraction=UIAlertAction(title: textstr4, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            var cell=self.pickerView.selectedRow(inComponent: 0)//获取第几列的行号
            let row = self.dataqj[cell][0];//获得当行的数据集中的列数据(id)
            
            var database: dbimessage!
            //与数据库建立连接
            database = dbimessage()
            database.Updatesfmr_null(sfmr: 1, newName: 0)
            database.Updatesfmr(id: Int64(row)!, newValue: 1)
            self.getPickerViewValue();
            self.alertController=UIAlertController(title: textstr1+"\n\n\n\n\n\n\n\n\n\n\n\n", message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
            // self.alert(value: "默认成功");
            //self.getPickerViewValue();
            //成功提示框
            // SCLAlertView().showSuccess("温馨提示", subTitle: "已默认")//需有提示框才会及时刷新
        }
        alertController.addAction(cancelaction);
        alertController.addAction(deletlaction);
        alertController.addAction(mraction);
        alertController.view.addSubview(pickerView);
        self.present(alertController, animated: true, completion: nil);//添加提示到画面视图上
        xlzt=1;
        
        
    }

    //触摸按钮时，获得被选中的索引
    // @objc func getPickerViewValue(){
    
    func getPickerViewValue(){
        var cell=pickerView.selectedRow(inComponent: 0)//获取第几列的行号
        let row = dataqj[cell][3];//获得当天行的数据集中的列数据
        let message = row
        jmkl=message
        jamkl=message
        mltitle.setTitle(dataqj[cell][1], for:.normal)
        
        
    }
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
     
        nr.text=conversation.selectedMessage?.accessibilityLabel;
        if (self.presentationStyle==MSMessagesAppPresentationStyle.compact) {
            nr.isHidden=true;
            nr.isEditable=false;
            btjm.isHidden=false;
            btjm.isEnabled=true;
        }
        else
        {
            
            nr.isHidden=false;
            nr.isEditable=true;
            btjm.isHidden=true;
            btjm.isEnabled=false;
        }
       
        // Use this method to configure the extension and restore previously stored state.
    }
    override func didBecomeActive(with conversation: MSConversation) {
          nr.text=conversation.selectedMessage?.accessibilityLabel;
        
    }
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
       // NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
        
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        //nr.text = message.accessibilityLabel!;
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
      //  NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        var textstr1="";//第一个输入框
        var textstr2="";//第二个输入框
        var textstr3="";//确定
        var textstr4="";//添加口令
        var textstr5="";//请输入别名与口令
        var textstr6="";//取消
        var textstr7="";//添加成功
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="请选择本地口令";
            textstr2="选择本地口令进行加解密";
            textstr3="选择";
            textstr4="选择并默认";
            
            textstr6="取消";
            
        }
        else
        {
            textstr1="The name to display";
            textstr2="Select and add decryption";
            textstr3="Choose";
            textstr4="Select and Default";
            
            textstr6="Cancel";
            
        }
        
        if (presentationStyle==MSMessagesAppPresentationStyle.compact) {
            nr.isHidden=true;
            nr.isEditable=false;
            btjm.isHidden=false;
            btjm.isEnabled=true;
            
            alertController.dismiss(animated: true, completion: nil)
            alertController=UIAlertController(title: textstr1+"\n\n\n\n\n\n\n\n\n\n\n\n", message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
            xlzt=0;
            
        }
        else
        {
            nr.isHidden=false;
            nr.isEditable=true;
            btjm.isHidden=true;
            btjm.isEnabled=false;
            
        }
        
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        if (presentationStyle==MSMessagesAppPresentationStyle.compact) {
            nr.isHidden=true;
            nr.isEditable=false;
            btjm.isHidden=false;
            btjm.isEnabled=true;
            nr.resignFirstResponder();//取消录入界面
           // self.view.viewWithTag(1000)?.removeFromSuperview();
            
//            let chil=self.view.subviews
//            for ch in chil
//            {
//
//                ch.removeFromSuperview();
//            }
        }
        else
        {
            nr.isHidden=false;
            nr.isEditable=true;
            btjm.isHidden=true;
            btjm.isEnabled=false;
            if(xlzt==0)
            {
            nr.becomeFirstResponder();//初始输入界面
            }
            
        }
        // Use this method to finalize any behaviors associated with the change in presentation style.
        
    }
    override func didSelect(_ message: MSMessage, conversation: MSConversation) {
        // conversation.insertText("12345638556390") { (Error) in
        //    print(Error)
        // }
        // hqnr.text="你选择了信息";
       // self.requestPresentationStyle(MSMessagesAppPresentationStyle.compact)
        nr.text = message.accessibilityLabel!;
       
        //hqnr.text = hqnr.text! + message.summaryText!
       // nr.text = message.accessibilityLabel!;
       
       
        
    }
    override func willSelect(_ message: MSMessage, conversation: MSConversation) {
        //self.requestPresentationStyle(MSMessagesAppPresentationStyle.compact)
       // nr.text = message.accessibilityLabel!;
       
    }
    
    /*以下是PickerView常用事件*/
    //设置行数（
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataqj.count;
        //return 9
    }
    //设置列数
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
        // return 3
    }
    //填充内容(只能填字符串)
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowtitle=dataqj[row][1]
        return rowtitle;
        //return String(row)+"-"+String(component)
    }
    //设置每一行的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40;
    }

}
