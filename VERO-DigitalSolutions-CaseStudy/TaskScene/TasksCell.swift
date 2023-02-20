//
//  TasksCell.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 20.02.2023.
//

import UIKit

final class TasksCell: UICollectionViewCell {
    static let cellId:String = "TasksCell"
    
    var product : TasksResponseModel?
    
    private var bgColor : UIColor? {
        willSet{
            self.layoutSubviews()
        }
    }

    private lazy var taskLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .secondaryLabel.withAlphaComponent(0.87)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var lineView : UIView = {
        let view = UIView(frame: contentView.frame)
        view.backgroundColor = .tertiaryLabel
        return view
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layer.cornerRadius = 8
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(taskLabel)
        addSubview(titleLabel)
        addSubview(lineView)
        addSubview(descriptionLabel)
        
        taskLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIView.HEIGHT * 0.0237)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(taskLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIView.HEIGHT * 0.019)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    func configureCell(_ task: TasksResponseModel){
        taskLabel.text = task.task
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        if let colorCode = task.colorCode {
            self.bgColor = UIColor(hex: colorCode)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = bgColor ?? .gray
        layer.masksToBounds = false
        layer.shadowColor = self.bgColor?.cgColor
        layer.cornerRadius = 8
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
   
}

