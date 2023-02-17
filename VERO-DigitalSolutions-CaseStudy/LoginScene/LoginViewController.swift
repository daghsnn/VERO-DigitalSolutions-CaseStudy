//
//  LoginViewController.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit
import Combine

protocol LoginDisplayLogic: AnyObject {
    func displaySomething(viewModel: LoginViewModel)
}

final class LoginViewController: UIViewController {
    // MARK: Varibles
    @Published private var username : String = ""
    @Published private var password : String = ""
    private var cancellable:Set<AnyCancellable> = []
    
    private var validatedCredentials: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest($username, $password)
            .receive(on: RunLoop.main)
            .map { username, password in
                return username != "" && password != "" ? (username, password) : nil
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Design Pattern Varibles

    private var interactor: LoginBusinessLogic?
    private var router: (LoginRoutingLogic & LoginDataPassing)?

    // MARK: UI Elements
    
    private lazy var usernameLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Username"
        return label
    }()
    
    private lazy var usernamelineView : UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryLabel.withAlphaComponent(0.87)
        return view
    }()
    
    private lazy var usernameTextField : UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textAlignment = .left
        textField.textColor = .label.withAlphaComponent(0.87)
        textField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.quaternaryLabel])
        textField.tintColor = .systemGray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordLabel : UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .label
        label.text = "Password"
        return label
    }()
    
    private lazy var passwordTextField : UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textAlignment = .left
        textField.isSecureTextEntry = true
        textField.textColor = .label.withAlphaComponent(0.87)
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.quaternaryLabel])
        textField.tintColor = .systemGray
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryLabel.withAlphaComponent(0.87)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6
        button.isEnabled = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validatedCredentials.map{ self.configureButtonColors(isEnable: $0 != nil)
            return $0 != nil}
        .receive(on: RunLoop.main)
        .assign(to: \.isEnabled, on: loginButton)
        .store(in: &cancellable)
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    private func configureUI() {
        view.backgroundColor = .label.withAlphaComponent(0.6)
        view.addSubview(usernameLabel)
        view.addSubview(usernamelineView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordLineView)
        view.addSubview(loginButton)
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(UIView.HEIGHT * 0.30)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(usernameLabel.snp.bottom).offset(6)
        }
        
        usernamelineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(usernameTextField.snp.bottom).offset(4)
            make.height.equalTo(1)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(usernamelineView.snp.top).offset(UIView.HEIGHT * 0.0417)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordLabel.snp.bottom).offset(6)
        }
        
        passwordLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
            make.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordLineView.snp.top).offset(UIView.HEIGHT * 0.2)
            make.height.equalTo(UIView.HEIGHT * 0.055)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    // TODO: Success te handle
    func configureSucces(_ isSucces:Bool) {
        usernamelineView.snp.updateConstraints { make in
            make.height.equalTo(2)
        }
        passwordLineView.snp.updateConstraints { make in
            make.height.equalTo(2)
        }
        if isSucces {
            usernamelineView.addGradientLayer(starColor: UIColor(red: 0.446, green: 0.873, blue: 0.771, alpha: 1), endColor: UIColor(red: 0.112, green: 0.87, blue: 0.488, alpha: 1), withAnimation: true)
            passwordLineView.addGradientLayer(starColor: UIColor(red: 0.446, green: 0.873, blue: 0.771, alpha: 1), endColor: UIColor(red: 0.112, green: 0.87, blue: 0.488, alpha: 1), withAnimation: true)
        } else {
            usernamelineView.addGradientLayer(starColor: UIColor.red.withAlphaComponent(0.7), endColor: UIColor.red, withAnimation: true)
            passwordLineView.addGradientLayer(starColor: UIColor.red.withAlphaComponent(0.7), endColor: UIColor.red, withAnimation: true)
        }
    }
    
    private func configureButtonColors(isEnable:Bool) {
        guard let subLayers = loginButton.layer.sublayers else {return}
        for layer in subLayers {
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        if isEnable {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = loginButton.bounds
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [UIColor(red: 0.446, green: 0.873, blue: 0.771, alpha: 1).cgColor, UIColor(red: 0.112, green: 0.87, blue: 0.488, alpha: 1).cgColor]
            gradientLayer.masksToBounds = true
            loginButton.layer.insertSublayer(gradientLayer, at: 0)
            loginButton.makeShadow(color: UIColor(red: 0.106, green: 0.882, blue: 0.686, alpha: 1), offSet: CGSize(width: 0, height: 4), blur: 8, opacity: 1)
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = loginButton.bounds
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [UIColor(red: 0.446, green: 0.873, blue: 0.771, alpha: 0.2).cgColor, UIColor(red: 0.112, green: 0.87, blue: 0.488, alpha: 0.2).cgColor]
            gradientLayer.masksToBounds = true
            loginButton.layer.insertSublayer(gradientLayer, at: 0)
            loginButton.makeShadow(color: UIColor(red: 0.106, green: 0.882, blue: 0.686, alpha: 1), offSet: CGSize(width: 0, height: 4), blur: 8, opacity: 1)        }
    }
    
    @objc private func loginClicked(){
        //        interactor?.userTappedLogin(emailTextField.text, password: passwordTextField.text)
        print("enable")
    }
    
}

extension LoginViewController : LoginDisplayLogic {
    func displaySomething(viewModel: LoginViewModel){
        
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = textField.text ?? ""
        let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == usernameTextField {
            username = text
        } else {
            password = text
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernamelineView.addGradientLayer(starColor: UIColor(named: "focusedColor2"), endColor: UIColor(named: "focusedColor"))
        } else {
            passwordLineView.addGradientLayer(starColor: UIColor(named: "focusedColor2"), endColor: UIColor(named: "focusedColor"))
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text == "" {
            if textField == usernameTextField {
                usernamelineView.addGradientLayer(starColor: .systemGray.withAlphaComponent(0.87), endColor: .systemGray.withAlphaComponent(0.87))
            } else {
                passwordLineView.addGradientLayer(starColor: .systemGray.withAlphaComponent(0.87), endColor: .systemGray.withAlphaComponent(0.87))
            }
        }
    }
}
