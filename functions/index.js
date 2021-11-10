const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

const fcm = admin.messaging();

exports.senddevices = functions.firestore
  .document("Notification/{id}")
  .onCreate((snapshot) => {
    const title = snapshot.get("Title");
    const content = snapshot.get("Content");

    const topic = "cdcc";
    const payload = {
      notification: {
        title: title,
        body: content,
        sound: "default",
      },
    };

    return fcm.sendToTopic(topic, payload);
  });
