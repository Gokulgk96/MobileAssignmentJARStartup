//
//  DetailView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//


import UIKit

class DetailViewController: UIViewController {
    
    let device: DeviceData
    private var nameLabel: UILabel!
    private var priceLabel: UILabel!
    private var screenSizeLabel: UILabel!
    private var capacityLabel: UILabel!
    private var descriptionLabel: UILabel!

    init(device: DeviceData) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.text = device.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.text = "Price: $\(device.data?.price ?? 0.0)"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)

        screenSizeLabel = UILabel()
        screenSizeLabel.font = UIFont.systemFont(ofSize: 20)
        screenSizeLabel.text = "Screen Size: \(device.data?.screenSize ?? 0)\""
        screenSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(screenSizeLabel)

        capacityLabel = UILabel()
        capacityLabel.font = UIFont.systemFont(ofSize: 20)
        if let capacity =  device.data?.capacity {
            capacityLabel.isHidden = false
            capacityLabel.text = "Capacity: \(capacity)"
        } else {
            capacityLabel.isHidden = true
        }
        
        capacityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(capacityLabel)

        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        if let description =  device.data?.description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = "Capacity: \(description)"
        } else {
            descriptionLabel.isHidden = true
        }
        descriptionLabel.text = "Description: \(device.data?.description ?? "")"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            screenSizeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            screenSizeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            capacityLabel.topAnchor.constraint(equalTo: screenSizeLabel.bottomAnchor, constant: 20),
            capacityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: capacityLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

