//
//  ViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import XLForm
import MBProgressHUD
import INTULocationManager

class ReportViewController: XLFormViewController {
    
    private struct Tags {
        //        static let Reason = "reason"
        //        static let Age = "age"
        static let Image = "image"
        static let SecondImage = "secondImage"
        static let ZipCode = "zipCode"
        //        static let ActivityType = "activityType"
        //        static let Gender = "gender"
        static let Location = "location"
        static let Comments = "comments"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialForm()
    }
    
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServiceCaller.getReportListing { (result, error) -> Void in
            print(result)
        }
        
        self.title = "Report"
        if !form.disabled {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Report", style: .Plain, target: self, action: #selector(ReportViewController.savePressed(_:)))
        }
    }
    
    func savePressed(button: UIBarButtonItem) {
        let validationErrors: Array<NSError> = formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0) {
            print(validationErrors.first?.localizedDescription)
            //            showFormValidationError(validationErrors.first)
            let alert = UIAlertController(title: "", message: validationErrors.first?.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        tableView.endEditing(true)
        let object = Report()
        for key in form.formValues().keys {
            if let key = key as? String {
                if let image: UIImage = form.formValues()[key] as? UIImage {
                    if  image != UIImage(named: "default_avatar") {
                        //TODO: Add image
                        //                        let imageFile = CKAsset(fileURL: AppHelper.saveImageToFile(image))
                        //                        object[key] = imageFile
                    }
                } else  if key == Tags.Location {
                    if let value = form.formValues()[key] as? Bool {
                        if value {
                            object[key] = currentLocation
                        }
                    }
                } else {
                    if let value = form.formValues()[key] where !(value is NSNull) {
                        object.setValue(value, forKey: key)
                    }
                }
            }
        }
        ServiceCaller.saveReportObject(object) { (result, error) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            let alert = UIAlertController(title: "Activity reported successfully", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func initialForm() {
        
        let form: XLFormDescriptor
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        form = XLFormDescriptor()
        form.addAsteriskToRequiredRowsTitle = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Describe the reason you are reporting")
        form.addFormSection(section)
        
        // Reason
        //        row = XLFormRowDescriptor(tag: Tags.Reason, rowType: XLFormRowDescriptorTypeTextView)
        //        row.cellConfig.setObject("eg. I saw a young girl, no belongings and dressed for summertime instead of rain.", forKey: "textView.placeholder")
        //        row.required = true
        //        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        form.addFormSection(section)
        
        // Age
        //        row = XLFormRowDescriptor(tag: Tags.Age, rowType:XLFormRowDescriptorTypeSelectorPickerView, title:"Age")
        //        row.selectorOptions = ["0-10", "11-18", "19-25", "26-35", "36-50"]
        //        section.addFormRow(row)
        
        //Gender
        //        row = XLFormRowDescriptor(tag: Tags.Gender, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl, title: "Gender")
        //        row.selectorOptions = ["Male", "Female", "Multiple"]
        //        section.addFormRow(row)
        
        // Zip Code
        row = XLFormRowDescriptor(tag: Tags.ZipCode, rowType: XLFormRowDescriptorTypeZipCode, title: "Zip Code")
        row.cellConfig.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        section.addFormRow(row)
        
        //Activity
        //        row = XLFormRowDescriptor(tag: Tags.ActivityType, rowType: XLFormRowDescriptorTypeSelectorPickerView, title: "Activity Type")
        //        row.selectorOptions = ["Solicitation", "Exploitation", "Under Age", "Other"]
        //        row.required = true
        //        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Location")
        form.addFormSection(section)
        
        //Location
        row = XLFormRowDescriptor(tag: Tags.Location, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Location")
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Images")
        form.addFormSection(section)
        
        //Image
        row = XLFormRowDescriptor(tag: Tags.Image, rowType: XLFormRowDescriptorTypeImage, title: "Image")
        row.value = UIImage(named: "default_avatar")
        let frame = CGRectMake(0, 0, 180, 180)
        row.cellConfig.setObject(NSValue(CGRect: frame), forKey: "imageView.frame")
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Comments")
        form.addFormSection(section)
        
        // Notes
        row = XLFormRowDescriptor(tag: Tags.Comments, rowType: XLFormRowDescriptorTypeTextView)
        row.cellConfigAtConfigure["textView.placeholder"] = "Comments"
        section.addFormRow(row)
        
        self.form = form
    }
    
    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        if formRow.tag == Tags.Image {
            if form.formRowWithTag(Tags.SecondImage) == nil {
                let newRow = formRow.copy() as! XLFormRowDescriptor
                newRow.tag = Tags.SecondImage
                newRow.value = UIImage(named: "default_avatar")
                form.addFormRow(newRow, afterRow:formRow)
            }
        }
        if formRow.tag == Tags.Location {
            if let locationAdded = newValue as? Bool {
                let section = formRow.sectionDescriptor
                if locationAdded {
                    INTULocationManager.sharedInstance().requestLocationWithDesiredAccuracy(INTULocationAccuracy.City, timeout: 10, block: { (location: CLLocation!, accuracy: INTULocationAccuracy, status: INTULocationStatus) -> Void in
                        if let geoPoint = location {
                            self.currentLocation = geoPoint
                            AppHelper.getDisplayLocationFromLocation(geoPoint, completion: { (locationString) -> Void in
                                section.footerTitle = locationString
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if form.formRowAtIndex(indexPath)?.tag == Tags.Image || form.formRowAtIndex(indexPath)?.tag == Tags.SecondImage {
            return 200
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
}
