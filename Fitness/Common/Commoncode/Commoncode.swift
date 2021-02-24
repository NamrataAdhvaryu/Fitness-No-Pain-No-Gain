//
//  Commoncode.swift
//  Fitness
//
//  Created by Namrata Akash on 11/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit


class Commoncode: NSObject {
    
    
    func setUserdefault(key:String,val:String)  {
        
        let dif = UserDefaults.standard;
        
        dif.set(val, forKey: key)
        
    }
    
    func readUserdefault(key:String) -> String {
        
        let dif = UserDefaults.standard;
        
        
        return (dif.value(forKey: key) as? String)!;
        
    }
    
    func pushVC(acurrentvc:UIViewController , nextvcindentifier: String) {
        let storyboardobj =
            acurrentvc.storyboard?.instantiateViewController(withIdentifier: nextvcindentifier)
        acurrentvc.navigationController?.pushViewController(storyboardobj!, animated: true)
    }
    func pushVCwithoutanimate(acurrentvc:UIViewController,nextvcidentifier:String) {
        let storyboardobj =
            acurrentvc.storyboard?.instantiateViewController(withIdentifier: nextvcidentifier)
        acurrentvc.navigationController?.pushViewController(storyboardobj!, animated: false)
    }
    func getPath(aStrPlistNameRef:String) -> String
    {
        let apath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = apath[0]
        let afinalpath = path.appending("/" + aStrPlistNameRef + ".plist")
        
        print(afinalpath)
        return afinalpath
    }
    func getCurrentuserID() -> Int
    {
        let dictforresponse = commomcodeobj.readPlist(aStrPlistNameRef: Constant().USER_LOGIN_PLIST)
        let aintid = Int(dictforresponse["id"]!)
        return aintid!
    }
    func IsProfileIDAndCurrentUserIDAreSame(aIntProfileId:Int) -> Bool
    {
        var aBoolStatus = false;
        let aIntCurrentUserId = commomcodeobj.getCurrentuserID();
        if(aIntCurrentUserId == aIntProfileId)
        {
            aBoolStatus = true;
        }
        return aBoolStatus;
    }
    
    func createplist(aStrPlistNameRef:String, dic:[String:Any]) {
        let dic = NSDictionary(dictionary: dic)
        dic.write(toFile: getPath(aStrPlistNameRef: aStrPlistNameRef), atomically: true)
    }
    
    
    
    func checkplistfileexistornot(afinalpath:String) -> Bool
    {
        let nfilemanager = FileManager()
        if nfilemanager.fileExists(atPath: afinalpath)
        {
            print("file exist")
            return true
        }
        else
        {
            return false
        }
    }
    func writedatainplist(astrpath:String, adictionary:[String:String])
    {
        if !checkplistfileexistornot(afinalpath: astrpath)
        {
            let adic = NSDictionary(dictionary: adictionary)
            adic.write(toFile: astrpath, atomically: true)
        }
    }
    
    func readPlist(aStrPlistNameRef:String) -> [String:String]
    {
        let fmg = FileManager()
        if fmg.fileExists(atPath:getPath(aStrPlistNameRef: aStrPlistNameRef)) {
            let dic = NSDictionary(contentsOfFile:getPath(aStrPlistNameRef: aStrPlistNameRef))
            
            return dic as! [String : String]
        }
        else
        {
            return ["":""]
        }
        
    }
    func removePlist(aStrPlistNameRef:String) {
        let fmg = FileManager()
        if fmg.fileExists(atPath: getPath(aStrPlistNameRef:aStrPlistNameRef))
        {
            do
            {
                try!  fmg.removeItem(atPath: getPath(aStrPlistNameRef: aStrPlistNameRef))
            }
            catch let err as NSError
            {
                print(err.description)
            }
        }
    }
    func CreatePathForPlistFile(aStrPlistNameRef:String) -> String
    {
        let aStrPathObj = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let aStrFullPathObj = aStrPathObj[0];

        let aStrFinalPathObj = aStrFullPathObj.appending( "/" + aStrPlistNameRef + ".plist");//"/profile.plist"
        print(aStrFinalPathObj);
        
        return aStrFinalPathObj;
    }
    
    func CheckPlistFileIsExistOrNotAsPerFileName(aStrPlistName:String) -> Bool
    {
        let aStrFinalPathObj = CreatePathForPlistFile(aStrPlistNameRef: aStrPlistName);
        let aFileMangrObj = FileManager();
        if aFileMangrObj.fileExists(atPath: aStrFinalPathObj)
        {
            print("Plist file is already exists...")
            return true;
        }
        else
        {
            return false;
        }
    }
    func createimgbase64(aimg:UIImage) -> String
    {
        let imgdata = aimg.jpegData(compressionQuality: 2.0)
        let astringbase64 = imgdata?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        return astringbase64!
    }

    func Displayimgfromserver(url:String,Images:String) -> Data {
        
        
        let finalpath = "\(url)\(Images)"
        print(finalpath)
        
        let aurl = URL(string: finalpath)
        do
        {
            let adata = try Data(contentsOf: aurl!)
            return adata
        }
        catch
        {
            
        }
        
        return Data();
        
    }
    func  Getcurrentdateandtime() -> String {
        let adate = Date()
        let adateformatter = DateFormatter()
        adateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let varstrcurrentdate = adateformatter.string(from: adate)
        print("currentdate:\(varstrcurrentdate)")
        return varstrcurrentdate
    }
    func convertstringtodate(astring:String) -> Date
    {
        let adateformatter = DateFormatter()
        adateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateobj = adateformatter.date(from: astring)
        print("date:\(dateobj)")
        return dateobj!
    }
    func convertdatetostring(adate:Date) -> String {
        let adateformatter = DateFormatter()
        adateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let astrobj = adateformatter.string(from: (adate as! Date?)!)
        print("string:\(astrobj)")
        return astrobj
        
    }
    
    func StringIsNotEmpty(aStrVal: String) -> Bool
    {
        var aBoolStatus = false;
        let myString = aStrVal;//String();
        
        //Check if 'string' is not nil and not empty
        //if myString == aStrVal, !myString.isEmpty
        if (!myString.isEmpty)
        {
            // string is not nil and not empty...
            aBoolStatus = true;
        }
        
        if(myString == "" && myString == " ")
        {
            aBoolStatus = false;
        }
        
        return aBoolStatus;
    }
  func isValidEmail(email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    func isValidPhone(phone: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{5}-\\d{3}-\\d{3}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phone)
        return result
    }
    
    func isValidMobile(mobile: String) -> Bool {
        
        //STARTING WITH +91 THEN ONE DIGIT START BETWEEN 7 TO 9 THEN ADD 9 DIGIT BETWEEN 0 TO 9 IT PERMITS +919726174054 / 09726174054
        
        let PHONE_REGEX = "^([+][9][1]|[9][1]|[0]){0,1}([7-9]{1})([0-9]{9})$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: mobile)
        return result
    }
    func isvalidusername(ausername:String) -> Bool
    {
        let RegEx = "\\w{7,18}"
           let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: ausername)
    }
    
    
    func isValidPassword(pwd: String) -> Bool {
        
        //Minimum 6 Max 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let PHONE_REGEX = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: pwd)
        return result
    }
    
    
    
}

extension UIButton
{
    func CreateRoundButton(aCornerRadius: CGFloat)
    {
          self.layer.cornerRadius = aCornerRadius;
          self.layer.borderWidth = 0;
          self.backgroundColor = Constant().COLOR_APP_THEME_BUTTON_BG;
          self.tintColor = Constant().COLOR_APP_THEME_BUTTON_TEXT;
          self.titleLabel?.textColor = Constant().COLOR_APP_THEME_BUTTON_TEXT;
    }
    func CreateRoundSelectedButton(aCornerRadius: CGFloat)
    {
        self.layer.cornerRadius = aCornerRadius;
        self.layer.borderWidth = 3;
        self.layer.borderColor =
            UIColor.black.cgColor
        self.backgroundColor = Constant().COLOR_APP_THEME_BUTTON_BG;
        self.tintColor = Constant().COLOR_APP_THEME_BUTTON_TEXT;
        self.titleLabel?.textColor = Constant().COLOR_APP_THEME_BUTTON_TEXT;

        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowOffset = CGSize(width: 2,height: 2);
    }
    func buttonUI(acircleradius:CGFloat)
        
    {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = acircleradius//(10)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.clipsToBounds = true
        
        
    }
}
extension UIView
{
    func viewUI(acircleradius:CGFloat)
    {
        self.backgroundColor = #colorLiteral(red: 0.2757818103, green: 0.7529212832, blue: 0.8210884929, alpha: 1).withAlphaComponent(0.6)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.clipsToBounds = true
        
    }
}
    extension UIImageView
    {
    func CreateRoundImageView(aFloatWidth: CGFloat)
    {
          self.layer.cornerRadius = aFloatWidth/2;
          self.layer.borderWidth = 0;
    }
    
    
}
extension UITableView
{
    func tablvwUI(acircleradius:CGFloat)
    {
        self.backgroundColor = #colorLiteral(red: 0.2757818103, green: 0.7529212832, blue: 0.8210884929, alpha: 1).withAlphaComponent(0.6)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.clipsToBounds = true
        
    }
}
  extension UITextField
  {
    func forcorrectfield()
    {
    self.rightViewMode = .never
   self.clipsToBounds = true
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.green.cgColor
  
}
    
    func forwrongfield() {
        self.rightViewMode = .whileEditing
        let imgview = UIImageView(image: UIImage(named: "if_Help_mark_query_question_support_talk_271504.png"))
        self.rightView = imgview
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
                  
                   
    }
    }
extension UIColor
{
    convenience init(hexString: String, alpha: CGFloat = 1.0)
    {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#"))
        {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String
    {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }

}
