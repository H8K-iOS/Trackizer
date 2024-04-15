import UIKit

class BackgroundView: UIView {
    private let container = UIView()
    
    private let youTubeImage = UIImageView(image: #imageLiteral(resourceName: "WelcomeYT"))
    private let oneDriveImage = UIImageView(image: #imageLiteral(resourceName: "welcomeOnedrive"))
    private let spotifyImage = UIImageView(image: #imageLiteral(resourceName: "welcomeSpotify"))
    private let netflixImage = UIImageView(image: #imageLiteral(resourceName: "welcomeNetflix"))
    private let backItemSmall = UIImageView(image: #imageLiteral(resourceName: "back1.png"))
    private let backItemSmall1 = UIImageView(image: #imageLiteral(resourceName: "back1.png"))
    private let backItemSmall2 = UIImageView(image: #imageLiteral(resourceName: "back1.png"))
    private let backItemMedium = UIImageView(image: #imageLiteral(resourceName: "back2.png"))
    private let backItemMedium1 = UIImageView(image: #imageLiteral(resourceName: "back2.png"))
    private let backItemMedium2 = UIImageView(image: #imageLiteral(resourceName: "back2.png"))


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.addSubview(container)
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(youTubeImage)
        container.addSubview(oneDriveImage)
        container.addSubview(spotifyImage)
        container.addSubview(netflixImage)
        
        container.addSubview(backItemSmall)
        container.addSubview(backItemSmall1)
        container.addSubview(backItemSmall2)
        container.addSubview(backItemMedium)
        container.addSubview(backItemMedium1)
        container.addSubview(backItemMedium2)
    
        
        youTubeImage.translatesAutoresizingMaskIntoConstraints = false
        oneDriveImage.translatesAutoresizingMaskIntoConstraints = false
        spotifyImage.translatesAutoresizingMaskIntoConstraints = false
        netflixImage.translatesAutoresizingMaskIntoConstraints = false
        
        backItemSmall.translatesAutoresizingMaskIntoConstraints = false
        backItemSmall1.translatesAutoresizingMaskIntoConstraints = false
        backItemSmall2.translatesAutoresizingMaskIntoConstraints = false
        backItemMedium.translatesAutoresizingMaskIntoConstraints = false
        backItemMedium1.translatesAutoresizingMaskIntoConstraints = false
        backItemMedium2.translatesAutoresizingMaskIntoConstraints = false
        
        spotifyImage.contentMode = .scaleAspectFit
        netflixImage.contentMode = .scaleAspectFit
        oneDriveImage.contentMode = .scaleAspectFit
        youTubeImage.contentMode = .scaleAspectFit
        backItemSmall.contentMode = .scaleAspectFit
        backItemSmall1.contentMode = .scaleAspectFit
        backItemSmall2.contentMode = .scaleAspectFit
        backItemMedium.contentMode = .scaleAspectFit
        backItemMedium1.contentMode = .scaleAspectFit
        backItemMedium2.contentMode = .scaleAspectFit
        
    }
    
    private func setConst() {
       
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            container.widthAnchor.constraint(equalToConstant: 289),
            container.heightAnchor.constraint(equalToConstant: 410),
            
            netflixImage.topAnchor.constraint(equalTo: container.topAnchor, constant: -30),
            netflixImage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            youTubeImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            youTubeImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 40),
            
            oneDriveImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            oneDriveImage.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -90),
            
            spotifyImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 50),
            spotifyImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 35),
            
            backItemSmall.topAnchor.constraint(equalTo: container.topAnchor, constant: 25),
            backItemSmall.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -75),
            
            backItemSmall1.bottomAnchor.constraint(equalTo: oneDriveImage.bottomAnchor, constant: -80),
            backItemSmall1.leftAnchor.constraint(equalTo: oneDriveImage.rightAnchor),
            
            backItemSmall2.leftAnchor.constraint(equalTo: netflixImage.leftAnchor, constant: 5),
            backItemSmall2.bottomAnchor.constraint(equalTo: netflixImage.bottomAnchor, constant: -80),
            
            backItemMedium.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            backItemMedium.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10),

            backItemMedium1.leftAnchor.constraint(equalTo: youTubeImage.leftAnchor, constant: -20),
            backItemMedium1.bottomAnchor.constraint(equalTo: youTubeImage.bottomAnchor, constant: -65),
            
            backItemMedium2.leftAnchor.constraint(equalTo: netflixImage.leftAnchor, constant: -20),
            backItemMedium2.bottomAnchor.constraint(equalTo: netflixImage.bottomAnchor, constant: 1),
        ])
    }
}
