docker build -t hendrima/multi-client -f ./client/Dockerfile ./client
docker build -t hendrima/multi-server -f ./server/Dockerfile ./server
docker build -t hendrima/multi-worker -f ./worker/Dockerfile ./worker
dokcer push hendrima/multi-client
dokcer push hendrima/multi-server
dokcer push hendrima/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hendrima/multi-server

