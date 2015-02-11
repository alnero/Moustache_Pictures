Moustache Pictures
==================

Servlet/JSTL + MySQL + Tomcat + Intellij Idea
---------------------------------------------
Building of web-app and deploying to Tomacat is performed in Intellij Idea. All required libraries included in project **lib** folder.

#### MySQL
SQL script for creating a database table is in **DBCreateScript.txt**

#### Tomcat
Add following inside `<Context>` tag to **context.xml** found in Tomcat\conf folder. Don't forget to paste your *username/password*
```xml
   <Resource name="jdbc/web_app" auth="Container" type="javax.sql.DataSource"
             maxActive="100" maxIdle="30" maxWait="10000"
             username="" password=""
             driverClassName="com.mysql.jdbc.Driver"
             url="jdbc:mysql://localhost:3306/web_app"/>
```

#### Intellij Idea
In order to have access to the image you upload add external directory e.g. **c:\UploadedImages** to Run/Debug Configurations and assign it to application context **/images**

![alt text](https://github.com/alnero/Moustache_Pictures/tree/master/web/Images/idea_conf.png "Intellij Idea - Run/Debug Configurations")

Fingers crossed, you will get the following:
--------------------------------------------
![alt text](https://github.com/alnero/Moustache_Pictures/tree/master/web/Images/gallery_example.png "Images are shown acc to rank")


![alt text](https://github.com/alnero/Moustache_Pictures/tree/master/web/Images/rating_example.png "Here you rate image")


![alt text](https://github.com/alnero/Moustache_Pictures/tree/master/web/Images/game_example.png "Guess a moustache")


![alt text](https://github.com/alnero/Moustache_Pictures/tree/master/web/Images/upload_example.png "Upload your images")