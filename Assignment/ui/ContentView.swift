//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//


import UIKit
import Network

class ContentViewController: UIViewController {
    
    private let viewModel = ContentViewModel()
    private var devices: [DeviceData] = []
    private var filteredArray: [DeviceData] = []
    private var tableView: UITableView!
    private var searchField: UITextField!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView = UITableView(frame: .zero, style: .plain)
        searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 60.00))
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeviceCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        searchField.backgroundColor = .gray
        searchField.layer.cornerRadius = 6
        searchField.placeholder = "Please type here"
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        let monitor = NWPathMonitor()
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            
        ])
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        fetchData()
        
        navigationItem.title = "Computers"
        view.backgroundColor = .white
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available.")
                // Perform actions when internet is available
            } else {
                print("Internet connection is not available.")
               
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func fetchData() {
        activityIndicator.startAnimating()
        DispatchQueue.main.async() {
            self.viewModel.fetchAPI() { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let data = self.viewModel.data {
                        self.devices = data
                        self.filteredArray = self.devices
                        self.tableView.reloadData()
                    }
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = false
                }
            }
        }
    }
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        let device = filteredArray[indexPath.row]
        cell.textLabel?.text = device.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDevice = filteredArray[indexPath.row]
        show(DetailViewController(device: selectedDevice),sender: self)
    }
}


extension ContentViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let newString = textField.text {
            let newText = newString + string
            filteredArray = devices.filter { $0.name.contains(newText) }
            self.tableView.reloadData()
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        filteredArray = devices
        self.tableView.reloadData()
    }
    
}

