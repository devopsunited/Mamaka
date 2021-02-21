

cd k8s
          echo $GCLOUD_SERVICE_KEY | base64 --decode --ignore-garbage > gcloud-service-key.json
          set -x
          gcloud auth activate-service-account --key-file gcloud-service-key.json
          gcloud --quiet config set project $GOOGLE_PROJECT_ID
          gcloud --quiet config set compute/zone $GOOGLE_COMPUTE_ZONE
          EXISTING_CLUSTER=$(gcloud container clusters list --format="value(name)" --filter="name=$GOOGLE_CLUSTER_NAME")
            if [ "${EXISTING_CLUSTER}" != $GOOGLE_CLUSTER_NAME ]
            then
              # Create cluster if it doesn't already exist
              gcloud --quiet container clusters create $GOOGLE_CLUSTER_NAME --num-nodes=1
              kubectl apply -f ./k8s-mamaka-depl.yaml && kubectl apply -f ./k8s-mamaka-lb-service.yaml
            else
              gcloud --quiet container clusters get-credentials $GOOGLE_CLUSTER_NAME
              kubectl rollout restart deployment mamaka-depl
            fi
          kubectl get pods