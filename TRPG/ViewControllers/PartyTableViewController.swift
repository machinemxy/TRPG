//
//  PartyTableViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/10.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit
import SwiftUI

class PartyTableViewController: UITableViewController {
    @IBOutlet weak var lblMoney: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMoney.text = "Money: \(Party.instance.money)"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Party.instance.pcs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partyCell", for: indexPath)

        let pc = Party.instance.pcs[indexPath.row]
        cell.textLabel?.text = pc.name
        cell.detailTextLabel?.text = "HP: \(pc.hp)/\(pc.mhp)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPc = Party.instance.pcs[indexPath.row]
        let pcHostingController = UIHostingController(rootView: PcView(pc: selectedPc))
        navigationController?.pushViewController(pcHostingController, animated: true)
    }
}
