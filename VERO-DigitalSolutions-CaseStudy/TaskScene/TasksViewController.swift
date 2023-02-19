//
//  TasksViewController.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol TasksDisplayLogic: AnyObject {
    func displaySomething(viewModel: Tasks.Something.ViewModel)
}
protocol TaskViewInterfaceable {
    var interactor: TasksBusinessLogic? {get}
    var router: (TasksRoutingLogic &  TasksDataPassing)? {get}
}
final class TasksViewController: UIViewController {
    weak var interactor: TasksBusinessLogic?
    var router: (TasksRoutingLogic & TasksDataPassing)?
    
    private var searchBarOldText : String = ""

    // MARK: UI Elements

    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.setMagnifyingGlassColorTo(color: UIColor(named: "cellTextColor") ?? .secondaryLabel)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search anything..",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "cellTextColor")]
        )
        searchBar.setClearButtonColorTo(color: UIColor(named: "cellTextColor") ?? .secondaryLabel)
        searchBar.isTranslucent = true
        searchBar.searchTextField.textColor = UIColor(named: "cellTextColor")
        searchBar.searchTextField.backgroundColor = UIColor(named: "editBgColor")?.withAlphaComponent(0.25)
        searchBar.searchTextField.font = .systemFont(ofSize: 12, weight: .regular)
        searchBar.image(for: .search, state: .normal)
        searchBar.delegate = self
        return searchBar
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
        let interactor = TasksInteractor()
        let presenter = TasksPresenter()
        let router = TasksRouter()
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
        view.backgroundColor = UIColor(named: "bgColor")
        Task{
            await self.interactor?.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    private func configureNavBar(){
        navigationItem.titleView = searchBar
        navigationController?.modalTransitionStyle = .flipHorizontal
        navigationController?.isNavigationBarHidden = false
    }
    // MARK: Do something
}

extension TasksViewController : TasksDisplayLogic {
    func displaySomething(viewModel: Tasks.Something.ViewModel) {
        
    }
}

extension TasksViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            if searchBarOldText.count > searchText.count {
//                self.configureSearching(searchText.lowercased(), isPressBackSpace: true)
            } else {
                searchBarOldText = searchText
//                self.configureSearching(searchText.lowercased())
            }
        } else if searchText.count == 0 {
            searchBar.showsCancelButton = false
//            configureCancelSearch()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarOldText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBarOldText = ""
//        configureCancelSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        if searchBar.text?.count ?? 1 > 0 {
//            self.configureSearching((searchBar.text?.lowercased())!)
        }
    }
}
