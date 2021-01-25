docker build -t abhyudaya/multi-server:latest -t abhyudaya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhyudaya/multi-client:latest -t abhyudaya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhyudaya/multi-worker:latest -t abhyudaya/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push abhyudaya/multi-server:latest
docker push abhyudaya/multi-client:latest
docker push abhyudaya/multi-worker:latest
docker push abhyudaya/multi-server:$SHA
docker push abhyudaya/multi-client:$SHA
docker push abhyudaya/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abhyudaya/multi-server:$SHA
kubectl set image deployments/client-deployment client=abhyudaya/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abhyudaya/multi-worker:$SHA