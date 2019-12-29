Marvel Chat is a simple app fetching a list of Marvel characters' avatars and names from a Marvel API in infinite scroll. You can have a basic chat with a character with pre-defined questions and answers. The chat log is saved locally.  

Technology stack:

- Realm
- Alamofire
- SwiftyJSON
- AlamofireImage

The app is structured in MVVM way. 

You need to obtain your private and public keys from and add them to apiKey.plist (see apiKey_example.plist):

	<key>publicKey</key>
	<string>**yourPublicKey**</string>
	<key>privateKey</key>
	<string>**yourPrivateKey**</string>
