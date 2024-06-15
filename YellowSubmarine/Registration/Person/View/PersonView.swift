import UIKit

protocol PersonViewProtocol : UIImageView {
    var sendDate: (() -> Void)? { get set }
    
    func getPersonData() -> PersonData
}

final class PersonView: UIImageView {
    
    var sendDate: (() -> Void)?
    
    private lazy var ticketView : UIImageView = {
        .config(view: UIImageView()) {
            $0.image = .ticket
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }()
    
//    private lazy var personInfoLabel = AppUI.createLabel(
//        withText: "Fill your ticket",
//        textColor: .appBrown,
//        font: <#T##UIFont#>,
//        alignment: <#T##NSTextAlignment#>,
//        isUnderlined: <#T##Bool#>)
    
    private lazy var datePicker : UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .compact
        $0.minimumDate = createDate(day: 1, month: 1, year: 1924)
        $0.maximumDate = Date.now
        $0.date = createDate(day: 1, month: 1, year: 2000)
        return $0
    }(UIDatePicker())
    
    private lazy var sendButton : UIButton = {
        .config(view: UIButton()) { [weak self] in
            guard let self = self else { return }
            $0.backgroundColor = .appOrange
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(onSendDateTouched), for: .touchDown)
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

private extension PersonView {
    
    private func createDate(day: Int, month: Int, year: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = calendar.date(from: dateComponents)
        return date ?? Date.now
    }
    
    private func setUpView() {
        image = .background
        isUserInteractionEnabled = true
        addSubviews(ticketView)
        // addSubviews(datePicker, sendButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            ticketView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            ticketView.centerXAnchor.constraint(equalTo: centerXAnchor),
            ticketView.widthAnchor.constraint(equalToConstant: 300),
            ticketView.heightAnchor.constraint(equalToConstant: 500)
//            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 100),
//            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            sendButton.widthAnchor.constraint(equalToConstant: 100),
//            sendButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func onSendDateTouched() {
        print(datePicker.date)
        self.sendDate?()
    }
}

extension PersonView : PersonViewProtocol {
    func getPersonData() -> PersonData {
        PersonData(birthday: datePicker.date)
    }
}
