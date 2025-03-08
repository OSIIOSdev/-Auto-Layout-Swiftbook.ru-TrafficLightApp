//
//  ViewController.swift
//  TrafficLightApp
//
//  Created by OSIIOSdev on 07.03.2025.
//

import UIKit

enum Lights {
    case redLight, yellowLight, greenLight
}

final class TrafficLightViewController: UIViewController {

    // MARK: Private properties
    
    private var redLightView = UIView()
    private var yellowLightView = UIView()
    private var greenLightView = UIView()
    
    private var lightsStackView = UIStackView()
    
    private var switchButton = UIButton()
    
    private let lightIsOn: CGFloat = 1.0
    private let lightIsOff: CGFloat = 0.2
    
    private var currentLight: Lights = .redLight
    
    
    // MARK: View Lifecycle
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        [redLightView, yellowLightView, greenLightView].forEach {
            
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .black
        
        setupLayout()
    }
    
    
    // MARK: Private methods
    
    private func setupLayout() {
        setupLights()
        setupStackView()
        setupSwitchButton()
    }
    
    private func setupLights() {
        redLightView.backgroundColor = .systemRed
        yellowLightView.backgroundColor = .systemYellow
        greenLightView.backgroundColor = .systemGreen
        
        [redLightView, yellowLightView, greenLightView].forEach {
            
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1).isActive = true
            
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 2.5
            $0.alpha = lightIsOff
        }
    }
    
    private func setupStackView() {
        
        view.addSubview(lightsStackView)
        lightsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [redLightView, yellowLightView, greenLightView].forEach {
            lightsStackView.addArrangedSubview($0)
        }
        
        lightsStackView.axis = .vertical
        lightsStackView.alignment = .fill
        lightsStackView.distribution = .fillEqually
        lightsStackView.spacing = 20
        
        NSLayoutConstraint.activate([
            lightsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            lightsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lightsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupSwitchButton() {
        view.addSubview(switchButton)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.addTarget(self, action: #selector(switchButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: 225),
            switchButton.heightAnchor.constraint(equalToConstant: 55),
            switchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            switchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        switchButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        switchButton.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        switchButton.layer.borderColor = UIColor.white.cgColor
        switchButton.layer.borderWidth = 2.5
        switchButton.setTitle("START", for: .normal)
        switchButton.layer.cornerRadius = 15
    }
    
    @objc private func switchButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "START" {
            sender.setTitle( "NEXT", for: .normal)
        }
        
        switch currentLight {
        case .redLight:
            redLightView.alpha = lightIsOn
            greenLightView.alpha = lightIsOff
            currentLight = .yellowLight
        case .yellowLight:
            yellowLightView.alpha = lightIsOn
            redLightView.alpha = lightIsOff
            currentLight = .greenLight
        case .greenLight:
            greenLightView.alpha = lightIsOn
            yellowLightView.alpha = lightIsOff
            currentLight = .redLight
        }
    }
}

