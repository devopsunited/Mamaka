#!bin/sh

echo $GCLOUD_SERVICE_KEY 
echo $GCLOUD_SERVICE_KEY | base64 --decode --ignore-garbage > key_file.json
gcloud auth activate-service-account --key-file=key_file.json
gcloud config set core/project $GOOGLE_PROJECT_ID 
gcloud config set compute/zone $GOOGLE_COMPUTE_ZONE
CLUSTER_EXIST = gcloud container cluster list $(gcloud container clusters list --format="value(name)" --filter="name=$GOOGLE_CLUSTER_NAME")
TEST="TOTO"
echo $TEST
echo $GOOGLE_CLUSTER_NAME
echo "cluster exist ? ${CLUSTER_EXIST}"
if [ "${CLUSTER_EXIST}" != $GOOGLE_CLUSTER_NAME ] ;then 
    
   gcloud container clusters create hellocluster

else
    echo "cluster is present or condition not exist failed"
fi

