# Setup

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Navigate to the BlazorInteractiveServerAspNet folder, execute a powershell and run `docker compose up`

   This will create a MySql database on localhost:3306 already containing the AspNet tables.
   The Username is `root` the password is `mysqlpassword`
3. Now you can run the application
4. As initially there is no user in the user tables you need to create one with the `CREATE USER` button
5. then u can log in via `LOGIN` button (will not work)

If you take a look in the developer tools console there will be an error saying 

```
Error: System.InvalidOperationException: Headers are read-only, response has already started.
```
