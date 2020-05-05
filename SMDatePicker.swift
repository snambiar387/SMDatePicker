//
//  SMDatePicker.swift
//  Datepicker
//
//  Created by Sreehari M Nambiar on 04/05/20.
//  Copyright © 2020 Sreehari M Nambiar. All rights reserved.
//


import UIKit

protocol SMDatePickerDelegate: class {
    func didCancelDateSelection()
    func didSelect(date: Date)
}

final class SMDatePicker: NSObject {
    
    //MARK:- Public Properties
    weak var delegate: SMDatePickerDelegate?
    
    var minimumDate: Date? {
        set {
            datePicker.minimumDate = newValue
        } get {
            return datePicker.minimumDate
        }
    }
    
    var maximumDate: Date? {
        set {
            datePicker.maximumDate = newValue
        } get {
            return datePicker.maximumDate
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    
    var confirmationTitle = "" {
        didSet {
            confirmationButton.setTitle(confirmationTitle, for: .normal)
        }
    }
    
    var cancelTitle: String = "" {
        didSet {
            if cancelImage == nil {
                cancelButton.setTitle(cancelTitle, for: .normal)
            }
        }
    }
    
    var cancelImage: UIImage? {
        set {
            if let image = newValue {
                cancelButton.setImage(image, for: .normal)
                cancelButton.setTitle("", for: .normal)
                
            } else {
                cancelButton.setTitle(cancelTitle, for: .normal)
            }
        } get {
            return cancelButton.imageView?.image
        }
    }
    
    var cancelButtonTextColor: UIColor? {
        set {
            cancelButton.titleLabel?.textColor = newValue
        } get {
            return cancelButton.titleLabel?.textColor
        }
    }
    
    var confirmationButtonTextColor: UIColor? {
        set {
            confirmationButton.titleLabel?.textColor = newValue
        } get {
            return confirmationButton.titleLabel?.textColor
        }
    }
    
    var cancelButtonTextFont: UIFont? {
        set {
            cancelButton.titleLabel?.font = newValue
        } get {
            return cancelButton.titleLabel?.font
        }
    }
    
    var confirmationButtonTextFont: UIFont? {
        set {
            confirmationButton.titleLabel?.font = newValue
        } get {
            return confirmationButton.titleLabel?.font
        }
    }
    
    var titleTextColor: UIColor? {
        set {
            titleLabel.textColor = newValue
        } get {
            return titleLabel.textColor
        }
    }
    
    var titleFont: UIFont? {
        set {
            titleLabel.font = newValue
        } get {
            return titleLabel.font
        }
    }
    
    var headerViewBackgroundColor: UIColor? {
        set {
            headerView.backgroundColor = newValue
        } get {
            return headerView.backgroundColor
        }
    }
    
    var pickerViewBackgroundColor: UIColor? {
        set {
            datePicker.backgroundColor = newValue
        } get {
            return datePicker.backgroundColor
        }
    }
    
    //MARK:- Private Properties
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)

        return view
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
        headerView.layer.cornerRadius = 14.0
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let confirmationButton: UIButton = {
        let confirmationButton = UIButton(type: .system)
        confirmationButton.addTarget(self, action: #selector(confirmTapped), for: .touchDown)
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    
    private let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        return separatorView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        return containerView
    }()
    
    private var defaultBlueColorForButton: UIColor { return UIColor(displayP3Red: 0.1333, green: 0.4628, blue: 0.8901, alpha: 1.0)}
    
    private var defaultFontForTitle: UIFont { return UIFont.systemFont(ofSize: 18)}
    
    private var defaultFontForActions: UIFont { return UIFont.systemFont(ofSize: 14)}
    
    //MARK:- Overriden
    //275
    var intrinsicContentSize: CGSize { CGSize(width: view.bounds.width, height: UIScreen.main.bounds.height)}
    
    //override class var requiresConstraintBasedLayout: Bool { return true }
    
    override init() {
        super.init()
        setupView()
        setUpLayout()
        confirmationButton.addTarget(self, action: #selector(confirmTapped), for: .touchDown)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchDown)
    }
    
    //MARK:- Private Methods
    
    private func setupView() {
        view.addSubview(containerView)
        view.addSubview(headerView)
        view.addSubview(datePicker)
        headerView.addSubview(titleLabel)
        headerView.addSubview(cancelButton)
        headerView.addSubview(confirmationButton)
        view.addSubview(separatorView)
        configureDefaults()
    }
    
    private func configureDefaults() {
        cancelButtonTextColor = defaultBlueColorForButton
        cancelButtonTextFont = defaultFontForActions
        confirmationButtonTextColor = defaultBlueColorForButton
        confirmationButtonTextFont = defaultFontForActions
        titleFont = defaultFontForTitle
        cancelTitle = "X"
        confirmationTitle = "OK"
    }
    
    private func setUpLayout() {
        
        containerView.heightAnchor.constraint(equalToConstant: 276).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setupHeaderViewAndSubViewsLayout()
        
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separatorView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupHeaderViewAndSubViewsLayout() {
        
        let headerViewHeight: CGFloat = 60
        headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        headerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        cancelButton.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        
        confirmationButton.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        confirmationButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        confirmationButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func remove() {
        animateToHide(true)
    }
    
    private func animateToHide(_ hide: Bool) {
        let y = hide ? view.frame.origin.y + intrinsicContentSize.height : view.frame.origin.y - intrinsicContentSize.height
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y = y
        }) { (_) in
            if hide {
                self.view.removeFromSuperview()
            }
        }
    }
    
    @objc private func cancelTapped() {
        delegate?.didCancelDateSelection()
        animateToHide(true)
    }
    
    @objc private func confirmTapped() {
        delegate?.didSelect(date: datePicker.date)
        animateToHide(true)
    }
    
    //MARK:- Public
    
    func present(from viewController: UIViewController) {
        viewController.view.addSubview(view)
        view.frame = CGRect(x: 0, y: viewController.view.bounds.height, width: viewController.view.bounds.width, height: intrinsicContentSize.height)
        animateToHide(false)
    }
}

