docker build -t hendrima/multi-client:latest -t hendrima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hendrima/multi-server:latest -t hendrima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hendrima/multi-worker:latest -t hendrima/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hendrima/multi-client
docker push hendrima/multi-server
docker push hendrima/multi-worker

docker push hendrima/multi-client:$SHA
docker push hendrima/multi-server:$SHA
docker push hendrima/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hendrima/multi-server:$SHA
kubectl set image deployments/client-deployment client=hendrima/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hendrima/multi-worker:$SHA

