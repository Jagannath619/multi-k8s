docker build -t jagannath616/multi-client:latest -t jagannath616/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jagannath616/multi-server:latest -t jagannath616/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jagannath616/multi-worker:latest -t jagannath616/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jagannath616/multi-client:latest
docker push jagannath616/multi-server:latest
docker push jagannath616/multi-worker:latest

docker push jagannath616/multi-client:$SHA
docker push jagannath616/multi-server:$SHA
docker push jagannath616/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jagannath616/multi-server:$SHA
kubectl set image deployments/client-deployment client=jagannath616/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jagannath616/multi-worker:$SHA