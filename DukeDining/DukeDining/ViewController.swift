
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
        let jsonUrlString = "https://jsonplaceholder.typicode.com/todos"
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //also checck response status
            
            guard let data = data else {return}
            
            //let dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString)
            
            print("hello")
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                    else {
//                        print("what")
//                        return
//
//                    }
                guard let json = jsonResponse as? [[String:Any]] else{
                    print("rip")
                    return
                }
                print(json)
                let user = User(index: 0, jsonInit: json)
                print(user.title)
            } catch let jsonErr{
                print("error serializing json", jsonErr)
            }
        }.resume()
        
        
        //let myUser = User(userId: 1, id: 1, title: "Person", completed: true)
        //print(myUser)
        // Do any additional setup after loading the view.
    }


}

