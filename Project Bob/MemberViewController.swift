//
//  MemberViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  VERSION BOB-3S    [ version purged of all ref to Bob-2]

import UIKit
import CoreData
class MemberViewController: UIViewController, UITextFieldDelegate ,
    UIPickerViewDelegate, UIPickerViewDataSource,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    //  Add member or edit member
    // Bob-3  SLIDE 11 - renamed newMember -> addMember
    var addMember: Bool?  = false
    let defaultStatus = 0               // Guest
    let defaultSwiftLevel = 0           // Beginner
    //  Track needed for SaveButton enabled status
    var memberNameBool: Bool = false
    var memberEmailBool: Bool = false
    var changeAnyBool: Bool = false
    //  initialize property thisMember
    // Bob-3  SLIDE 11 - added newMember as local var, and changed thisMember to class XMember
    var newMember = Member(context: BobDatabase.context)
    var thisMember = XMember(name: "", city: nil, eMail: nil, status: 0, level: 0, dateJoined: nil, image: nil)
    //  datePicker and Picker
    let memberStatusPicker = UIPickerView()
    let memberJoinDatePicker = UIDatePicker()
    //   constraintTextStackBottom.constant
    var constraintInitially: CGFloat?
    
    //  MARK: - Outlets
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var constraintTextStackBottom: NSLayoutConstraint!
    @IBOutlet weak var memberName: UITextField!
    @IBOutlet weak var memberCity: UITextField!
    @IBOutlet weak var memberEMail: UITextField!
    @IBOutlet weak var memberStatus: UITextField!
    @IBOutlet weak var memberJoinDate: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!   //    Save Button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberName.delegate = self
        self.memberCity.delegate = self
        self.memberEMail.delegate = self
        self.memberStatus.delegate = self
        self.memberJoinDate.delegate = self
        // picker delegates initialized
        self.memberStatusPicker.delegate = self
        self.memberStatusPicker.dataSource = self
        
        // constraint initial value
        constraintInitially = self.constraintTextStackBottom.constant

        //  Instances of DateFormatter() create string representations of NSDate objects,
        //  and convert textual representations of dates and times into NSDate objects.
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        //  save Button always initially disabled
        saveBarButton.isEnabled = false
        
        //  NEW MEMBER default data into display
        // Bob-3  SLIDE 11 - renamed newMember -> addMember
        if addMember! {
            memberNameBool = false
            memberEmailBool = false
            // no image
            memberImage.image = UIImage(named: "No Image")
            // default value for pickerView
            // set Member values to default setting
            
           // Bob-3  SLIDE 11 - keeping both Member types
            newMember.status = Int16(defaultStatus)
            thisMember.status = (defaultStatus)
            newMember.level = Int16(defaultSwiftLevel)
            thisMember.level = (defaultSwiftLevel)
            
            memberStatus.text = status[defaultStatus]  + " - " + swiftLevel[defaultSwiftLevel]
            //  matching settings on Status Picker
            memberStatusPicker.selectRow(defaultStatus, inComponent: 0, animated: true)
            memberStatusPicker.selectRow(defaultSwiftLevel, inComponent: 1, animated: true)
            // initialize date picker at todays date
            let dateCurrent = Date()
            memberJoinDatePicker.date = dateCurrent         // set picker to current date
            memberJoinDatePicker.datePickerMode = UIDatePickerMode.date  //  display date (only)
            memberJoinDate?.text = formatter.string(from: dateCurrent)
          //  thisMember.dateJoined = (memberJoinDate?.text)!     // member value to default setting
        }

        //  CURRENT MEMBER sample data into display
        else {
            memberNameBool = true
            memberEmailBool = true
          //  memberImage.image =  thisMember.image
            memberName.text = thisMember.name
            memberCity.text = thisMember.city
            memberEMail.text = thisMember.eMail
            memberStatus.text = status[Int(thisMember.status)]  + " - " + swiftLevel[Int(thisMember.level)]
            // picked value for pickerView
            memberStatusPicker.selectRow(Int(thisMember.status), inComponent: 0, animated: true)
            memberStatusPicker.selectRow(Int(thisMember.level), inComponent: 1, animated: true)
            // joinDate on Date Picker
            // if date is valid then update picker, else set picker to default (current) date
            if let joinDate =  formatter.date(from: thisMember.dateJoined!)  {
              memberJoinDatePicker.date =  joinDate
            }
            else {
               memberJoinDatePicker.date =  Date()
            }
            memberJoinDatePicker.datePickerMode = UIDatePickerMode.date
            //  set display based on pickerDate
            memberJoinDate?.text = formatter.string(from: memberJoinDatePicker.date)
        }

        //  Tap ends edit session
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //  Add observer in Notification Center
        let center = NotificationCenter.default
        center.addObserver(self,
                          // self.keyboardWillHide(),
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
        //  Add observer when keyboard shows
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)

        
    }   // end viewDidLoad  =====================
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    //  Image Picker Controller
    @IBAction func addImageButton(_ sender: UIButton) {
        
        ///  confirm validity of other entries
        saveBarButton.isEnabled = memberNameBool && memberEmailBool
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    //  MARK: - Image Picker func
    //  Cancel - no image selected - dismiss Image Picker screen
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    //  Image selected;  updated imageView;  dismiss Image Picker screen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        memberImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    //  MARK:  -  Text Field
    //  user pressed Return/Done- resigh first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
     }
    
    //  textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.red       //   active field is red
        changeAnyBool = true                    // - some change made to something
        //   select text field which is being edited
        switch textField {
        case memberName :
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.default
        case memberCity:
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.default
        case memberEMail:
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.emailAddress
        case memberStatus:
            textField.inputView = memberStatusPicker    //  set Picker as input Keyboard
        case memberJoinDate!:
            memberJoinDatePicker.addTarget(self,
                    action: #selector(MemberViewController.joinDateChanged(_:)),
                    for: .valueChanged)
            textField.inputView = memberJoinDatePicker  //  set Date Picker as input Keyboard
        default:
           break
        }
    }

    //  validate data and indicate editing is done
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        //  validate name & city
        case memberName, memberCity:
            let name = memberName.text!
            if isValidName(testStr: name) {
                textField.textColor = UIColor.black
                memberNameBool = true
            } else {
                memberNameBool = false
            }
        case memberEMail:
            if isValidEmail(testStr: memberEMail.text!) {
                textField.textColor = UIColor.black
                memberEmailBool = true
            } else {
                memberEmailBool = false
            }
        default:
            textField.textColor = UIColor.black
        }
        //   enable Save Button
        saveBarButton.isEnabled = memberNameBool && memberEmailBool && changeAnyBool
    }
    
    // MARK:  Date Picker
    func joinDateChanged (_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        memberJoinDate?.text! = formatter.string(from: sender.date)
        thisMember.dateJoined = memberJoinDate?.text!
    }
    
    //  MARK:  PickerView protocols
    @available(iOS 2.0, *)
    // set the number of spinners aka components in Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //   Set the number of rows in Picker View
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return memberInfo[component].count
    }
    //   Assign array of strings to PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return memberInfo[component][row]
    }
    //  Assign selection made by pickerView to textField
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            // Bob-3  SLIDE 11 - added case for newMember
            newMember.status = Int16(row)
            thisMember.status = (row)
        } else {
            newMember.level = Int16(row)
            thisMember.level = (row)
        }
        memberStatus.text = memberInfo[0][Int(thisMember.status)] + " - " +  memberInfo[1][Int(thisMember.level)]
    }
    
    //  MARK: - Support functions

    //  notification action Will Show
    func keyboardWillShow(notification:NSNotification) -> Void {
        keyBoardMove(moveUp: true , notification: notification)
    }

    //  notification action Will Hide
    func keyboardWillHide(notification:NSNotification) -> Void {
        keyBoardMove(moveUp: false, notification: notification)
    }
    
    //  Keyboard move includes computation of keyboard size using notification info
    func keyBoardMove (moveUp: Bool, notification: NSNotification) -> Void {
        //  use NSNotification.userInfo dictionary to get keyboard size
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect)
        let stackMove = keyboardFrame.height
        var alpha: CGFloat
        var constraint: CGFloat
        if moveUp {
            alpha = 0.1
            constraint =  stackMove + 10}
        else {
            alpha = 1.0
            constraint =  self.constraintInitially!
        }
        let animInterval = 20.0
        let delay = 0.0
        UIView.animate (withDuration: animInterval,
                        delay: delay,
                        options: .transitionCrossDissolve, //.curveEaseIn ,
                        animations: { () -> Void in
                            self.memberImage.alpha = alpha
                            self.constraintTextStackBottom.constant = constraint
                            self.view.layoutIfNeeded()
                            },
                        completion: nil )
    }

        /*
        NOTE:  A Regex (sometimes called a rational expression) is a sequence of characters that define a search pattern.
             ref.  https://msdn.microsoft.com/en-us/library/az24scfc(v=vs.110).aspx
        
        
         [A-Z0-9a-z]    valid match for any letter or number in the ranges shown
         \s             matches any white space character;  note that \ is an escape so we need a 2nd \
         {n,m}          matches the previous element at least n times but no more than m times
         */
    
    //  Validate E-Mail format
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    //  Validate Name format (characters and numbers; max min size)
    func isValidName(testStr:String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z\\s]{2,24}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
    }
    
    //  MARK: - Navigation
    //  Cancel Button
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
            // Bob-3  SLIDE 11 - renamed newMember -> addMember
        if addMember! {
            dismiss(animated: true, completion: nil)                    //  dismissing a MODAL view
        } else {
            navigationController?.popViewController(animated: true)     //  POPING  a view from the STACK
        }
    }

    //  preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
            //  member
            thisMember.image = memberImage.image
            thisMember.name = memberName.text!
            thisMember.city = memberCity.text!
            thisMember.eMail = memberEMail.text!
            // member.status and member.level are set by picker or defaults
            // joinDate on Date Picker
            thisMember.dateJoined = memberJoinDate.text
        
        // Bob-3  SLIDE 11 - save newMember in CoreData
        //  Member as defined for coreData
        
        //newMember.image = memberImage.image           //  deal with later
        newMember.name = memberName.text!
        newMember.city = memberCity.text!
        newMember.eMail = memberEMail.text!
        // member.status and member.level are set by picker or defaults
        // joinDate on Date Picker
        newMember.dateJoined = memberJoinDate.text
        // save new member in CoreData
        BobDatabase.saveContext()       // saves the context;  saves the data
    }
}    // ===== last curly braces for MemberViewController  =====
    

