//
//  RestaurantTableViewCell.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {
    static let identifier = "restaurantCell"
    
    private var nameLabel = UILabel()
    private var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    private var ratingLabel = UILabel()
    private var favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return favoriteButton
    }()
    private var sourceImage: UIImageView = {
        let sourceImage = UIImageView()
        sourceImage.contentMode = .scaleAspectFill
        return sourceImage
    }()
    private var restaurantId: String?
    private var isFavorite: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(sourceImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(favoriteButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = contentView.frame;
        frame.origin.x = 10
        frame.size.width = self.contentView.frame.width-20.0
        frame.size.height = self.contentView.frame.height-5.0
        contentView.frame = frame

        frame.origin.x = 0
        frame.origin.y = 0
        frame.size.width = frame.size.width
        frame.size.height = frame.size.width*344/612
        sourceImage.frame = frame

        frame.origin.x = 10
        frame.size.width -= 20
        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        nameLabel.frame = frame

        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        addressLabel.frame = frame

        frame.origin.y += frame.size.height+10
        frame.size.height = 30
        ratingLabel.frame = frame

        frame.origin.x = self.contentView.frame.width-40
        frame.size.height = 30
        frame.size.width = 30
        favoriteButton.frame = frame
    }
    
    func setData(restaurant: Restaurant, isFavorite: Bool = false) {
        self.nameLabel.text = restaurant.name
        self.addressLabel.text = restaurant.address?.fullAddress
        if let rating = restaurant.aggregateRating?.thefork?.ratingValue {
            self.ratingLabel.text = "Rating: \(rating)"
        }
        self.restaurantId = restaurant.uuid
        self.isFavorite = isFavorite
        self.setFavButtonImage()
        
        let placeholderImage = UIImage.placeholderImage
        sourceImage.image = placeholderImage
        if let url = restaurant.mainPhoto?.medium,
           let imageURL = URL(string: url) {
            sourceImage.af.setImage(withURL: imageURL, placeholderImage: placeholderImage)
        }
    }
    
    @objc func didTapFavoriteButton(){
        isFavorite = !isFavorite
        guard let restaurantId = restaurantId else { return }
        try? UserDefaultsManager.shared.set(object: isFavorite, forKey: restaurantId)
        self.setFavButtonImage()
    }
    
    func setFavButtonImage() {
        let image = isFavorite ? UIImage.filledHeartIcon : UIImage.emptyHeartIcon
        favoriteButton.setImage(image, for: .normal)
    }
    
}
