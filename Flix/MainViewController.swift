//
//  MainViewController.swift
//  Flix
//
//  Created by Kelvin Lui on 2/4/18.
//  Copyright © 2018 Kelvin Lui. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var movieTimeTableView: UITableView!
    @IBOutlet weak var movieTimeCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Movies"
        movieTimeTableView.rowHeight = 40
        movieTimeTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTimeCell", for: indexPath) as! MovieTimeCell
        
        switch(indexPath.row) {
        case 0:
            cell.movieTimeLabel.text = "Current"
        case 1:
            cell.movieTimeLabel.text = "Upcoming"
        default:
            print("error here")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0:
            self.performSegue(withIdentifier: "nowPlayingViewController", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "upcomingViewController", sender: nil)
        default:
            print("error here")
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 

}
