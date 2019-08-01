
import UIKit

class RepositoryCell: UITableViewCell, Reusable {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ownerAvatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(_ viewModel: RepositoryViewModel) {
        self.nameLabel.text = viewModel.name
        self.starsImage.image = UIImage(named: "star")
        self.starsLabel.text = viewModel.stars
        self.ownerAvatarImage.load(viewModel.ownerAvatarUrl)
        self.ownerNameLabel.text = viewModel.ownerName
        
        self.initialize()
    }
    
    private func initialize() {
        self.configureViews()
        self.insertViews()
        self.setupConstraints()
    }
    
    private func configureViews() {
        self.nameLabel.font = .bold(ofSize: 18)
        self.nameLabel.textColor = .black
        
        self.starsLabel.font = .medium(ofSize: 16)
        self.starsLabel.textColor = .grayDark
        
        self.ownerNameLabel.font = .medium(ofSize: 14)
        self.ownerNameLabel.textColor = .grayLight
    }
    
    private func insertViews() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.starsImage)
        self.contentView.addSubview(self.starsLabel)
        self.contentView.addSubview(self.ownerAvatarImage)
        self.contentView.addSubview(self.ownerNameLabel)
    }
    
    private func setupConstraints() {
        self.nameLabel
            .topAnchor(equalTo: self.contentView.topAnchor, constant: 16)
            .leadingAnchor(equalTo: self.contentView.leadingAnchor, constant: 16)
        
        self.starsImage
            .topAnchor(equalTo: self.nameLabel.bottomAnchor, constant: 8)
            .leadingAnchor(equalTo: self.contentView.leadingAnchor, constant: 16)
            .widthAnchor(equalTo: 20)
            .heightAnchor(equalTo: 20)
        
        self.starsLabel
            .topAnchor(equalTo: self.nameLabel.bottomAnchor, constant: 8)
            .leadingAnchor(equalTo: self.starsImage.trailingAnchor, constant: 4)
            .bottomAnchor(equalTo: self.contentView.bottomAnchor, constant: -16)
            .widthAnchor(equalTo: 120)
        
        self.ownerAvatarImage
            .topAnchor(equalTo: self.contentView.topAnchor, constant: 16)
            .leadingAnchor(equalTo: self.nameLabel.trailingAnchor, constant: 16)
            .trailingAnchor(equalTo: self.contentView.trailingAnchor, constant: -16)
            .widthAnchor(equalTo: 35)
            .heightAnchor(equalTo: 35)
        
        self.ownerNameLabel
            .topAnchor(equalTo: self.ownerAvatarImage.bottomAnchor, constant: 4)
            .leadingAnchor(equalTo: self.starsLabel.trailingAnchor, constant: 16)
            .trailingAnchor(equalTo: self.contentView.trailingAnchor, constant: -16)
            .bottomAnchor(equalTo: self.contentView.bottomAnchor, constant: -16)
    }
    
    override func draw(_ rect: CGRect) {
        self.ownerAvatarImage.rounded()
    }
    
}
