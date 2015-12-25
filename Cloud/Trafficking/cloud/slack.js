exports.postNotificationToSlack = function(message, parseObject) {
	var slackURL;
	var appName
	if (Parse.applicationId == 'No8pkeg26XXKrFK4mAI5HUCN5qXAXa1hOrxjGk6c') {
		//Development version of parse app
		slackURL = 'https://hooks.slack.com/services/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'
		appName = 'Trafficking-dev'
	} else if (Parse.applicationId == '') {
		//Production version of parse app
		slackURL = 'https://hooks.slack.com/services/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'
		appName = 'repairshift'
	} else {
		//unknown app name
		slackURL = ''
		appName = ''
	}
	var readableLink
	var title
	if (parseObject) {
		title = 'ObjectID #' + parseObject.id;
		readableLink = '<https://www.parse.com/apps/' + appName +'/collections#class/' + parseObject.className + '/objectId/' + parseObject.id + '|View on Parse>';
	}
	Parse.Cloud.httpRequest({
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		url: slackURL,
		body: {
			// "text": message,
			'attachments': [
				{
					'fallback': message,
					'pretext': message,
					'title': title,
					'text': readableLink,
					'color': '#7CD197'
				}
			],
			'username': 'Parse.com (Trafficking)',
			'icon_url': 'https://pbs.twimg.com/profile_images/554058755520749568/byqeQxFa.png'
		},
		success: function(httpResponse) {
		},
		error: function(httpResponse) {
		}
	});
};