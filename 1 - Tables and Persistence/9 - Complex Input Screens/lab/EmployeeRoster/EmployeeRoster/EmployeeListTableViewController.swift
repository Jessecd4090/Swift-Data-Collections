
import UIKit

class EmployeeListTableViewController: UITableViewController, EmployeeDetailTableViewControllerDelegate {
    
    var employees: [Employee] = [Employee(name: "Jestin", dateOfBirth: Date(), employeeType: .partTime)]
    
    // MARK: - Delegate
    
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            employees.remove(at: indexPath.row)
            employees.insert(employee, at: indexPath.row)
        } else {
            employees.append(employee)
        }
        
        tableView.reloadData()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Tableview DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        let employee = employees[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = employee.name
        content.secondaryText = employee.employeeType.description
        cell.contentConfiguration = content
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            employees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    @IBSegueAction func showEmployeeDetail(_ coder: NSCoder, sender: Any?) -> EmployeeDetailTableViewController? {
        
        let detailViewController = EmployeeDetailTableViewController(coder: coder)
        detailViewController?.delegate = self
        
        guard
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
        else {
            return detailViewController
        }
        
        let employee = employees[indexPath.row]
        detailViewController?.employee = employee
        
        return detailViewController
    }
}

