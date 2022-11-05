import Foundation

struct Movie : Codable {
	let rating : Double?
	let id : Int?
	let revenue : Int?
	let releaseDate : String?
	let director : Director?
	let posterUrl : String?
	let cast : [Cast]?
	let runtime : Int?
	let title : String?
	let overview : String?
	let reviews : Int?
	let budget : Int?
	let language : String?
	let genres : [String]?
}
