//
//  BookingVC.swift
//  Fitness
//
//  Created by Namrata Akash on 04/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import DatePicker
import DroidTimeSelection
import iOSDropDown
import FCAlertView


class BookingVC: UIViewController,UITextFieldDelegate, FCAlertViewDelegate, BookingDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    var bookingdata = [Any]()
    @IBOutlet weak var bookview: UIView!
    @IBOutlet weak var confirmbtn: UIButton!
   
    @IBOutlet weak var dropdownarea: DropDown!
    @IBOutlet weak var tbl:UITableView!
    @IBOutlet weak var dropdownclass: DropDown!
    @IBOutlet weak var sekectdatetxt: UITextField!
    @IBOutlet weak var timetxt: UITextField!
    let clockMethod = DroidClockSelector(frame: .zero)
   
    var astring = String()
    var isCustomTime = false
    var timeFormat: DroidTimeFormat = .twelve
    var time: Time = .init()
    
   
     let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .pad //Depending on AM or PM
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.reloadData()
        callWStoupdatedata()
        setTime(with: time)
        bookview.viewUI(acircleradius: 10)
        confirmbtn.buttonUI(acircleradius: 10)
        clockMethod.config.timeFormat = .twelve
        clockMethod.config.timeColor = .blue
        
        clockMethod.set(hour: 0, minutes: 0, am: false)
        clockMethod.onSelectionChanged = { [weak self] value in
            
        }
        
        dropdownclass.optionArray = ["Gym","Yoga","Zumba"]
        dropdownarea.optionArray = ["Satellite","CG Road","Paldi","Udhna","Airport Road","Naroda"]
        dropdownclass.rowBackgroundColor = Constant().COLOUR_APP_THEME_PRIMARY
        dropdownclass.selectedRowColor =  Constant().COLOUR_APP_THEME_SECONDARY
        dropdownarea.rowBackgroundColor = Constant().COLOUR_APP_THEME_PRIMARY
        dropdownarea.selectedRowColor =  Constant().COLOUR_APP_THEME_SECONDARY
        dropdownarea.didSelect{(selectedText , index ,id) in
            self.dropdownarea.text = "\(selectedText)"
        }
        dropdownclass.didSelect{(selectedText , index ,id) in
            self.dropdownclass.text = "\(selectedText)"
     
    }
        
    }
    func setTime(with time: Time) {
        self.time = time
        timetxt.text = timeFormatter.string(from: time.totalSeconds)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        let minDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: 1990)!
                let maxDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: 2030)!
                let today = Date()
                // Create picker object
                let datePicker = DatePicker()
      
        let input = "12/10/2018"
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        if let date = formatter.date(from: input) {
            sekectdatetxt.text = formatter.string(from: date)
        }
        
                datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
                    if selected, let selectedDate = date {
                        self.sekectdatetxt.textColor = .black
                        if let date = formatter.date(from: input) {
                            
                            self.sekectdatetxt.text = "\(selectedDate)"
                        }
                        
                    } else {
                        print("Cancelled")
                    }
                }
                // Display
        datePicker.show(in: self, on: textField)
        
    

        
        
        return false;
        
        
        
    }
    
    @IBAction func bookDate(_ sender: Any) {
//       
            }
        
    func callWStopostbookindata() {
        let ctrlobj = BookingController()
        ctrlobj.delegate = self
        let amodel = bookingmodel(user_id:Commoncode().getCurrentuserID(), booking_date: sekectdatetxt.text!, booking_time: timetxt.text!, booking_cat: dropdownclass.text!, booking_area: dropdownarea.text!)
        ctrlobj.GetBookingdata(amodel: amodel)
        
    }
    func updatebooking_returnresp(ajsondata: [Any]) {
        if (ajsondata != nil)
        {
            self.bookingdata = ajsondata
            tbl.reloadData()
            print("bookingdata:\(bookingdata)")
        }
    }
    @IBAction func Confirmbtn(_ sender: Any)
    {
      
        
        if ( sekectdatetxt.text != "" && dropdownarea.text != "" && dropdownclass.text != "")
        
        {
            
            astring = " your booking for \(dropdownclass.text!) on \(sekectdatetxt.text!) at \(timetxt.text!) at \(dropdownarea.text!) is confirm!!!!"
        alertviewperform(ainview: self, awithTitle: "Booking Confirm!!", awithsubtitle: astring, awithDoneButtonTitle: "ok", ainttag: 100)
            callWStopostbookindata()
            
           
            }
           
        
        else
        {
            alertviewperform(ainview: self, awithTitle: "Booking not Confirm!!", awithsubtitle: "something went wrong", awithDoneButtonTitle: "ok", ainttag: 101)
        }
    }
    func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String, awithDoneButtonTitle:String,ainttag:Int)  {
        let alert = FCAlertView()
        
        
        alert.delegate = self
        
        alert.showAlert(withTitle: awithTitle, withSubtitle: awithsubtitle, withCustomImage: nil, withDoneButtonTitle: awithDoneButtonTitle, andButtons: nil)
        
        alert.cornerRadius = 10
        alert.colorScheme = UIColor.init(displayP3Red: 150, green: 150, blue: 150, alpha:0.0)
        alert.colorScheme = alert.flatBlue

}
    func callWStoupdatedata()
    {
      let ctrlobj = BookingController()
        ctrlobj.delegate = self
        let modelobj = bookingmodel(user_id: Commoncode().getCurrentuserID())
        ctrlobj.Updatebookingdata(amodel: modelobj)
        
    }
    
    
        
     func createDroidSelection() -> DroidTimeSelection {
        let droidSelection = DroidTimeSelection()
        droidSelection.config.timeFormat = self.timeFormat
        droidSelection.set(time: time)
        droidSelection.onCancelTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        droidSelection.onOkTapped = { [weak self] in
            let value = droidSelection.value
            self?.setTime(with: value)
            self?.dismiss(animated: true, completion: nil)
        }
        return droidSelection
    }
    
    
    @IBAction func timeaction(_ sender: Any) {
        let droidSelection: UIView = createDroidSelection()
        let vc = UIViewController()
        let fakeDimView = UIView()
        fakeDimView.translatesAutoresizingMaskIntoConstraints = false
        fakeDimView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        fakeDimView.alpha = 0.0
        vc.view.backgroundColor = .clear
        vc.view.addSubview(fakeDimView)
        
        fakeDimView
            .leadingAnchor
            .constraint(equalTo: vc.view.leadingAnchor)
            .isActive = true
        fakeDimView
            .trailingAnchor
            .constraint(equalTo: vc.view.trailingAnchor)
            .isActive = true
        fakeDimView
            .topAnchor
            .constraint(equalTo: vc.view.topAnchor)
            .isActive = true
        fakeDimView
            .bottomAnchor
            .constraint(equalTo: vc.view.bottomAnchor)
            .isActive = true
        
        vc.view.addSubview(droidSelection)
        droidSelection
            .translatesAutoresizingMaskIntoConstraints = false
        droidSelection
            .leadingAnchor
            .constraint(
                equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor,
                constant: 26)
            .isActive = true
        droidSelection
            .trailingAnchor
            .constraint(
                equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -26)
            .isActive = true
        droidSelection
            .centerXAnchor
            .constraint(
                equalTo: vc.view.safeAreaLayoutGuide.centerXAnchor)
            .isActive = true
        droidSelection
            .centerYAnchor
            .constraint(
                equalTo: vc.view.safeAreaLayoutGuide.centerYAnchor)
            .isActive = true
        droidSelection
            .topAnchor
            .constraint(
                greaterThanOrEqualTo: vc.view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true) {
            UIView.animate(withDuration: 0.3) {
                fakeDimView.alpha = 1.0
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookingdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailTVC", for: indexPath) as! BookingDetailTVC
        
        let adic = bookingdata[indexPath.row] as! [String:Any]
        cell.detaildate.text = adic["booking_date"] as! String
        cell.detailtime.text = adic["booking_time"] as! String
        cell.detailclass.text = adic["booking_cat"] as! String
        cell.detailarea.text = adic["booking_area"] as! String
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 20
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
        }
    
    
    
    

