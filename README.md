# IReport

iReport is an application that enables any/every citizen to bring any form of corruption to the notice of appropriate authorities and the general public. Users can also report on things that needs government intervention

### Features Endpoints:

| Method | Route | Endpoint Functionality |
| :---         |     :---       |          :--- |
| POST   | /signup     | Creates a user account    |
| POST   | /login     | Logs in a user into their account    |
| PATCH    | /user/:id       | Edit a user record    |
| GET     | /reports        | Gets all records     |
| GET     | /user/reports/:id      |Gets records of a particular user    |
| POST    | /reports       | Enable user to add a new record      |
| PATCH     | /reports/:id       | Enable user to edit a record     |
| PATCH     | /reports/status/:id    | Enable user to edit status of a record     |    |

### Installation Procedure

clone the repo

``` 
git clone https://github.com/annomao/ireport-api.git

```

install project dependencies:

```
run bundle install 

```
### Running

Running the application
```
bundle exec rackup config.ru

```
Test the endpoints using Postman 
