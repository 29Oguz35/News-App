//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by naruto kurama on 28.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let newsSubtitleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .light)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let newsImageView : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        img.layer.masksToBounds = true
        img.backgroundColor = .secondarySystemBackground
        img.contentMode = .scaleAspectFill
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 170, height: 70)
        
        newsSubtitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height / 2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 150, y: 5, width: 140, height: contentView.frame.size.height - 10)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTitleLabel.text = nil
        newsSubtitleLabel.text = nil
        newsImageView.image = nil
    }
    func configure(with viewModels: NewsTableViewCellViewModel) {
        
        newsTitleLabel.text = viewModels.title
        newsSubtitleLabel.text = viewModels.subTitle
        
        if let data = viewModels.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModels.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self ] data, _, error in
                guard let data = data ,error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }

            }.resume()
            
        }
    }
}
