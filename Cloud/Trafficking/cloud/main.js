var slack = require('cloud/slack.js');

Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.afterSave("Reported", function(request) {
	// if (!request.object.existed()) {
		var user = Parse.User.current();
		// var car = request.object.get('car');
		// car.fetch({
		// 	success: function(car) {
		// 		emailSender.sendEmailToClientWhenNewServiceRequestPosted(user.get('email'), user.get('name'), car.get('year') + ' ' + car.get('make') + ' ' + car.get('model'));
		// 	}
		// });
		slack.postNotificationToSlack("New report submitted by " + user.getUsername(), request.object);
	// }
});