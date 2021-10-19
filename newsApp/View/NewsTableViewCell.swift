//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/11/21.
//

import UIKit

// tableview cell model

class NewsTableViewCellModel {
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    init(
        title: String,
        imageURL: URL?
    )
    {
        self.title = title
        self.imageURL = imageURL
    }
}


class NewsTableViewCell: UITableViewCell
{
    
    static let identifier = "NewsTableViewCell"
    


    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia", size: 17)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // constraints for title label
        newsTitleLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width - 170, height: 70)

        // constraints for image view
        newsImageView.frame = CGRect(x: contentView.frame.size.width-150, y: 5, width: 160, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellModel){
        newsTitleLabel.text = viewModel.title
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            } .resume()
        }
        
        
    }



}
