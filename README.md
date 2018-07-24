# Spider
The spider app extracts content from a given app (Headers and Links).

# Installation

1. Clone this repository.
2. `bundle install` and `rails db:setup` it.
3. `rails s`

# Usage
The application will crawl every site (called a record internally) it's given.
To create a new record post it to the `/records` endpoint. It should include a
url within the attributes. It follows JSONAPI conventions so it looks like this:

```
POST /records

data: {
	type: 'Records'
	attributes: {
    	url: 'http://martianwabbit.com/2018/05/25/testing-oclif-with-jest.html'
	}
}
```

Make sure the `Accept` header is set to be `application/vnd.api+json`.

If everything went right you should get some like this back:

```
POST http://localhost:3000/records
201 Created

Response Headers:
{
	"cache-control": "max-age=0, private, must-revalidate",
	"connection": "close",
	"content-type": "application/vnd.api+json",
	"etag": "W/\"33b25e2b75963801774e475e4029bc69\"",
	"transfer-encoding": "chunked",
	"x-request-id": "b1b8c96e-bebe-4033-b827-1208651680ba",
	"x-runtime": "0.085965"
}

Response Body:
{
	"data": {
		"attributes": {
			"crawled": false,
			"url": "http://martianwabbit.com/2018/05/25/testing-oclif-with-jest.html"
		},
		"id": "3",
		"links": {
			"self": "http://localhost:3000/records/3"
		},
		"relationships": {
			"headers": {
				"links": {
					"related": "http://localhost:3000/records/3/headers",
					"self": "http://localhost:3000/records/3/relationships/headers"
				}
			},
			"links": {
				"links": {
					"related": "http://localhost:3000/records/3/links",
					"self": "http://localhost:3000/records/3/relationships/links"
				}
			}
		},
		"type": "records"
	}
}
```

This means the site you submitted has been added to the queue. As you can see
there's a crawled value within the site's record, it's set to `false` right now
but it'll be switched over to `true` once the job is done crawling it.

You can get all records by requesting `GET /records`. You can also check the
state and fetch details for one in particular by requesting `GET /records/id`.
