# numbersandcalcs

numbersandcalcs.b4a.app


# deploy

cd ~/myapp/numbersandcalcs && flutter build web && cd ./b4a/numbersandcalcs && b4a deploy


Finished uploading files
New release is named v1 (using Parse JavaScript SDK v2.2.25)
catalunha@pop-os:~/myapp/numbersandcalcs/b4a/numbersandcalcs$


# icon generator
https://appicon.co/

# publicando
https://dhruvnakum.xyz/how-to-publish-flutter-app-on-play-store
https://medium.flutterdevs.com/publishing-flutter-app-to-playstore-fa7543b61a7b
https://docs.flutter.dev/deployment/android
https://dhruvnakum.xyz/how-to-publish-flutter-app-on-play-store
## keystore
catalunha@pop-os:~/myapp/numbersandcalcs$ keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
Enter keystore password:  android
Re-enter new password: android
What is your first and last name?
  [Unknown]:  brintec org
What is the name of your organizational unit?
  [Unknown]:  brintec
What is the name of your organization?
  [Unknown]:  brintec
What is the name of your City or Locality?
  [Unknown]:  palmas
What is the name of your State or Province?
  [Unknown]:  to
What is the two-letter country code for this unit?
  [Unknown]:  br
Is CN=brintec org, OU=brintec, O=brintec, L=palmas, ST=to, C=br correct?
  [no]:  yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
        for: CN=brintec org, OU=brintec, O=brintec, L=palmas, ST=to, C=br
[Storing /home/catalunha/key.jks]

copiei para ./Keystore/key.jks

## termos de uso e privacidade
Conta brintec.education folder https://drive.google.com/drive/folders/1Lhe7IUNbng4zKdyGJnM6GS6Rj_ACoBFu
pagina em
docs/privacy-policy
docs/terms-of-use

enviando ao servidor

cd ~/myapp/marketplace01/aws
ssh -i keyparwebhook.pem ubuntu@44.197.92.210

?$ cd ~/myapp/marketplace01/aws

catalunha@pop-os:~/myapp/marketplace01/aws$ scp -r -i keyparwebhook.pem /home/catalunha/myapp/numbersandcalcs/docs/privacy-policy/* ubuntu@44.197.92.210:/opt/nginx-ssl/webserver/public_html/numbersandcalcs.brintec.org/privacy-policy

catalunha@pop-os:~/myapp/marketplace01/aws$ scp -r -i keyparwebhook.pem /home/catalunha/myapp/numbersandcalcs/docs/terms-of-use/* ubuntu@44.197.92.210:/opt/nginx-ssl/webserver/public_html/numbersandcalcs.brintec.org/terms-of-use

catalunha@pop-os:~/myapp/marketplace01/aws$ scp -r -i keyparwebhook.pem /home/catalunha/myapp/numbersandcalcs/build/web/* ubuntu@44.197.92.210:/opt/nginx-ssl/webserver/public_html/numbersandcalcs.brintec.org

# Mudar versão em

android/app/build.gradle

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '2'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0.1'
}

e em
pubspec.yaml
version: 1.0.1

catalunha@pop-os:~/myapp/numbersandcalcs$ flutter clean
catalunha@pop-os:~/myapp/numbersandcalcs$ flutter build web

catalunha@pop-os:~/myapp/numbersandcalcs$ flutter build appbundle