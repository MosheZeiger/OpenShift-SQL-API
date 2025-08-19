
cd /d "C:\Analiza\Kodkod_2025\Projects\OpenShift-SQL-API\scripts"


SET PROJECT_NAME=moshez-1-dev
SET DOCKERHUB_USERNAME=moshezeiger
SET IMAGE_NAME=%DOCKERHUB_USERNAME%/data-loader:1.4

oc delete project %PROJECT_NAME% --ignore-not-found=true
oc new-project %PROJECT_NAME%
oc project %PROJECT_NAME%


docker build -t %IMAGE_NAME% ..
docker push %IMAGE_NAME%

oc apply -f ../infrastructure/k8s/1_mysql-secret.yaml
oc apply -f ../infrastructure/k8s/2_mysql-pvc.yaml
oc apply -f ../infrastructure/k8s/3_mysql-deployment.yaml
oc apply -f ../infrastructure/k8s/4_mysql-service.yaml
oc apply -f ../infrastructure/k8s/5_backend-deployment.yaml
oc apply -f ../infrastructure/k8s/6_backend-service.yaml
oc apply -f ../infrastructure/k8s/7_backend-route.yaml


oc get pods -l app=mysql -o name

set MYSQL_POD=mysql-6d4874d999-m8l84

echo MySQL Pod Name: %MYSQL_POD% 


oc cp create_data.sql %MYSQL_POD%:/tmp/
oc cp insert_data.sql %MYSQL_POD%:/tmp/


oc exec -i %MYSQL_POD% -- /bin/bash -c "mysql -u root -p$MYSQL_ROOT_PASSWORD appdb -e 'source /tmp/create_data.sql'"
oc exec -i %MYSQL_POD% -- /bin/bash -c "mysql -u root -p$MYSQL_ROOT_PASSWORD appdb -e 'source /tmp/insert_data.sql'"

oc get route data-loader-route

@REM 7.2: Display the final URL.
@REM =================================================================
@REM --- DEPLOYMENT COMPLETE! ---
@REM Access the service at: http://%ROUTE_URL%/data
@REM =================================================================