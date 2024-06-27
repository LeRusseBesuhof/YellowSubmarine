import UIKit

protocol ListViewProtocol : UIImageView {
    var notesMockData : [Note] { get set }
    func updateData(_ notes: [Note])
}

final class ListView: UIImageView {
    
    private lazy var titleLabel : UILabel = AppUI.createLabel(
        withText: "Your notes",
        textColor: .white,
        font: .getMeriendaFont(fontType: .bold, fontSize: 32),
        alignment: .center
    )
    
    private lazy var canvasView : UIView = {
        .config(view: UIView()) {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 50
            $0.clipsToBounds = true
        }
    }()
    
    internal var notesMockData : [Note] = []
    
    private lazy var tableView : UITableView = {
        .config(view: UITableView()) {
            $0.dataSource = self
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "list")
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ListView {
    private func setUpView() {
        image = .backMerged
        isUserInteractionEnabled = true
        
        canvasView.addSubview(tableView)
        addSubviews(titleLabel, canvasView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            canvasView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            canvasView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            tableView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
    }
}

extension ListView : ListViewProtocol {
    func updateData(_ notes: [Note]) {
        notesMockData = notes
        tableView.reloadData()
    }
}

extension ListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesMockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = notesMockData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        var config = cell.defaultContentConfiguration()
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .blue
        cell.contentConfiguration = config.setConfig(
            text: item.name,
            font: .getMontserratFont(fontSize: 16),
            isURL: true,
            image: item.imgUrl,
            sndText: item.date,
            sndTextColor: .appSecondaryText,
            sndTextFont: .getMontserratFont(fontSize: 12)
        )
        return cell
    }
}
