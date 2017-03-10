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
    
//*  
    //  Bob-2  SLIDE 6 - Add member or edit member
    let newMember: Bool = false
    let defaultStatus = 0           // Guest
    let defaultSwiftLevel = 0       // Beginner
    
    // sample data, used when editing existing member
    let thisMember = sampleMembers[1]
//*/
    
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
        
//*
        //  Bob-2  SLIDE 7 - put new member default data into display
        if newMember {
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
            thisMember.dateJoined = (memberJoinDate?.text)!     // member value to default setting
        }
            
//*/
        
//*
        //  Bob-2  SLIDE 8 - current member sample data into display
        else {
            memberImage.image = UIImage(named: thisMember.imageName!)
            memberName.text = thisMember.name
            memberCity.text = thisMember.city
            memberEMail.text = thisMember.eMail
            memberStatus.text = status[thisMember.status]  + " - " + swiftLevel[thisMember.level]
            // picked value for pickerView
            memberStatusPicker.selectRow(thisMember.status, inComponent: 0, animated: true)
            memberStatusPicker.selectRow(thisMember.level, inComponent: 1, animated: true)
            // joinDate on Date Picker
            memberJoinDate.text = thisMember.dateJoined

            let joinDate = thisMember.dateJoined ?? formatter.string(from: Date())
            memberJoinDatePicker.date = (formatter.date(from: joinDate))!
            memberJoinDatePicker.datePickerMode = UIDatePickerMode.date
            memberJoinDate?.text = joinDate
        }
 //*/

        //  Tap ends edit session
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //  Add observer in Notification Center
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
    }   // end viewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    //  Image Picker Controller
    @IBAction func addImageButton(_ sender: UIButton) {
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
        //  Animate
        if constraintTextStackBottom.constant == constraintInitially {
            keyBoardMove (moveUp: true) }
        //   active field is red
        textField.textColor = UIColor.red
        //   select text field which is being edited
        switch textField {
        case memberName :
            print ("KEYBOARD:  Standard")
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.default
        case memberCity:
            print ("KEYBOARD:  Phone")
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.namePhonePad
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
        case memberEMail:
            print ("END EDIT:  E-Mail")
            if isValidEmail(testStr: memberEMail.text!) {
                print ("e-Mail:  \(memberEMail.text!)")
                textField.textColor = UIColor.black
            } else {
                print ("INVALID:  \(memberEMail.text!) ")
            }
        default:
            textField.textColor = UIColor.black
        }
    }
    
    // MARK:  Date Picker
    func joinDateChanged (_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        memberJoinDate?.text! = formatter.string(from: sender.date)
    }
    
    //  MARK:  PickerView protocols
    @available(iOS 2.0, *)
    // set the number of spinners aka components in Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
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
        if component == 0 {
            thisMember.status = row
        } else {
            thisMember.level = row
        }
        memberStatus.text = memberInfo[0][thisMember.status] + " - " +  memberInfo[1][thisMember.level]  // update UI
    }
    
    //  MARK: - Support functions
    //  notification action
    func keyboardWillHide() -> Void {
        keyBoardMove(moveUp: false)
    }
    
    //  Animate for Keyboard
    //  NOTE:  hide image and move (stack of) text fields out of the way by
    //         modifying the constraint on the text stack and changing image alpha
    func keyBoardMove (moveUp: Bool) -> Void {
        var alpha: CGFloat
        var constraint: CGFloat
        print ( "KEYBOARD UP:  \(moveUp) "    )
        if moveUp {
            alpha = 0.1
            constraint = self.constraintInitially! + 180}
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
    
    //  Validate E-Mail format
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}    // last curly braces for MemberViewController






//      RESERVED for BOB 2
/*
    //
    func screenWidth () -> CGFloat {
        // returns screen width in pixels
        let screenSize = UIScreen.main.bounds
        var w = screenSize.width
        let h = screenSize.height
        print ("WIDTH:  \(w)   height:  \(h)")
        if w > h {          // Corrects in case landscape mode
            w = h
        }
        print ("WIDTH:  \(w)")
        return w
        
    }
*/


//  ====================================================
    
    
    
    

    
    
    
    /* MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     print ("segueID:  \(segue.identifier)")
     if segue.identifier == "saveColor" {
     let vc = segue.destination as! AphaViewController
     vc.colorLabel.text = colorLabel.text!
     }
     }
     
     */
    

