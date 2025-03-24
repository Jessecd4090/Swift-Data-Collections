
import UIKit


//MARK: Protocol
protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}



    //MARK: Class Definition
class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    
    
    var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    var employeeType: EmployeeType?
    
    
    func employeeTypeTableViewController(_: EmployeeTypeTableViewController, didSelect: EmployeeType) {
        self.employeeType = didSelect
        employeeTypeLabel.text = employeeType?.description
        employeeTypeLabel.textColor = .black
        updateSaveButtonState()
    }
    

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    var isEditingBirthday = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    
    
    let dobLabelIndexPath = IndexPath(row: 1, section: 0)
    let dobIndexPath = IndexPath(row: 2, section: 0)
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    
    //MARK: IBActions
    @IBSegueAction func showEmployeeTypes(_ coder: NSCoder) -> EmployeeTypeTableViewController? {
        let employeeVC = EmployeeTypeTableViewController(coder: coder)
        employeeVC?.delegate = self
        return employeeVC
    }
    
    @IBAction func dobPickerValueChanged(_ sender: Any) {
        dobLabel.textColor = .label
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let employeeType = employee?.employeeType else { return }
        
        employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType)
        delegate?.employeeDetailTableViewController(self, didSave: employee!)
    }

    
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: Extra Functions
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        if employeeType != nil {
            let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
            saveBarButtonItem.isEnabled = shouldEnableSaveButton
        }
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desiredIndexPath = indexPath
        if desiredIndexPath == dobIndexPath && isEditingBirthday == false {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dobLabelIndexPath {
            isEditingBirthday.toggle()
            dobLabel.textColor = .label
            dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        }
    }

}
