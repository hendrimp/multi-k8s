docker build -t hendrima/multi-client:latest -t hendrima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hendrima/multi-server:latest -t hendrima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hendrima/multi-worker:latest -t hendrima/multi-worker:$SHA -f ./worker/Dockerfile ./worker
dokcer push hendrima/multi-client
dokcer push hendrima/multi-server
dokcer push hendrima/multi-worker

dokcer push hendrima/multi-client:$SHA
dokcer push hendrima/multi-server:$SHA
dokcer push hendrima/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hendrima/multi-server:$SHA
kubectl set image deployments/client-deployment client=hendrima/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hendrima/multi-worker:$SHA

