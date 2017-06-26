//
//  MemberViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  VERSION BOB-2    (All notes for Bob-1 slides removed)

import UIKit
class MemberViewController: UIViewController, UITextFieldDelegate ,
    UIPickerViewDelegate, UIPickerViewDataSource,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties & Outlets
    
//*  //  Bob-2  SLIDE 6 - Add member or edit member
    var newMember: Bool?  = false       // set value when TESTING
    let defaultStatus = 0               // Guest
    let defaultSwiftLevel = 0           // Beginner
    
    /// sample data, used when editing existing member
    // var thisMember: Member? = sampleMembers[2]   //  Bob-2  SLIDE 8  - DELETED  !!!
//*/    s-6
    
//*    // Bob-2  SLIDE 32 - track needed for SaveButton enabled status
    var memberNameBool: Bool = false         // set value when TESTING
    var memberEmailBool: Bool = false
    var changeAnyBool: Bool = false
//*/    s-32
    
    /// initialize property thisMember
    var thisMember = Member(name: "", city: nil, eMail: nil, status: 0, level: 0, dateJoined: nil, image: nil)  //  Bob-2   SLIDE 39

    //  datePicker and Picker
    let memberStatusPicker = UIPickerView()
    let memberJoinDatePicker = UIDatePicker()
    
    //    Animate
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var constraintTextStackBottom: NSLayoutConstraint!
    var constraintInitially: CGFloat?       //   constraintTextStackBottom.constant
    @IBOutlet weak var memberName: UITextField!
    @IBOutlet weak var memberCity: UITextField!
    @IBOutlet weak var memberEMail: UITextField!
    @IBOutlet weak var memberStatus: UITextField!
    @IBOutlet weak var memberJoinDate: UITextField!
    //    Save Button
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
   
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
        
        ///  save Button always initially disabled
        saveBarButton.isEnabled = false     // Bob-2  SLIDE 32
        
//*     //  Bob-2  SLIDE 7 - put NEW MEMBER default data into display
        if newMember! {
        
        //*    //  Bob-2  SLIDE 32  -  set initial state for changes
            memberNameBool = false
            memberEmailBool = false
        //*/    //  s-32
            
            // no image
            memberImage.image = UIImage(named: "No Image")
            // default value for pickerView
            // set Member values to default setting
            thisMember.status = defaultStatus
            thisMember.level = defaultSwiftLevel
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
//*/    // s-7
        
//*     //  Bob-2  SLIDE 8 - CURRENT MEMBER sample data into display
        else {
        
        //*    //  Bob-2  SLIDE 32  -  set initial state for changes
            memberNameBool = true
            memberEmailBool = true
        //*/    //  s-32
            
            memberImage.image =  thisMember.image    //  Bob-2  SLIDE 26 -
            memberName.text = thisMember.name
            memberCity.text = thisMember.city
            memberEMail.text = thisMember.eMail
            memberStatus.text = status[thisMember.status]  + " - " + swiftLevel[thisMember.level]
            // picked value for pickerView
            memberStatusPicker.selectRow(thisMember.status, inComponent: 0, animated: true)
            memberStatusPicker.selectRow(thisMember.level, inComponent: 1, animated: true)
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
 //*/   s-8

        //  Tap ends edit session
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //  Add observer in Notification Center
        let center = NotificationCenter.default
        center.addObserver(self,
                          // self.keyboardWillHide(),
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
//*      //  Bob-2  SLIDE 23 - Add observer when keyboard shows
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)
//*/    //  s-23
        
    }   // end viewDidLoad  =====================
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    //  Image Picker Controller
    @IBAction func addImageButton(_ sender: UIButton) {
        
        ///  confirm validity of other entries
        saveBarButton.isEnabled = memberNameBool && memberEmailBool  // Bob-2  SLIDE 32
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    
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
        print( "RETURN PRESSED" )
        textField.resignFirstResponder()
        return true
     }
    
    //  textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
/*     //  Bob-2  SLIDE 23 - Animate - DELETED !!
        if constraintTextStackBottom.constant == constraintInitially {
            keyBoardMove (moveUp: true) }
*/
        //   active field is red
        textField.textColor = UIColor.red
        
        /// - some change made to something
        changeAnyBool = true    // Bob-2  SLIDE 32 
        
        //   select text field which is being edited
        switch textField {
        case memberName :
            print ("KEYBOARD:  Standard")
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.default
        case memberCity:
            print ("KEYBOARD:  Phone")
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.default
        case memberEMail:
            print ( "KEYBOARD:  EMail ")
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.emailAddress
        //  set Picker as input Keyboard
        case memberStatus:
            print ("KEYBOARD:  Picker")
            textField.inputView = memberStatusPicker
        //  set Date Picker as input Keyboard
        case memberJoinDate!:
            print ("KEYBOARD:  Date Picker")
            memberJoinDatePicker.addTarget(self,
                    action: #selector(MemberViewController.joinDateChanged(_:)),
                    for: .valueChanged)
            textField.inputView = memberJoinDatePicker
        default:
           break
        }
    }

    //  validate data and indicate editing is done
    func textFieldDidEndEditing(_ textField: UITextField) {
        print ("END EDITING")
        switch textField {

//*     // Bob-2  SLIDE 25 - validate name & city
        case memberName, memberCity:
            let name = memberName.text!
            print ("END EDIT:  Name")
            if isValidName(testStr: name) {
                textField.textColor = UIColor.black
                memberNameBool = true       // Bob-2  SLIDE 32
                print ("VALID:  \(name) ")
                print ("***** NAME:  \(memberNameBool)")
            } else {
                print ("INVALID:  \(name) ")
                memberNameBool = false      // Bob-2  SLIDE 32
                print ("***** NAME:  \(memberNameBool)")
            }
//*/    // s-25
            
        case memberEMail:
            print ("END EDIT:  E-Mail")
            if isValidEmail(testStr: memberEMail.text!) {
                print ("e-Mail:  \(memberEMail.text!)")
                textField.textColor = UIColor.black
                memberEmailBool = true      // Bob-2  SLIDE 32
            } else {
                print ("INVALID:  \(memberEMail.text!) ")
                memberEmailBool = false     // Bob-2  SLIDE 32
            }
        default:
            textField.textColor = UIColor.black
        }
   //*     // Bob-2  SLIDE 32 - enable Save Button
        saveBarButton.isEnabled = memberNameBool && memberEmailBool && changeAnyBool
        print("BUTTON:  \(saveBarButton.isEnabled)  NAME:   \(memberNameBool)    EMAIL:  \(memberEmailBool)")
    //*/   // s-32
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
        return 2  //  Bob-2  SLIDE 5
    }
    //   Set the number of rows in Picker View
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return memberInfo[component].count     //status.count
    }
    //   Assign array of strings to PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return memberInfo[component][row]     //status[row]
    }
    //  Assign selection made by pickerView to textField
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //  Bob-2  SLIDE 5
        if component == 0 {
            thisMember.status = row
            // print("ROW:   ~~\(row)~~   ++\(component)++    **\(member.status)**")
        } else {
            thisMember.level = row
        }
        memberStatus.text = memberInfo[0][(thisMember.status)] + " - " +  memberInfo[1][(thisMember.level)]
    }
    
    
    
    //  MARK: - Support functions
//*
    //  Bob-2  SLIDE 23 -  notification action Will Show
    func keyboardWillShow(notification:NSNotification) -> Void {
        ///   Add Notification Parameter
        keyBoardMove(moveUp: true , notification: notification)   //  Bob-2  SLIDE 24
      //  keyBoardMove(moveUp: true)
    }
//*/
//*
    //  notification action Will Hide
    func keyboardWillHide(notification:NSNotification) -> Void {
        ///  Add Notification Parameter
        keyBoardMove(moveUp: false, notification: notification)   //  Bob-2  SLIDE 24
      //  keyBoardMove(moveUp: false)
    }
//*/
    
    
    //  Animate for Keyboard
    //  NOTE:  hide image and move (stack of) text fields out of the way by
    //         modifying the constraint on the text stack and changing image alpha

/*  // Bob-2  SLIDE 24 - Original VERSION - DELETED
    func keyBoardMove (moveUp: Bool) -> Void {
        var alpha: CGFloat
        var constraint: CGFloat
        print ( "KEYBOARD UP:  \(moveUp) "    )
        if moveUp {
            alpha = 0.1
            constraint = self.constraintInitially! + 80}
        else {
            alpha = 1.0
            constraint =  self.constraintInitially!
            }
        let animInterval = 1.0
        print ("ALPHA: \(alpha)   CONSTRAIN: \(constraint)  ANIM:  \(animInterval)" )
        UIView.animate (withDuration: animInterval,
                            delay: 0,
                            options: .curveEaseOut,
                            animations: { () -> Void in
                                self.memberImage.alpha = alpha
                                self.constraintTextStackBottom.constant = constraint
                                self.view.layoutIfNeeded()
                                },
                            completion: nil )
    }
*/
    
//*    // Bob-2  SLIDE 24 - now includes computation of keyboard size using notification info

    func keyBoardMove (moveUp: Bool, notification: NSNotification) -> Void {
        //  use NSNotification.userInfo dictionary to get keyboard size
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect)
        let stackMove = keyboardFrame.height
        print("Stack MOVE: \(stackMove)")
        var alpha: CGFloat
        var constraint: CGFloat
        print ( "KEYBOARD UP:  \(moveUp) "  )
        if moveUp {
            alpha = 0.1
            constraint =  stackMove + 10}
        else {
            alpha = 1.0
            constraint =  self.constraintInitially!
        }
        let animInterval = 20.0
        let delay = 0.0
        print ("ALPHA: \(alpha)   CONSTRAIN: \(constraint)  ANIM:  \(animInterval)   DELAY:  \(delay)" )
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
//*/
    
    //  NOTE:  A Regex (sometimes called a rational expression) is a sequence of characters that define a search pattern.
    //          ref.  https://msdn.microsoft.com/en-us/library/az24scfc(v=vs.110).aspx
    //  Validate E-Mail format
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         print("testStr:  \(testStr)     emailTest:  \(emailTest) ")
        return emailTest.evaluate(with: testStr)
    }
//*
    // Bob-2  SLIDE 25 - Validate Name format (characters and numbers; max min size)
    func isValidName(testStr:String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z\\s]{2,24}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
//*/
        /*
         [A-Z0-9a-z]    valid match for any letter or number in the ranges shown
         \s             matches any white space character;  note that \ is an escape so we need a 2nd \
         {n,m}          matches the previous element at least n times but no more than m times
                 print("testStr:  \(testStr)     nameTest:  \(nameTest) ")
        */
    }
    






//      RESERVED for BOB 2


//  ====================================================
    
    
    
    

    
    
    
    //* MARK: - Navigation

//* // Bob-2  SLIDE 31 - the Cancel Button
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        if newMember! {
        //  dismissing a MODAL view
        dismiss(animated: true, completion: nil)
        print ("CANCEL pressed - DISMISS")
        } else {
            //  POPING  a view from the STACK
            navigationController?.popViewController(animated: true)
            print ("CANCEL pressed - POP")
        }
    }
//*/   // S-31

//*    // Bob-2  SLIDE 34 - In a storyboard-based application, do a little preparation before navigation
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
    }
//*/    // s-34
    
}    // last curly braces for MemberViewController
    

