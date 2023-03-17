//
//  QuoteTableViewCell.swift
//  Technical-test
//
//  Created by Ostap Savka on 16.03.2023.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let changeRateLabel = UILabel()
    private let favouriteImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearCell()
    }
    
    // MARK: - Public methods
    func configure(title: String?,
                   subtitle: String?,
                   changeRate: String?,
                   isFavourite: Bool,
                   rateColor: VariationColor?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        changeRateLabel.text = changeRate
        
        if let rateColor = rateColor {
            changeRateLabel.textColor = rateColor.color
        } else {
            changeRateLabel.textColor = .black
        }
        
        favouriteImageView.image = isFavourite ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "no-favorite")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(changeRateLabel)
        contentView.addSubview(favouriteImageView)
        setupLabels()
        setupFavouriteImage()
    }
    
    private func setupLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        changeRateLabel.font = UIFont.systemFont(ofSize: 18)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        changeRateLabel.translatesAutoresizingMaskIntoConstraints = false
        changeRateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        changeRateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 24).isActive = true
        changeRateLabel.trailingAnchor.constraint(equalTo: favouriteImageView.leadingAnchor, constant: -24).isActive = true
        changeRateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        changeRateLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setupFavouriteImage() {
        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favouriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        favouriteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        favouriteImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        favouriteImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func clearCell() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        changeRateLabel.text = nil
        favouriteImageView.image = nil
    }
}
