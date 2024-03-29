# Ecommerce API

- npm run build

## Follow steps below

- Clone this repository

### Setup environment variables

- Create a .env file in the root of your project with the following variables

```
DATABASE=<connection-string-to-your-mongodb-database>

TEST_DATABASE=<connection-string-to-your-mongodb-testdatabase>

JWT_SECRET=<secret>
JWT_EXPIRY_TIME=

```
- API includes sending emails using nodemailer and gmail

- Enable [less secure app access](https://myaccount.google.com/lesssecureapps) for this to work

- You may also need to [enable the secure access capture](https://accounts.google.com/b/0/displayunlockcaptcha)

```
EMAIL_PORT=
EMAIL_AUTH_USERNAME=
EMAIL_AUTH_PASSWORD=
EMAIL_FROM=
```

- The api uploads images to cloudinary. [Create an account](https://cloudinary.com/) and pick configuration from the dashboard to fill below
```
CLOUD_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=
```

- To facilitate facebook and google auth

Get [Facebook app id and secret](https://developers.facebook.com/apps/364856984821018/settings/basic/)

```
FACEBOOK_APP_ID=
FACEBOOK_APP_SECRET=
```

- Get [Google client id and secret](https://console.cloud.google.com/apis/credentials).  get the credentialsYou'll need to create an app then

```
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
```

- Used to run on localhost else change it to point to your host

- Used by Oauth strategies to redirect back to the api

```
BASE_URL=http://localhost:3000/ 

    OR 

BASE_URL=https://api.herokuapp.com/

```

- The api supports paypal payment using braintree by receiving a ```nonce``` from a client.

- Go to [braintree developer home page](https://sandbox.braintreegateway.com/merchants/x4r6zcxfjwygzdph/home) and get details below.

- You'll be prompted to create an account if you don't have one. The same applies to any site mentioned above.

```
BRAINTREE_MERCHANT_ID=
BRAINTREE_PUBLIC_KEY=
BRAINTREE_PRIVATE_KEY=
```

## Run the API

- Execute ```npm run start:dev``` to run in development

- Execute ```npm run start:prod:local ``` to run a local production build. It performs a deletion of ```dist``` folder, creates a new one
and starts the server

- Note that ``` npm start ``` alone will not work locally unless you run ```npm run build``` first. However, it will work on heroku. Heroku takes care of running ```npm run build``` and ```npm start``` on it's own. I created them separately that purpose and also that heroku will fail anything attempt to delete folders or files.

- Execute ``` npm test ``` to run the automated tests

## Features

- Sign in and sign up using email,password, google and facebook
- Send mail on successfull sign up
- Route protection and restriction according to role and login status
- Forgot and reset password
- Add product image - upload to [cloudinary](https://cloudinary.com/)
- Update user email and name
- Add,remove,modify delete and fetch products (Random selection on every API request)
- Process paypal payment using nonce from client and save order
- Receive order from client and save e.g if client used [stripe_payment flutter](https://pub.dev/packages/stripe_payment/example) to
  process payment from frontend and return order details on successfull payment
  An example is [my ecommerce flutter client](https://github.com/KNehe/Ecommerce_app/tree/develop) which performs stripe payment and sends order after success. It also carries out paypal payment by sending a nonce to this api to process it
- Retrieve orders
- Add,remove, and fetch categories
- Search by product name, and name or category
- Add ,remove, and fetch user's cart
- General error hanlding

