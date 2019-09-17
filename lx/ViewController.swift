//
//  ViewController.swift
//  lx
//
//  Created by 吴展灵 on 2018/7/15.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import UIKit
//import CryptoSwift
import CryptoSwift
//import SQLite
import SQLite
//import SCLAlertView
//import SCLAlertView
import SCLAlertView
class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var dataqj=[[String]]();//存放数据
    var dataMr=[[String]]();//默认存放数据
    @IBOutlet weak var nr: UITextView!//内容
    @IBOutlet weak var fenxiang: UIButton!//分享按钮
    var mkl="";//密秘口令
    var pickerView:UIPickerView!
    var jmkl="";//解密口令
    var jamkl="";//加密口令
    @IBOutlet weak var mltitle: UIButton!//密令显示标题
    @objc var popMenu:SwiftPopMenu!
    let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var tag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  self.view.backgroundColor = UIColor.green
       // setStatusBarBackgroundColor(color: .green)

        fenxiang.layer.borderWidth = 0;
        fenxiang.layer.cornerRadius = 16;
        nr.becomeFirstResponder();//初始输入界面
        var database: Database!
        // 与数据库建立连接
        database = Database()
        
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
            nr!.text = "为体验最佳使用效果，请在iMessage上使用；超级密码需双方都在同一天设置相同口令才能互相解密切记"
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
        let tapx = UITapGestureRecognizer(target:self,action:#selector(self.ssj))
        tapx.numberOfTapsRequired=2;
        nr.addGestureRecognizer(tapx)
        
      
    }
    //右上角菜单
    @IBAction func showMenuChick(_ sender: Any) {
        showMenu();
    }
    @objc func showMenu() {
        //frame 为整个popview相对整个屏幕的位置  箭头距离右边位置，默认15
        //popMenu =  SwiftPopMenu(frame: CGRect(x: KSCREEN_WIDTH - 155, y: 51, width: 150, height: 112))
        
        if tag == 0 {
            //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
           // popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 222, y: 111, width: 130, height: 100), arrowMargin: 12)
             // popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 155, y: 51, width: 150, height: 140), arrowMargin: 12)
             popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 155, y: 51, width: 150, height: 170), arrowMargin: 12)
            
            
        }else{
            //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
            //popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 155, y: 51, width: 150, height: 140), arrowMargin: 12)
            popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 155, y: 51, width: 150, height: 170), arrowMargin: 12)
            
            
        }
        var textstr1="";//通用口令
        var textstr2="";
        var textstr3="";
        var textstr4="";
        var textstr5="";
        var error1="";
        var error2="";
        var wen="";
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="设置密码";
            textstr2="帮助说明";
            textstr3="评价答疑";
            textstr4="超级密码";
            textstr5="安全通话";
            wen="温馨提示";
            error1="请先在输入框输入手机号码";
            error2="手机号码格式错误";
            
        }
        else
        {
            textstr1="Set";
            textstr2="Help";
            textstr3="Answers";
            textstr4="Supper";
            textstr5="Secure call";
            wen="Tips";
            error1="Please enter your mobile phone number in the input box first";
            error2="Mobile phone number is in the wrong format";
        }
        
        
        popMenu.popData = [(icon:"sezhi",title:textstr1),
                           (icon:"bangzhu",title:textstr2),
                           (icon:"pingjia",title:textstr3),
                           (icon:"pwd",title:textstr4),
        (icon:"tel",title:textstr5)]
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            if (index==0) {
                var sb = UIStoryboard(name: "Main", bundle:nil)
                var vc = sb.instantiateViewController(withIdentifier: "vc") as! sz
                //vc为该界面storyboardID，Main.storyboard中选中该界面View，Identifier inspector中修改
                self?.present(vc, animated: true, completion: nil)
              
            }

            if (index==1) {
                let urlString = "https://www.cnblogs.com/a38556390/articles/9920594.html"
                if let url = URL(string: urlString) {
                    //根据iOS系统版本，分别处理
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            
            if (index==2) {
                let urlString = "https://itunes.apple.com/cn/app/%E7%81%B5%E9%A6%A8%E5%8A%A0%E5%AF%86-%E8%AE%A9%E6%82%A8%E6%94%BE%E5%BF%83%E7%BD%91%E7%BB%9C%E8%81%8A%E5%A4%A9%E9%9A%90%E8%97%8F%E6%82%A8%E7%9A%84%E5%B0%8F%E5%AF%86%E7%A7%98/id1436384819?mt=8"
                if let url = URL(string: urlString) {
                    //根据iOS系统版本，分别处理
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
          
            if (index==3) {
                self?.setSupperPwd();
             
            }
            if (index==4) {
                if(self!.nr!.text=="")
                {
                    //错误提示框
                    SCLAlertView().showError(error1, subTitle: wen)
                    return;
                }
                if(self?.isTelNumber(num: self!.nr!.text as! NSString)==false)
                {
                    //错误提示框
                    SCLAlertView().showError(error2, subTitle: wen)
                    return;
                }
               // UIApplication.shared.openURL(URL(string: "tel://15916301694")!);
                UIApplication.shared.openURL(URL(string: "tel://"+self!.nr.text)!);
                
            }
            
        }
        popMenu.show()
        tag += 1
    }
    //验证手机号码
    func isTelNumber(num:NSString)->Bool
    {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
           // return false
             return true
        }
    }
    

    
    
    //添加超级密码
    func setSupperPwd() -> Void {
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
            var formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = Date()
            let stringDate: String = formatter.string(from: date)
            var supperpwdint=453189;
            var supperpwdint2=supperpwdint+198602*199408;
            let lianjie=textField2.text!  + String(supperpwdint) + stringDate;
            var superString="LX"+String(supperpwdint2).md5()+lianjie.md5();
            textField2.text=superString.md5();
            var mmjm=textField2.text?.md5();//密码加密
            var database: Database!
            //与数据库建立连接
            database = Database()
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
            let time = dateformatter.string(from: Date())
            
            database.tableLampInsertItem(pxh: 10000, sfmr: 0, kl: mmjm!, bc: textField1.text!, cjsj: time, xgsj: time, bz1: 0,bz2: 0,bz3: 0,bz4:"",bz5: "",bz6: "",bz7: "",bz8: "",bz9: "",bz10: "")
            
            
            
            var textstr10="";//第一个输入框
            
            
            if(self.getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                textstr10="成功,可在iMessage中使用";
                
            }
            else
            {
                textstr10="Success Can be used in iMessage";
                
            }
            SCLAlertView().showInfo(textstr10)
            
        }
        alert.showEdit(textstr4, subTitle: textstr5, closeButtonTitle: textstr6)
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
    //重写旋转方法
   //点击分享事件
    @IBAction func fx_sj(_ sender: Any) {
        
        //分享的标题
        //var textToShare = "分享的标题。"
        var textToShare = nr.text;
        //分享的图片
       // var imageToShare = UIImage(named: "312.jpg")
        //分享的url
      //  var urlToShare = URL(string: "https://itunes.apple.com/cn/app/%E7%81%B5%E9%A6%A8%E5%8A%A0%E5%AF%86-%E8%AE%A9%E6%82%A8%E6%94%BE%E5%BF%83%E7%BD%91%E7%BB%9C%E8%81%8A%E5%A4%A9%E9%9A%90%E8%97%8F%E6%82%A8%E7%9A%84%E5%B0%8F%E5%AF%86%E7%A7%98/id1436384819?mt=8")
       // var urlToShare = URL(string: "openApp.jdMobile://")
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
       // var activityItems = [textToShare, imageToShare, urlToShare]
       // var activityItems = [textToShare, urlToShare] as [Any]
        // var activityItems = [textToShare,imageToShare] as [Any]
        var activityItems = [textToShare]
        var activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        //不出现在活动项目
        //activityVC.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll]
         activityVC.excludedActivityTypes = [.print, .assignToContact]//添加了则不会出现这些功能，只保留复制功能与保存功能就好
        present(activityVC, animated: true)
        // 分享之后的回调
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
               // print("completed")
              //  SCLAlertView().showError("温馨提示", subTitle: "分享成功！")//因为分享后会自动打开对应的APP所以不提示，体验效果更好
                //分享 成功
            } else {
                //print("cancled")
                //分享 取消
               // SCLAlertView().showError("温馨提示", subTitle: "分享失败！")//因为分享后会自动打开对应的APP所以不提示，体验效果更好
            }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    ///设置状态栏背景颜色
    func setStatusBarBackgroundColor(color : UIColor) {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        /*
         if statusBar.responds(to:Selector("setBackgroundColor:")) {
         statusBar.backgroundColor = color
         }*/
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }

//加密事件
    @IBAction func jmsj(_ sender: Any) {
        
        do {
            
            
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
            
            
            
            // mms.accessibilityLabel=encrypted1.toHexString();
           // mms.accessibilityLabel=bf1.toHexString();
           nr.text=bf1.toHexString();
            
            // mms.accessibilityLabel="encrypted1.toBase64()";
            
          
            
        } catch {
            
            var textstr1="";//通用口令
             var textstr2="";//温馨提示
            
            if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
            {
                textstr1="加密错误！";
                textstr2="温馨提示";
                
            }
            else
            {
                textstr1="Encryption Error!";
                 textstr2="Warm tips";
                
            }
            
            //错误提示框
            SCLAlertView().showError(textstr2, subTitle: textstr1)
            
            
        }
        
    }
   //解密事件
    @IBAction func jiemisj(_ sender: Any) {
        
        var textstr1="";//通用口令
        var textstr2="";//温馨提示
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="加密错误！";
            textstr2="温馨提示";
            
        }
        else
        {
            textstr1="Encryption Error!";
            textstr2="Decryption Password Error!";
            
        }
        
        do {
            
            // let bytes = Array<UInt8>(hex: nr.text!) // [1,2,3]
            let bytes = Array<UInt8>(hex: nr.text) // [1,2,3]
           // let kl="密令123456sfghjasasxxdxdj,.;d".bytes.md5();//密令
          //  if(jmkl != mkl)
           // {
             //   SCLAlertView().showError("温馨提示", subTitle: "解密口令错误！")
              //  return
           // }
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
            //let ch20 = (String(data: Data(ch1), encoding: .utf8)!)
            // let aesbytes =  Array<UInt8>(hex: ch20) // [1,2,3]
            
            
            //使用AES-128-ECB加密模式
            let aes = try AES(key: kl, blockMode: ECB());
            let decrypted = try aes.decrypt(ch1);
            // print("解密结果：\(String(data: Data(decrypted), encoding: .utf8)!)")
            //nr.text=(String(data: Data(decrypted), encoding: .utf8)!)
            
            // nr.text=(String(data: Data(decrypted), encoding: .utf8)!)
            var sbx = String(data: Data(decrypted), encoding: .utf8)//先转换一次进行空值捕捉，否则会出现致命错误
            if(sbx==nil)
            {
                //错误提示框
                SCLAlertView().showError(textstr2, subTitle: textstr2)
                return
                
            }
            nr.text=(String(data: Data(decrypted), encoding: .utf8)!)
            
            
            
            
        } catch {
            
            //错误提示框
            SCLAlertView().showError(textstr2, subTitle: textstr2)
            
        }
        
    }
   
    
    //选择口令事件
    @IBAction func klxz(_ sender: Any) {
   
        //得到宽度
        
      //  var widthstr:CGFloat = getTrueLength(isWidth: true)-20
        //得到高度
       // var height:CGFloat = getTrueLength(false)
      // pickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: 386, height: 300))
      
        //设置选择框的默认值
       // pickerView.selectRow(1,inComponent:0,animated:true)
       // pickerView.selectRow(2,inComponent:1,animated:true)
        //pickerView.selectRow(3,inComponent:2,animated:true)
        //self.view.addSubview(pickerView)
 
        var textstr1="";//通用口令
        var textstr2="";//温馨提示
        var textstr3="";//温馨提示
        var textstr4="";//温馨提示
        
        if(getCurrentLanguage()=="cn")//如果是中文则显示中文否则全显示英文
        {
            textstr1="请选择本地口令!";
            textstr2="选择本地口令进行加解密";
            textstr3="取消";
            textstr4="确认";
            
        }
        else
        {
            textstr1="Please select a local password!";
            textstr2="Select local password for encryption and decryption";
            textstr3="Cancel";
            textstr4="Done";
            
        }
        
        
        let alertController=UIAlertController(title: textstr1+"\n\n\n\n\n\n\n\n\n\n\n\n", message: textstr2, preferredStyle: UIAlertControllerStyle.actionSheet);//必须要有换行符才能把选择控件放进去并显示出来
        //pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: widthstr, height: 300))
          pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: alertController.view.bounds.size.width-20, height: 300))//使用提示框宽度
       
        //  pickerView = UIPickerView(frame: CGRect())
        //将dataSource设置成自己
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self
        
        
        let cancelaction=UIAlertAction(title: textstr3, style: UIAlertActionStyle.cancel, handler: nil);
        let deletlaction=UIAlertAction(title: textstr4, style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            
            self.getPickerViewValue();
            //成功提示框
           // SCLAlertView().showSuccess("温馨提示", subTitle: "已默认")//需有提示框才会及时刷新
        }
        
        alertController.addAction(cancelaction);
        alertController.addAction(deletlaction);
        alertController.view.addSubview(pickerView);
        self.present(alertController, animated: true, completion: nil);//添加提示到画面视图上
        
        
        
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
    
    //填充内容(可填充任意类型)
  //  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
       // var myView = UIView(frame: CGRectMake(5, 0, 100, 100));//生成一视图容器
        
       // var myImageView = UIImageView(frame: CGRectMake(5, 0, 100, 100));//设置图片大小此外设置为长宽各100
       // let rowvalue = datapv[row];//获取行数据
        
      //  myImageView.image = UIImage(named:rowvalue["lxdm"] as! String);
        // myImageView.contentMode = .Redraw;
       // myView.addSubview(myImageView);
       // return myView;
    //}
    //设置每一行的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40;
    }
    
}

