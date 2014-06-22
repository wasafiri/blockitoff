# bloccitoff
## a task management system

This branch adds support for interacting with blockitoff via xml/json.

To test via command-line:

# login
```
curl -H "Content-Type: application/json" -d '{"email":"emailhere","password":"passhere"}' \
        -X POST http://localhost:3000/user/sign_in
```
or to use a cookie:
```
curl -H "Content-Type: application/json" -d '{"email":"dbahar@gwu.edu","password":"testtest"}' \
        -X POST http://localhost:3000/users/sign_in -c cookie
```
# access stuff

example -->

we want to get lists index.
routes.rb:
```
lists GET    /lists(.:format)                           lists#index
```

tells us we need to do 'get' for index.
```
curl -X GET http://localhost:3000/lists.json
```
with token & email ( both are required )
```
curl -X GET http://localhost:3000/lists.json -H "X-Api-Token: r6VCfFN7cs9biwXq1Zq8sS4ZFX_8VF-x-Q, X-API-EMAIL: dbahar@gwu.edu"
```
For posting data:
```
curl --data "param1=value1&param2=value2" http://hostname/resource
```