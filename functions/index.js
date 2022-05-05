
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios");
// let unirest = require('unirest');


const parse = require("./parse");

admin.initializeApp();

exports.lmno_callback_url = functions.https.onRequest(async (req, res) => {
    const callbackData = req.body.Body.stkCallback;
    const parsedData = parse(callbackData);

    let uid = req.query.uid.split("/")[0];
   let amount = req.query.uid.split("/")[1];
   
    

    let lmnoResponse = admin.firestore().collection('transactions').doc('deposit').collection(uid).doc('/' + parsedData.checkoutRequestID + '/');
    let transaction = admin.firestore().collection('transactions').doc('deposit').collection(uid).doc('/' + parsedData.checkoutRequestID + '/');
    let wallets = admin.firestore().collection('users');

   
    // let walletId = await transaction.get().then(value => value.data().toUserId);
    let adminWallet = await admin.firestore().collection('admin').doc('mainAccount').get();

    // let wallet = wallets.doc('/' + walletId + '/');
    let wallet = wallets.doc(uid);
    console.log('TYPE OF AMOUNT: ' + typeof parsedData.amount);
    if ((await lmnoResponse.get()).exists){
    
}else {
    if ((typeof parsedData.amount) === (typeof 1)) {
    
   
        
        let balance = await wallet.get().then(value => value.data().balance);
        await wallet.update({
            'balance': parsedData.amount + balance
        });
        console.log(parsedData.amount);
    
    let adminBalance = await adminWallet.get().then(value => value.data().balance);
    let depositBalance = await adminWallet.get().then(value => value.data().depositAmount);
    
    await adminWallet.update({
        'balance': adminBalance + parsedData.amount,
        'depositAmount': depositBalance + parsedData.amount,
    })
}

    }
    

    
await admin.firestore().collection('transactions').doc('all').collection('users').doc().set({
    'amount': amount,
    'type': 'deposit',
    'userId': uid,
    'phoneNumber': parsedData.phoneNumber,
'date': parsedData.transactionDate,
});

    
    
  if ((await lmnoResponse.get()).exists) {
    await lmnoResponse.update(parsedData);
} else {
    await lmnoResponse.set(parsedData);
} 

    await transaction.set({
    
        'type': 'deposit',
        'amount': amount,
        'confirmed': true
    
    });



res.status(200).send('OK');

});

exports.sendPayment = functions.firestore.document('completeMatches/{gameId}').onUpdate(async (change, context) => {
    const doc = change.after.data();

    let user = admin.firestore().collection('users').doc(doc.winner);
    // const increment = functions.firestore.FieldValue.increment(parseFloat(doc.amount.toString())*0.75);
    
   let increment=await user.get().then(value => {
value.data().balance += parseFloat(doc.amount.toString())*0.75; 
     });



    await user.update({
        'balance': increment
    });

    return 'OK';

 });




// exports.b2c = functions.https.onRequest(async (req, res) => { 


//     let uid = req.query.uid.split("/")[0];
//     let amount = req.query.uid.split("/")[1];


//     let wallet = admin.firestore().collection('users').doc(uid);
    
//    let balance=await wallet.get().then(value => value.data().balance 
    
//    );
    
//     wallet.update({
//         'balance': balance - parseFloat(amount.toString()),
//     });
//     console.log(res);

//     res.status(200).send('OK');
// });



//get access token.
exports.b2c = functions.https.onRequest(async (req, res) => {
    // get data from headers by destructuring
    const consumerkey = CONSUMER_KEY;
    const consumersecret = CONSUMER_SECRET;
    // request ur
    var url = "https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
    
    console.log(req.query);
    console.log(req.query.uid);    


        let uid = req.query.uid.split("/")[0];
   let amount = req.query.uid.split("/")[1];
   let number = req.query.uid.split("/")[2];
    console.log(amount);
    console.log(uid);
    console.log(number);

    // get a base64 encoded string from a buffer
    let buf = new Buffer.from(`${consumerkey}:${consumersecret}`).toString("base64");
    // authentication string
    var auth = `Basic ${buf}`;
    var response;

    try {

        // send a GET request to the URL
        response = await axios.default.get(url,{
            headers:{
                "Authorization":auth
            }
        });

    } catch (error) {

        // in case of an error, get the code and error message
        let err_code = error.response.status;
        let err_msg = error.response.statusText;

        // send response to client
        return res.status(err_code).send({
            message:err_msg
        });

    }

    // get the access token from server response
    let accessToken  = response.data.access_token;

  
    
        let url1 = "https://api.safaricom.co.ke/mpesa/b2c/v1/paymentrequest";
        // url to expose our local server
        let ngrok_url = 'https://example.com/';
        // authentication string
        let auth1 = `Bearer ${accessToken}`;
        let response1;
 
    
        
    try {
        
        
            // send the request
            response1 = await axios.default.post(url1,{
            "InitiatorName": INITIATOR_NAME,
            "SecurityCredential": SECURITY_CREDENTIAL,
            "CommandID": 'BusinessPayment',
            "Amount": parseFloat(amount.toString()),
            "PartyA": '3031707',
            "PartyB": number,
            "Remarks": 'Salary',
            "QueueTimeOutURL": ngrok_url,
            "ResultURL": ngrok_url,
            "Occasion": 'Salary'
            },{
                headers:{
                    "Authorization":auth1
                }
            })
        
        }catch(error) {
        
            // in case of an error, get the code and the message.
            let err_code = error.response.status;
            let err_msg = error.response.data.errorMessage;
        
            // send to the client
            return res.status(err_code).send({
                message:err_msg
            });
        }

    
    
    
    
    
        let wallet = admin.firestore().collection('users').doc(uid);
    
    
        let balance = await wallet.get().then(value => value.data().balance);
        await wallet.update({
            'balance': balance-parseFloat(amount.toString())
        });
    
        await admin.firestore().collection('transactions').doc('all').collection('users').doc().set({
            'amount': amount,
            'type': 'withdrawal',
            'userId': uid,
            'phoneNumber': number,
        'date': Date.now(),
        });
        
        // set the status code
        res.status(200);
        
        // send to the client
        return res.send({
            result:response1.data
        });
        
});





 
exports.sendNotification = functions.firestore
  .document('userData/notifications/{userId}/{notification}')
  .onCreate(async (snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.sender
    const idTo = doc.to
    const contentMessage = doc.message


    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('userId', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log(`Found user to: ${userTo.data().fullName}`)
         
          // Get info user from (sent)
          admin
            .firestore()
            .collection('users')
            .where('userId', '==', idFrom)
            .get()
            .then(querySnapshot2 => {
              querySnapshot2.forEach(userFrom => {
                console.log(`${userFrom.data().fullName}`)
                const payload = {

                  notification: {
                    id:'/chat-screen',
                    title: `${userFrom.data().fullName}`,
                    body: contentMessage,
                    badge: '1',
                    sound: 'default'
                  },
                  data: {
                    profilePic: userFrom.data().profilePic,
                    
                  }
                }
                // Let push to the target device
                admin
                  .messaging()
                  .sendToDevice(userTo.data().pushToken, payload)
                  .then(response => {
                    console.log('Successfully sent message:', response)
                  })
                  .catch(error => {
                    console.log('Error sending message:', error)
                  })
              })
            })
        })
        
        
      })
    return null
  })

// exports.updateTimers = functions.pubsub.schedule('every 15 minutes')
//   .timeZone('Africa/Nairobi') 
//   .onRun(async (context) => {
//       console.log('This will be run every after 1 min!');
//       let userData =await admin.firestore().collection('users').get();
//       userData.forEach(async(user) => {
//           let balance = user.data().balance;
//           let dailyIncome = user.data().dailyIncome;

//           await admin.firestore().collection('users').doc(user.id)
//        .update({
//               'balance': balance + dailyIncome
//           });
//       });

      

//   return 'Data sent';
// });