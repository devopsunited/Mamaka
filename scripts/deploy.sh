#!bin/sh

echo $GCLOUD_SERVICE_KEY 
echo $GCLOUD_SERVICE_KEY | base64 --decode --ignore-garbage > key_file.json
gcloud auth activate-service-account --key-file=key_file.json
gcloud config set core/project $GOOGLE_PROJECT_ID 
gcloud config set compute/zone $GOOGLE_COMPUTE_ZONE
EXISTING_CLUSTER=$(gcloud container clusters list --format="value(name)" --filter="name=$GOOGLE_CLUSTER_NAME")

TEST="TOTO"
echo $TEST
echo $EXISTING_CLUSTER
echo salut max

if [ "${EXISTING_CLUSTER}" != $GOOGLE_CLUSTER_NAME ] ;then 

   gcloud container clusters create $GOOGLE_CLUSTER_NAME

else
    echo "cluster is present d"
fi

