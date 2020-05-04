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

@IBDesignable final class SMDatePicker: UIView {
    
    //MARK:- Public Properties
    weak var delegate: SMDatePickerDelegate?
    
    @IBInspectable var minimumDate: Date? {
        set {
            datePicker.minimumDate = newValue
        } get {
            return datePicker.minimumDate
        }
    }
    
    @IBInspectable var maximumDate: Date? {
        set {
            datePicker.maximumDate = newValue
        } get {
            return datePicker.maximumDate
        }
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    
    @IBInspectable var confirmationTitle = "" {
        didSet {
            confirmationButton.setTitle(confirmationTitle, for: .normal)
        }
    }
    
    @IBInspectable var cancelTitle: String = "" {
        didSet {
            if cancelImage == nil {
                cancelButton.setTitle(cancelTitle, for: .normal)
            }
        }
    }
    
    @IBInspectable var cancelImage: UIImage? {
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
    
    @IBInspectable var cancelButtonTextColor: UIColor? {
        set {
            cancelButton.titleLabel?.textColor = newValue
        } get {
            return cancelButton.titleLabel?.textColor
        }
    }
    
    @IBInspectable var confirmationButtonTextColor: UIColor? {
        set {
            confirmationButton.titleLabel?.textColor = newValue
        } get {
            return confirmationButton.titleLabel?.textColor
        }
    }
    
    @IBInspectable var cancelButtonTextFont: UIFont? {
        set {
            cancelButton.titleLabel?.font = newValue
        } get {
            return cancelButton.titleLabel?.font
        }
    }
    
    @IBInspectable var confirmationButtonTextFont: UIFont? {
        set {
            confirmationButton.titleLabel?.font = newValue
        } get {
            return confirmationButton.titleLabel?.font
        }
    }
    
    @IBInspectable var titleTextColor: UIColor? {
        set {
            titleLabel.textColor = newValue
        } get {
            return titleLabel.textColor
        }
    }
    
    @IBInspectable var titleFont: UIFont? {
        set {
            titleLabel.font = newValue
        } get {
            return titleLabel.font
        }
    }
    
    @IBInspectable var headerViewBackgroundColor: UIColor? {
        set {
            headerView.backgroundColor = newValue
        } get {
            return headerView.backgroundColor
        }
    }
    
    @IBInspectable var pickerViewBackgroundColor: UIColor? {
        set {
            datePicker.backgroundColor = newValue
        } get {
            return datePicker.backgroundColor
        }
    }
    
    //MARK:- Private Properties
    
    private let headerView: UIView = {
        let headerView = UIView()
        headerView.layer.cornerRadius = 14.0
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let confirmationButton: UIButton = {
        let confirmationButton = UIButton(type: .system)
        confirmationButton.addTarget(self, action: #selector(confirmTapped(_:)), for: .touchDown)
        
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        return confirmationButton
    }()
    
    private let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchDown)
        return cancelButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "test"
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
        return containerView
    }()
    
    private var defaultBlueColorForButton: UIColor { return UIColor(displayP3Red: 0.1333, green: 0.4628, blue: 0.8901, alpha: 1.0)}
    
    private var defaultFontForTitle: UIFont { return UIFont.systemFont(ofSize: 18)}
    
    private var defaultFontForActions: UIFont { return UIFont.systemFont(ofSize: 14)}
    
    //MARK:- Overriden
    //275
    override var intrinsicContentSize: CGSize { CGSize(width: bounds.width, height: UIScreen.main.bounds.height)}
    
    override class var requiresConstraintBasedLayout: Bool { return true }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    //MARK:- Private Methods
    
    private func commonInit() {
        setupView()
        setUpLayout()
    }
    
    private func setupView() {
        addSubview(containerView)
        addSubview(headerView)
        addSubview(datePicker)
        headerView.addSubview(titleLabel)
        headerView.addSubview(cancelButton)
        headerView.addSubview(confirmationButton)
        addSubview(separatorView)
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
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.5)
    }
    
    private func setUpLayout() {
        
        containerView.heightAnchor.constraint(equalToConstant: 276).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupHeaderViewAndSubViewsLayout()
        
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separatorView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
        let y = hide ? frame.origin.y + intrinsicContentSize.height : frame.origin.y - intrinsicContentSize.height
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = y
        }) { (_) in
            if hide {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc private func cancelTapped(_ sender: UIButton) {
        delegate?.didCancelDateSelection()
        animateToHide(true)
    }
    
    @objc private func confirmTapped(_ sender: UIButton) {
        delegate?.didSelect(date: datePicker.date)
        animateToHide(true)
    }
    
    //MARK:- Public
    
    func present(from viewController: UIViewController) {
        viewController.view.addSubview(self)
        frame = CGRect(x: 0, y: viewController.view.bounds.height, width: viewController.view.bounds.width, height: intrinsicContentSize.height)
        animateToHide(false)
    }
}

