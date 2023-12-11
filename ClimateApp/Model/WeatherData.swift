

import Foundation
/*typealias combines two protocol such as codable typealias is acombinations of
Decodable & Encodable protocols we are using codable here as decodable and encodable*/
struct WeatherData:Codable
{
    let name:String
    let main:Main
    
    let weather:[Weather]
}
struct Main:Codable
{
    let temp:Double
}
struct Weather:Codable
{
    let description:String
    let id:Int
}
