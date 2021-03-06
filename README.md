Marvel Chat is a simple app fetching a list of Marvel characters' avatars and names from a Marvel API in infinite scroll. You can have a basic chat with a character with pre-defined questions and answers. The chat log is saved locally.  

Technology stack:

- Realm
- Alamofire
- SwiftyJSON
- AlamofireImage

The app is designed in MVVM way. 

You need to obtain your private and public keys from: 
https://developer.marvel.com/docs 

Rename apiKey_example.plist to apiKey.plist and add your keys:

	<key>publicKey</key>
	<string>yourPublicKey</string>
	<key>privateKey</key>
	<string>yourPrivateKey</string>

![Alt text](https://user-images.githubusercontent.com/47685603/71552959-e2cf6800-2a38-11ea-81ac-be874c66ade4.png "")	
![Alt text](https://user-images.githubusercontent.com/47685603/71552944-9421ce00-2a38-11ea-8e01-250fc00a7e88.png "")
