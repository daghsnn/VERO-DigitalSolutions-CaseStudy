//
//  TasksViewController.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol TasksDisplayLogic: AnyObject {
    func whenViewDidLoad()
    func whenViewWillAppear()
    func displayLogic(viewModel: TasksViewModel)
    func displayError(_ message: String)
}

protocol TaskViewInterfaceable {
    var interactor: TasksBusinessLogic? {get}
    var router: (TasksRoutingLogic &  TasksDataPassing)? {get}
}

final class TasksViewController: UIViewController {
    weak var interactor: TasksBusinessLogic?
    var router: (TasksRoutingLogic & TasksDataPassing)?
    
    private var searchBarOldText : String = ""
    private var viewModel : TasksViewModel?
    // MARK: UI Elements
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.setMagnifyingGlassColorTo(color: UIColor(named: "cellTextColor") ?? .secondaryLabel)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search anything..",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "cellTextColor") ?? .tertiaryLabel]
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
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(TasksCell.self, forCellWithReuseIdentifier: TasksCell.cellId)
        return cv
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
        let interactor = TasksInteractor()
        let presenter = TasksPresenter()
        let router = TasksRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        Task{
            await self.interactor?.getModels()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.viewWillAppear()
    }
    
    private func configureNavBar(){
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "qrcode.viewfinder"), style: .plain, target: self, action: #selector(qrButtonTapped))
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
    }
    
    private func configureUI(){
        view.backgroundColor = UIColor(named: "bgColor")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func qrButtonTapped(){
        
    }
}

extension TasksViewController : TasksDisplayLogic {

    func whenViewDidLoad() {
        configureUI()
    }

    func whenViewWillAppear() {
        configureNavBar()
    }
    
    func displayLogic(viewModel: TasksViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayError(_ message: String) {
        DispatchQueue.main.async {
            self.showToast(message: message)
        }
    }
}
extension TasksViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else {return 0}
        return viewModel.responseModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksCell.cellId, for: indexPath) as? TasksCell, let viewModel = viewModel else {return UICollectionViewCell()}
        cell.configureCell(viewModel.responseModel[indexPath.item])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: max(UIView.HEIGHT * 0.2, 168))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
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
