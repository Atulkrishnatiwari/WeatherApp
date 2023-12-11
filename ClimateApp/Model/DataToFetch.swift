
import Foundation
struct DataToFetch
{
    let conditionInt:Int
    let descriptionOfForcast:String
    let cityName:String
    let temprature:Double
    
    var computedPropert:String
    {
        return String(format:"%.1f",temprature)
    }
    
    var getConditionName: String
    {
        switch conditionInt
        {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
