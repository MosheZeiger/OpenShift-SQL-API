
SET PROJECT_NAME=moshez-1-dev
SET DOCKERHUB_USERNAME=moshezeiger
SET IMAGE_NAME=%DOCKERHUB_USERNAME%/data-loader:latest


oc delete project %PROJECT_NAME% --ignore-not-found=true
oc new-project %PROJECT_NAME%
oc project %PROJECT_NAME%

docker build -t moshezeiger/data-loader:latest ..
docker login -u moshezeiger
dckr_pat_GG4OFtmeWOhwAC7F0MughU-nawI

docker push moshezeiger/data-loader:latest


oc apply -f ../infrastructure/k8s/1_mysql-pvc.yaml
oc apply -f ../infrastructure/k8s/2_mysql-secret.yaml
oc apply -f ../infrastructure/k8s/3_mysql-deployment.yaml
oc apply -f ../infrastructure/k8s/4_mysql-service.yaml
oc apply -f ../infrastructure/k8s/5_backend-deployment.yaml
oc apply -f ../infrastructure/k8s/6_backend-service.yaml
oc apply -f ../infrastructure/k8s/7_backend-route.yaml



set MYSQL_POD=oc get pods -l app=mysql -o 'jsonpath={.items[0].metadata.name}'
for /f %%i in ('oc get pods -l app=mysql -o=jsonpath="{.items[0].metadata.name}"') do set MYSQL_POD=%%i


oc cp create_data.sql mysql-6d4874d999-mmzm8:/tmp/
oc cp insert_data.sql mysql-6d4874d999-mmzm8:/tmp/


for /f %%i in ('oc get secret mysql-secret -o jsonpath="{.data.MYSQL_USER}" ^| base64 --decode') do set DB_USER=%%i
for /f %%i in ('oc get secret mysql-secret -o jsonpath="{.data.MYSQL_PASSWORD}" ^| base64 --decode') do set DB_PASSWORD=%%i
for /f %%i in ('oc get secret mysql-secret -o jsonpath="{.data.MYSQL_DATABASE}" ^| base64 --decode') do set DB_NAME=%%i

oc rsh mysql-6d4874d999-mmzm8 mysql -u appuser -p very_strong_user_password appdb -e "source /tmp/create_data.sql;"
oc rsh mysql-6d4874d999-mmzm8 mysql -u appuser -p very_strong_user_password appdb -e "source /tmp/insert_data.sql;"


for /f %%i in ('oc get route data-loader-route -o jsonpath="{.spec.host}"') do set ROUTE_URL=%%i
echo "Access the service at: http://%ROUTE_URL%/data"