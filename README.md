openshift-wisemapping-quickstart
================================


Hacking for OpenShift
---------------------

1. Create an JBossEAP app named wisemapping
2. Embed with MySQL
3. Clone your app into local directory

  git clone $SSH\_URL\_FROM\_OPENSHIFT\_CONSOLE

3. Download the zip file from http://www.wisemapping.org into /tmp/

4. Unzip the archive  into cloned directory

  cd wisemapping/src/main/
  unzip /tmp/wisemapping\*zip 

5. Hack the hierarchy in the current directory
  
   > mkdir webapp
   > mv webapps/wisemapping/\* webapp
   > rm -rf webapps


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

7. Action hook for mysql config : .openshift/action\_hooks/pre\_build 

    <pre>
    sed -i -e "s/OPENSHIFT_MYSQL_DB_PORT/$OPENSHIFT_MYSQL_DB_PORT/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
    sed -i -e "s/OPENSHIFT_MYSQL_DB_HOST/$OPENSHIFT_MYSQL_DB_HOST/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
    sed -i -e "s/OPENSHIFT_MYSQL_DB_USERNAME/$OPENSHIFT_MYSQL_DB_USERNAME/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
    sed -i -e "s/OPENSHIFT_MYSQL_DB_PASSWORD/$OPENSHIFT_MYSQL_DB_PASSWORD/" $OPENSHIFT_REPO_DIR/src/main/webapp/WEB-INF/app.properties
    
    cd $OPENSHIFT_REPO_DIR/src/main/config/mysql/
    mysql -u$OPENSHIFT_MYSQL_DB_USERNAME -p$OPENSHIFT_MYSQL_DB_PASSWORD < create-schemas.sql
    mysql -u$OPENSHIFT_MYSQL_DB_USERNAME -p$OPENSHIFT_MYSQL_DB_PASSWORD < test-data.sql
    </pre>


8. git 

   git add .
   git commit -m  "initial commit"
   git push

7. wait for the app and do login

