//
//  ViewController.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/25/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkData()
        textField.delegate = self
    }
    
    func checkData() {
        if let meal = meal {
            textField.text = meal.name
            ratingControl.rating = Int(meal.rating)
            photoImageView.image = meal.image as? UIImage
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else { return }
        let name = textField.text ?? ""
        let rating = ratingControl.rating
        let photo = photoImageView.image ?? UIImage(named: "DefaultPhoto")
        DataServices.share.saveContext(name: name, image: photo!, rating: rating, meal: meal)
    }
    
    //MARK: Action
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealModel = presentingViewController is UINavigationController
        if isPresentingInAddMealModel {
            dismiss(animated: true, completion: nil)
        }else if let navigationController = navigationController{
            navigationController.popViewController(animated: true)
        }else{
            fatalError("error is not inside a navigation")
        }
    }
    
    @IBAction func selectImagePhotoLibrary(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func updateSaveButotnState(){
        let text = textField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

//MARK: UIImagePickerControllerDelegate
extension MealViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { fatalError("Error: \(info)") }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

//AMRK: TextFieldDelegate
extension MealViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButotnState()
        navigationItem.title = textField.text
    }
}


