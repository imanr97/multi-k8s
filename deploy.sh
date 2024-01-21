docker build -t imanr76/multi-client:latest -t imanr76/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imanr76/multi-server:latest -t imanr76/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imanr76/multi-worker:latest -t imanr76/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push imanr76/multi-client:latest
docker push imanr76/multi-client:$SHA 
docker push imanr76/multi-server:latest
docker push imanr76/multi-server:$SHA
docker push imanr76/multi-worker:latest 
docker push imanr76/multi-worker:$SHA 


kubectl apply -f k8s

kubectl set image deployment/server-deployment server=imanr76/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=imanr76/multi-worker:$SHA
kubectl set image deployment/client-deployment client=imanr76/multi-client:$SHA


