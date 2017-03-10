//
//  MemberViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  This is a STARTING POINT for those following the lecture for Bob-1

import UIKit
class MemberViewController: UIViewController,
    UITextFieldDelegate
//    , UIPickerViewDelegate, UIPickerViewDataSource       //  Bob 1 - SLIDE 8
//    , UIImagePickerControllerDelegate, UINavigationControllerDelegate  //  Bob 1 - SLIDE 19
{
    
    // MARK: - Notes
    /*
    UITextFieldDelegate - The UITextFieldDelegate protocol defines methods that you use to manage the editing and validation of text in a UITextField object. All of the methods of this protocol are optional.
    UIPickerViewDelegate - The delegate of a UIPickerView object must adopt this protocol and implement at least some of its methods to provide the picker view with the data it needs to construct itself.
     UIImagePickerControllerDelegate -
     The UIImagePickerControllerDelegate protocol defines methods that your delegate object must implement to interact with the image picker interface. The methods of this protocol notify your delegate when the user either picks an image or movie, or cancels the picker operation.
     UINavigationControllerDelegate -
    */
    
    // MARK: - Properties & Outlets
    //  add properties of datePicker and Picker
//   let memberStatusPicker = UIPickerView()     //  Bob 1 - SLIDE 8:
//   let memberJoinDatePicker = UIDatePicker()   //  Bob 1 - SLIDE 10:
    
//*
    // Bob 1 - SLIDE 11:   Animate constraint & image outlets
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var constraintTextStackBottom: NSLayoutConstraint!
    var constraintInitially: CGFloat?  //constraintTextStackBottom.constant
//*/
    
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
        
/*
        //  Bob 1 - SLIDE 8:  picker delegates initialized
        self.memberStatusPicker.delegate = self
        self.memberStatusPicker.dataSource = self
        //  NOTE:  Bob 1 - SLIDE 8:  default value for pickerView
        memberStatusPicker.selectRow(1, inComponent: 0, animated: true)
*/

/*
        // Bob 1 - SLIDE 10:   initialize date picker
        memberJoinDatePicker.date = NSDate() as Date
        memberJoinDatePicker.datePickerMode = UIDatePickerMode.date
*/

        
/*
        // Bob 1 - SLIDE 11:  constraint initial value
        constraintInitially = self.constraintTextStackBottom.constant
         print ("CONSTRAINT:  \(constraintInitially)")
*/
     
/*
         //  NOTE:  Bob 1 - SLIDE 15:  Tap ends edit session
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
*/
        
        
/*     //  NOTE:  Bob 1 - SLIDE 16:  Add observer in Notification Center
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
*/
    }   // ** end of View Did Load   ***************************
    


    // MARK: - Actions
/*    //  NOTE:  Bob 1 - SLIDE 19:  Image Picker Controller
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
*/
    
    //  MARK:  -  Text Field
    //  NOTE: display keyboard or Picker or Date Picker depending on which text field is first responder
    
/*
    //  Bob 1 - SLIDE 6:  user pressed Return/Done- resigh first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print( "RETURN PRESSED" )
        textField.resignFirstResponder()
        keyBoardMove(moveUp: false)   // SLIDE 14:  ANIMATE FAIL
        return true
     }
 */
    
/*
    //  Bob 1 - SLIDE 7:  textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
/*
        //  Bob 1 - SLIDE 14:   ANIMATE
        if constraintTextStackBottom.constant == constraintInitially {
            keyBoardMove (moveUp: true) }
        // NOTE: helps user see which field is active
        textField.textColor = UIColor.red
*/
        
        //  keyBoardMove (moveUp: true)   //   SLIDE 13:   ANIMATE FAIL
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

/*
        //  Bob 1 - SLIDE 8:  set Picker as input Keyboard
        case memberStatus:
            print ("KEYBOARD:  Picker")
            textField.inputView = memberStatusPicker
*/
            
/*
        //  Bob 1 - SLIDE 10:  set Date Picker as input Keyboard
        case memberJoinDate:
            print ("KEYBOARD:  Date Picker")
            //  memberJoinDate.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
            memberJoinDatePicker.addTarget(self,
                    action: #selector(MemberViewController.joinDateChanged(_:)),
                    for: .valueChanged)
            textField.inputView = memberJoinDatePicker
*/
        default:
           break
        }
    }
*/  // SLIDE 7
    
    
/*
    //  keyBoardMove (moveUp: true)   // Bob 1 - SLIDE 13:
    //  Use to validate data and indicate editing is done
    func textFieldDidEndEditing(_ textField: UITextField) {
        print ("END EDITING")
       // keyBoardMove(moveUp: false)     //   SLIDE 13:   ANIMATE FAIL
/*
        // Bob 1 - SLIDE 18:
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
*/
    }
*/
    


//  MARK:  PickerView protocols
/*
    //    Bob 1 - SLIDE 9:  PickerView protocols
    @available(iOS 2.0, *)
    // set the number of spinners aka components in Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //   Set the number of rows in Picker View
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    //   Assign array of strings to PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]     // array of status types defined in Member.Swift
    }
    //  Assign selection made by pickerView to textField
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        memberStatus.text = status[row]
       // memberStatus.resignFirstResponder()   // selection made; dismiss picker
    }
    
*/
    
    // MARK:  Date Picker
/*
     // Bob 1 - SLIDE 10:  data Picker
     func joinDateChanged (_ sender: UIDatePicker){
     let formatter = DateFormatter()
     formatter.dateStyle = .long
     memberJoinDate.text! = formatter.string(from: sender.date)
     print ("DUE DATE \(memberJoinDate.text!)")
     }
*/
    
    //  MARK: - Support functions
/*
    //  Bob 1 - SLIDE 16:  notification action
    func keyboardWillHide() -> Void {
        keyBoardMove(moveUp: false)
    }
*/
    
/*
    // Bob 1 - SLIDE 12:  Animate for Keyboard
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
*/
    
/*
    //  Bob 1 - SLIDE 18:  Validate E-Mail format
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
*/

}    // last curly braces for MemberViewController   =================================================


//                END OF BOB 1







