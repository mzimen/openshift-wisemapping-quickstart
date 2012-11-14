openshift-wisemapping-quickstart
================================


You can either just clone this repo for openshift
or 
just hack your own version of wisemapping with steps below

Cloning for OpenShift
---------------------

1. Create an JBossEAP app named wisemapping
2. Embed with MySQL
3. Clone app into local directory
4. Add remote github source

<pre>
git remote add upstream -m master https://github.com/mzimen/openshift-wisemapping-quickstart.git
git pull -s recursive -X theirs upstream master
git push

</pre>

5. Wait and test

6. Temporary hack for mysql initialization (do after budiling)
   TODO: needs to be fixed soon

```bash
hack
cd $OPENSHIFT_REPO_DIR/src/main/config/mysql
mysql -u $OPENSHIFT_MYSQL_DB_USERNAME -p$OPENSHIFT_MYSQL_DB_PASSWORD $OPENSHIFT_APP_NAME < create-schemas.sql
```

Hacking for OpenShift
---------------------

1. Create an JBossEAP app named wisemapping
2. Embed with MySQL
3. Clone your app into local directory

```bash
git clone $SSH_URL_FROM_OPENSHIFT_CONSOLE
```

3. Download the zip file from http://www.wisemapping.org into /tmp/

4. Unzip the archive  into cloned directory

```bash
cd wisemapping/src/main/
unzip /tmp/wisemapping\*zip 
```

5. Hack the hierarchy in the current directory
  
```bash
mkdir webapp
mv webapps/wisemapping/*  webapp/
rm -rf webapps
```


6. Edit /src/main/webapp/WEB-INF/app.properties 
   (enable MySQL and disable HSQL)

    <pre>
    # MySQL 5.X configuration properties
    database.url=jdbc:mysql://OPENSHIFT_MYSQL_DB_HOST:OPENSHIFT_MYSQL_DB_PORT/wisemapping?useUnicode=yes&characterEncoding=UTF-8
    database.driver=com.mysql.jdbc.Driver
    database.hibernate.dialect=org.hibernate.dialect.MySQL5Dialect
    database.username=OPENSHIFT_MYSQL_DB_USERNAME
    database.password=OPENSHIFT_MYSQL_DB_PASSWORD
    database.validation.enabled=true
    database.validation.query=SELECT 1
    # HSQL Configuration properties
    #database.url=jdbc:hsqldb:file:webapps/wisemapping/WEB-INF/database/wisemapping
    #database.driver=org.hsqldb.jdbc.JDBCDriver
    #database.hibernate.dialect=org.hibernate.dialect.HSQLDialect
    #database.username=sa
    #database.password=
    #database.validation.enabled=false
    #database.validation.query=
    </pre>

7. Action hook for mysql config .openshift/action_hooks/pre_build 

```bash
sed -i -e "s/OPENSHIFT_MYSQL_DB_PORT/$OPENSHIFT_MYSQL_DB_PORT/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
sed -i -e "s/OPENSHIFT_MYSQL_DB_HOST/$OPENSHIFT_MYSQL_DB_HOST/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
sed -i -e "s/OPENSHIFT_MYSQL_DB_USERNAME/$OPENSHIFT_MYSQL_DB_USERNAME/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
sed -i -e "s/OPENSHIFT_MYSQL_DB_PASSWORD/$OPENSHIFT_MYSQL_DB_PASSWORD/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties

cd $OPENSHIFT_REPO_DIR/src/main/config/mysql/
mysql -u$OPENSHIFT_MYSQL_DB_USERNAME -p$OPENSHIFT_MYSQL_DB_PASSWORD wisemapping < create-schemas.sql
mysql -u$OPENSHIFT_MYSQL_DB_USERNAME -p$OPENSHIFT_MYSQL_DB_PASSWORD wisemapping < test-data.sql
```

8. Git  upload

```bash
cd wisemapping/
git add .
git commit -a -m  "initial commit"
git push
```

7. Wait for the app and do login

8. For troubleshooting try:

rhc tail wisemapping 

