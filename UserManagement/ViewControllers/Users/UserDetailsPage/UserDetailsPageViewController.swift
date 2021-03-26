//
//  UserDetailsPageViewController.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/22.
//

import UIKit
import MapKit
import MessageUI

class UserDetailsPageViewController: UIViewController {
    @IBOutlet private weak var userPictureImageView: UIImageView!
    @IBOutlet private weak var ageTitleLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var genderTitleLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailButton: UIButton!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneTitleLabel: UILabel!
    @IBOutlet private weak var phoneButton: UIButton!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var addressTitleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    var userModel: UserModel!
    private lazy var userListViewModel = UserDetailsViewModel(self.userModel)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cofigureView()
        self.configureTabBarButton()
        self.localization()
        self.configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.userModel.name
        self.configureFieldsWithMainColor()
    }
    
    
    // MARK: - Private Methods -
    
    private func cofigureView() {
        self.userPictureImageView.kf.setImage(with: self.userModel.getImageURL(with: .medium))
        self.ageLabel.text = String(self.userModel.age)
        self.genderLabel.text = self.userModel.gender
        self.emailLabel.text = self.userModel.email
        self.phoneLabel.text = self.userModel.phone
        self.addressLabel.text = self.userModel.fullAddres
    }
    
    private func configureTabBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: self.userModel.isSaved.rightBarButtonItemImage,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.barButtonTapedAction(_:)))
    }
    
    private func configureMap() {
        self.mapView.register(MKMarkerAnnotationView.self,
                              forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let coordinate = CLLocationCoordinate2DMake(self.userModel.latitude.as(CLLocationDegrees()),
                                                    self.userModel.longitude.as(CLLocationDegrees()))
        let coordinateMapAnnotation = CoordinateMapAnnotation(coordinate: coordinate)
        self.mapView.addAnnotation(coordinateMapAnnotation)
        self.mapView.setRegion(coordinateMapAnnotation.region, animated: true)
    }
    
    private func configureFieldsWithMainColor() {
        let mainColor = AppSettings.shared.appInfo.mainColor.getMainColor
        self.userPictureImageView.borderColor = mainColor
        self.ageTitleLabel.textColor = mainColor
        self.genderTitleLabel.textColor = mainColor
        self.emailTitleLabel.textColor = mainColor
        self.phoneTitleLabel.textColor = mainColor
        self.addressTitleLabel.textColor = mainColor
    }
    
    private func localization() {
        self.ageTitleLabel.text = Constants.Localization.age.localized
        self.genderTitleLabel.text = Constants.Localization.gender.localized
        self.emailTitleLabel.text = Constants.Localization.email.localized
        self.phoneTitleLabel.text = Constants.Localization.phoneNumber.localized
        self.addressTitleLabel.text = Constants.Localization.address.localized
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([self.userModel.email])
            //            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // TODO: show failure alert
        }
    }
    
    
    // MARK: - @objc Methods -
    
    @objc
    private func barButtonTapedAction(_ sender: UIBarButtonItem) {
        if self.userModel.isSaved {
            sender.image = (!self.userModel.isSaved).rightBarButtonItemImage
            self.userListViewModel.deleteUserModel(self.userModel.user)
        } else {
            sender.image = (!self.userModel.isSaved).rightBarButtonItemImage
            self.userListViewModel.seveUserAction(self.userModel.user)
        }
    }
    
    
    // MARK: - IBAction Methods -
    
    @IBAction private func emailButtonAction(_ sender: UIButton) {
        self.sendEmail()
    }
    
    @IBAction private func phoneButtonAction(_ sender: UIButton) {
        self.userListViewModel.callToUserPhone (self.userModel.phone)
    }
}


// MARK: - MFMailComposeViewControllerDelegate -

extension UserDetailsPageViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


// MARK: - UIGestureRecognizerDelegate -

extension UserDetailsPageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        
        self.showFullScreenImageIfNeeded(self.userModel.getImageURL(with: .large))
        
        return true
    }
}


// MARK: - MKMapViewDelegate -

extension UserDetailsPageViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let mapAnnotation = self.mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            mapAnnotation.animatesWhenAdded = true
            mapAnnotation.titleVisibility = .adaptive
            mapAnnotation.titleVisibility = .visible
            
            return mapAnnotation
        }
        
        return nil
    }
}


// MARK: - Bool+Image-

fileprivate extension Bool {
    var rightBarButtonItemImage: UIImage {
        (self ? #imageLiteral(resourceName: "FilledHeartImage") : #imageLiteral(resourceName: "HeartImage"))    }
}
