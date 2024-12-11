//
//  AddChannelViewController.swift
//  TheChannels
//
//  Created by ideveloper9 on 06/12/24.
//

import UIKit
import iOSDropDown

class AddChannelViewController: UIViewController {

    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var chooseCoverImageView: UILabel!
    @IBOutlet weak var uploadCoverImageView: UIImageView!
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
        descriptionTextView.borderWidth = 1
        pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        
        if categories.isEmpty {
            getCategories()
        }
//        let categoryTitles = categories.compactMap { $0.title }

//        categoryDropDown.optionArray = ["22","21"]
//        categoryDropDown.arrowSize = CGFloat(10)
        
//        categoryDropDown.didSelect { selectedText, index, id in
//            if let selectedCategory = self.categories.first(where: { $0.title == selectedText }) {
//                print("Selected Category ID: \(selectedCategory.category_id ?? "N/A")")
//                print("Selected Category Title: \(selectedCategory.title ?? "N/A")")
//                self.selectedCategory = selectedCategory
//            }
//        }
        
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        
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
                self.coverImageView.image = nil
                uploadCoverImageView.isHidden = false
                chooseCoverImageView.isHidden = false
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

extension AddChannelViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        isImagePickerOpen = false
        if isFromCoverPhoto {
            coverImageView.image = pickedImage
            coverImageData = pickedImage.pngData() ?? Data()
            chooseCoverImageView.isHidden = true
            uploadCoverImageView.isHidden = true
        } else {
            pictureImageView.image = pickedImage
            imageData = pickedImage.pngData() ?? Data()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
