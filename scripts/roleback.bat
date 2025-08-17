oc delete pvc mysql-pvc --ignore-not-found
oc delete secret mysql-secret --ignore-not-found
oc delete deployment mysql --ignore-not-found
oc delete service mysql --ignore-not-found
oc delete deployment data-loader-backend --ignore-not-found
oc delete service data-loader-service --ignore-not-found
oc delete route data-loader-route --ignore-not-found
