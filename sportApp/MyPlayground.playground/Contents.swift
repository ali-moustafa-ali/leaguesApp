import UIKit
let sportType = "football"

let baseURL = "https://apiv2.allsportsapi.com"
let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
let metParam = "Fixtures"
let date = "&from=2021-05-18&to=2021-05-18"
let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)\(date)"

print(urlString)
