
import UIKit


struct User{
    let userId : Int
    let id: Int
    let title: String
    let completed: Bool?
    
    
    
    init(index:Int,jsonInit: [[String:Any]]){
        
        if let json2 = jsonInit[index] as? [String:Any]{
            userId = json2["userId"] as? Int ?? -1
            id = json2["id"] as? Int ?? -1
            title = json2["title"] as? String ?? ""
            completed = json2["completed"] as? Bool? ?? nil

        }
        else{
            userId = -1
            id = -1
            title = ""
            completed = nil
        }
        
    }
}
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello?")
        
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else{return}
            do {
                let data = try Data(contentsOf: url)
                
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let json = jsonResponse as? [String:[String:[[String:Any]]]] else{
                    print("rip")
                    return
                }
                //print(json)
                
                //let user = User(index: 0, jsonInit: json)
                //print(user.title)
                
                
                guard let dayDict = json["October"]!["2"] else{
                    print("bad")
                    return
                }
                for dict in dayDict{
                    print(dict["Location"]!)
                }
                //print(json["October"]!["2"])
            } catch {
                print("error:\(error)")
            }
       
        
        
        //let myUser = User(userId: 1, id: 1, title: "Person", completed: true)
        //print(myUser)
        // Do any additional setup after loading the view.
    }
    /*
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }*/



}

