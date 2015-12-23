//
//  ViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import XLForm
import Parse

class ReportViewController: XLFormViewController {
    
    private struct Tags {
        static let Name = "name"
        static let Email = "email"
        static let Twitter = "twitter"
        static let Number = "number"
        static let Integer = "integer"
        static let PickerView = "selectorPickerView"
        static let Decimal = "decimal"
        static let Password = "password"
        static let Image = "image"
        static let Phone = "phone"
        static let Url = "url"
        static let ZipCode = "zipCode"
        static let TextView = "textView"
        static let Location = "location"
        static let Notes = "notes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Report"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Report", style: .Plain, target: self, action: "savePressed:")
    }
    
    func savePressed(button: UIBarButtonItem){
        let validationErrors : Array<NSError> = formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0) {
            print(validationErrors.first?.localizedDescription)
            //            showFormValidationError(validationErrors.first)
            let alert = UIAlertController(title: "", message: validationErrors.first?.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        tableView.endEditing(true)
        print(self.form.formValues())
        
        let object = PFObject(className: "Reported")
        for key in form.formValues().keys {
            if let image: UIImage = form.formValues()[key] as? UIImage {
                print(image)
                let imageData = UIImagePNGRepresentation(image)
                let imageFile = PFFile(name: "image.png", data: imageData!)
                do {
                    try imageFile?.save()
                    object.setObject(imageFile!, forKey: key as! String)
                } catch {
                    
                }
            } else if key == Tags.Location {
                if let value = form.formValues()[key] as? Bool {
                    if value {
                        PFGeoPoint.geoPointForCurrentLocationInBackground({ (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                            object.setObject(geoPoint!, forKey: key as! String)
                        })
                    }
                }
            } else {
                object.setObject(form.formValues()[key]!, forKey: key as! String)
            }
        }
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func initialForm() {
        
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Text Fields")
        form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        //        section.footerTitle = "This is a long text that will appear on section footer"
        form.addFormSection(section)
        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeText, title: "Name")
        row.required = true
        section.addFormRow(row)
        
        // Age
        row = XLFormRowDescriptor(tag: Tags.PickerView, rowType:XLFormRowDescriptorTypeSelectorPickerView, title:"Age")
        row.selectorOptions = ["0-10", "11-18", "19-25", "26-35", "36-50"]
        section.addFormRow(row)
        
        // Zip Code
        row = XLFormRowDescriptor(tag: Tags.ZipCode, rowType: XLFormRowDescriptorTypeZipCode, title: "Zip Code")
        section.addFormRow(row)
        
        // Integer
        row = XLFormRowDescriptor(tag: Tags.Integer, rowType: XLFormRowDescriptorTypeInteger, title: "Integer")
        section.addFormRow(row)
        
        // Phone
        row = XLFormRowDescriptor(tag: Tags.Phone, rowType: XLFormRowDescriptorTypePhone, title: "Phone")
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Location")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Location, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Location")
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Images")
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Image, rowType: XLFormRowDescriptorTypeImage, title: "Image")
        row.value = UIImage(named: "default_avatar")
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        // TextView
        row = XLFormRowDescriptor(tag: Tags.TextView, rowType: XLFormRowDescriptorTypeTextView)
        row.cellConfigAtConfigure["textView.placeholder"] = "Notes"
        section.addFormRow(row)
        
        self.form = form
    }
    
    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        if formRow.tag == Tags.Image {
            let newRow = formRow.copy() as! XLFormRowDescriptor
            newRow.tag = "secondAlert"
            //            newRow.title = "Second Alert"
            form.addFormRow(newRow, afterRow:formRow)
        }
        if formRow.tag == Tags.Location {
            if let newValue = newValue as? Bool {
                print(newValue)
                let section = formRow.sectionDescriptor
                if newValue {
                    PFGeoPoint.geoPointForCurrentLocationInBackground({ (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                        if let geoPoint = geoPoint {
                            AppHelper.getDisplayLocationFromLocation(geoPoint, completion: { (placemark) -> Void in
                                
                                if let city = placemark.locality {
                                    section.footerTitle = city
                                } else {
                                    section.footerTitle = "Location added"
                                }
                                self.tableView.reloadData()
                            })
                        }
                    })
                    
                } else {
                    section.footerTitle = nil
                }
                tableView.reloadData()
            }
        }
    }
}

