//
//  AddChannelViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 06/12/24.
//

import UIKit
import iOSDropDown

class AddChannelViewController: UIViewController {

    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var countryCodeiOSDropDown: DropDown!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var categoryiOSDropDown: DropDown!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var chooseCoverLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var categories: [Categories] = []
    var isImagePickerOpen : Bool = false
    var imageData: Data?
    var coverImageData: Data?
    var selectedCategory: Categories?
    var isFromCoverPhoto: Bool = false
    let datePicker = UIDatePicker()
    
    let countryCodes = [
        ["country": "United States", "code": "+1"],
        ["country": "Canada", "code": "+1"],
        ["country": "United Kingdom", "code": "+44"],
        ["country": "India", "code": "+91"],
        ["country": "Australia", "code": "+61"],
        ["country": "Germany", "code": "+49"],
        ["country": "France", "code": "+33"],
        ["country": "Italy", "code": "+39"],
        ["country": "Spain", "code": "+34"],
        ["country": "Mexico", "code": "+52"],
        ["country": "Brazil", "code": "+55"],
        ["country": "China", "code": "+86"],
        ["country": "Japan", "code": "+81"],
        ["country": "South Korea", "code": "+82"],
        ["country": "Russia", "code": "+7"],
        ["country": "South Africa", "code": "+27"],
        ["country": "Saudi Arabia", "code": "+966"],
        ["country": "United Arab Emirates", "code": "+971"],
        ["country": "Singapore", "code": "+65"],
        ["country": "Malaysia", "code": "+60"],
        ["country": "Thailand", "code": "+66"],
        ["country": "Indonesia", "code": "+62"],
        ["country": "New Zealand", "code": "+64"],
        ["country": "Philippines", "code": "+63"],
        ["country": "Vietnam", "code": "+84"],
        ["country": "Turkey", "code": "+90"],
        ["country": "Pakistan", "code": "+92"],
        ["country": "Bangladesh", "code": "+880"],
        ["country": "Nigeria", "code": "+234"],
        ["country": "Egypt", "code": "+20"]
    ]
    
    let placeholderLabel: UILabel = {
          let label = UILabel()
          label.text = "Description"
          label.font = UIFont.systemFont(ofSize: 16)
          label.textColor = UIColor.lightGray
          return label
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDatePicker()
    }
    
    func setupUI() {
        addChannelBtn.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            descriptionTextView.borderColor = .systemGray5
        } else {
            descriptionTextView.borderColor = .systemGray
        }
        
        descriptionTextView.layer.cornerRadius = 8
        numberView.layer.cornerRadius = 8
        numberView.layer.borderWidth = 1
        
        if #available(iOS 13.0, *) {
            numberView.borderColor = .systemGray5
        } else {
            numberView.borderColor = .systemGray
        }
        
        roundedTextFields(textField: titleTextField)
        roundedTextFields(textField: linkTextField)
        roundedTextFields(textField: categoryiOSDropDown)
        roundedTextFields(textField: dateTextField)
        
        descriptionTextView.borderWidth = 1
        pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        
        // Add the placeholder label to the textView
        placeholderLabel.frame = CGRect(x: 8, y: 8, width: descriptionTextView.frame.width - 10, height: 20)
        descriptionTextView.addSubview(placeholderLabel)
        descriptionTextView.delegate = self

        
        if categories.isEmpty {
            getCategories()
        }
        let categoryTitles = categories.compactMap { $0.title }
                
            categoryiOSDropDown.optionArray = categoryTitles
        
        countryCodeiOSDropDown.optionArray = countryCodes.map { "\($0["code"] ?? "")" }

        countryCodeiOSDropDown.arrowSize = CGFloat(10)
        countryCodeiOSDropDown.listHeight = 90

        categoryiOSDropDown.arrowSize = CGFloat(10)
        categoryiOSDropDown.listHeight = 150
        categoryiOSDropDown.selectedRowColor = .systemGray
        categoryiOSDropDown.tintColor = UIColor.systemGreen
        categoryiOSDropDown.checkMarkEnabled = false
        categoryiOSDropDown.didSelect { selectedText, index, id in
            if let selectedCategory = self.categories.first(where: { $0.title == selectedText }) {
                print("Selected Category ID: \(selectedCategory.category_id ?? "N/A")")
                print("Selected Category Title: \(selectedCategory.title ?? "N/A")")
                self.selectedCategory = selectedCategory
            }
        }
        
        countryCodeiOSDropDown.didSelect { selectedText, index, id in
            print(selectedText)
        }
        
    }
    
    func roundedTextFields(textField: UITextField) {
        textField.layer.cornerRadius = 8
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        dateTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: datePicker.date)
        
        dateTextField.resignFirstResponder()
    }
    
    private func openGallaryAlert(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Option", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Update image", style: .default, handler: { [unowned self] _ in
         
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.isImagePickerOpen = true
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                //  imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            else {
                let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Remove Image", style: .default, handler: { [self] _ in
            if isFromCoverPhoto {
                self.coverImageView.image = UIImage(named: "iccnchoosebanner")
                chooseCoverLabel.isHidden = false
            } else {
                self.pictureImageView.image = nil
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = sender
        }
        present(actionSheet, animated: true, completion: nil)
    }
    
//    MARK: - Button Action
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func appPictureAction(_ sender: UIButton) {
        isFromCoverPhoto = false
        openGallaryAlert(sender)
    }
    
    @IBAction func addChannelAction(_ sender: UIButton) {
        addChannel()
    }
    
    @IBAction func uploadCoverImageViewAction(_ sender: UIButton) {
        isFromCoverPhoto = true
        openGallaryAlert(sender)
    }
}

extension AddChannelViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension AddChannelViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        isImagePickerOpen = false
        if isFromCoverPhoto {
            coverImageView.image = pickedImage
            coverImageData = pickedImage.pngData() ?? Data()
            chooseCoverLabel.isHidden = true
        } else {
            pictureImageView.image = pickedImage
            imageData = pickedImage.pngData() ?? Data()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
