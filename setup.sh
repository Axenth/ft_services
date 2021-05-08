echo "Deleting old Minikube container"
minikube delete

echo "Start Kubernetes with Minikube.."
minikube start --driver=virtualbox \
                --cpus=2 --memory=4096 --disk-size=4g \
                --addons metallb --addons dashboard --addons metrics-server --extra-config=kubelet.authentication-token-webhook=true

echo "Enable metrics server"
minikube addons enable metrics-server > /dev/null

echo "Starting dashboard"

minikube addons enable dashboard > /dev/null

echo "Starting metalLB"

minikube addons enable metallb > /dev/null
kubectl apply -f ./srcs/metalLB/metallb.yml
kubectl apply -f ./srcs/set_permissions.yml # set permissions for influxdb

eval $(minikube docker-env)
IP=$(minikube ip)
echo " "
echo "-----------------------"
echo "|   Building images   |"
echo "-----------------------"
echo " "


echo -ne 'Building: Nginx (0/8 done)     \r'
docker build -t nginx:ft_services ./srcs/nginx/. > /dev/null

echo -ne 'Building: FTPS (1/8 done)      \r'
docker build -t ftps:ft_services ./srcs/FTPS/. > /dev/null

echo -ne 'Building: mySQL (2/8 done)     \r'
docker build -t mysql:ft_services ./srcs/mysql/. > /dev/null

echo -ne 'Building: Wordpress (3/8 done) \r'
docker build -t wordpress:ft_services ./srcs/wordpress/. > /dev/null

echo -ne 'Building: PhpMyAdmin (4/8 done)\r'
docker build -t phpmyadmin:ft_services ./srcs/phpMyAdmin/. > /dev/null

echo -ne 'Building: InfluxDB (5/8 done)  \r'
docker build -t influxdb:ft_services ./srcs/InfluxDB/. > /dev/null

echo -ne 'Building: Telegraf (6/8 done)  \r'
docker build -t telegraf:ft_services ./srcs/Telegraf/. > /dev/null

echo -ne 'Building: Grafana (7/8 done)   \r'
docker build -t grafana:ft_services ./srcs/Grafana/. > /dev/null

echo -ne 'Building is all done (8/8 done)\r'
echo -ne '\n'


echo " "
echo "--------------------------"
echo "|Creating pods & services|"
echo "--------------------------"
echo " "

echo -ne 'Creating: Nginx (0/8 done)      \r'
kubectl apply -f ./srcs/nginx/nginx.yml > /dev/null

echo -ne 'Creating: FTPS (1/8 done)       \r'
kubectl apply -f ./srcs/FTPS/ftps.yml > /dev/null

echo -ne 'Creating: mySQL (2/8 done)      \r'
kubectl apply -f ./srcs/mysql/mysql.yml > /dev/null

echo -ne 'Creating: Wordpress (3/8 done)  \r'
kubectl apply -f ./srcs/wordpress/wordpress.yml > /dev/null

echo -ne 'Creating: InfluxDB (4/8 done)  \r'
kubectl apply -f ./srcs/InfluxDB/influxdb.yml > /dev/null

echo -ne 'Creating: Telegraf (5/8 done)  \r'
kubectl apply -f ./srcs/telegraf/telegraf.yml > /dev/null

echo -ne 'Creating: Grafana (6/8 done)   \r'
kubectl apply -f ./srcs/Grafana/grafana.yml > /dev/null

echo -ne 'Creating: PhpMyAdmin (7/8 done) \r'
kubectl apply -f ./srcs/phpMyAdmin/phpMyAdmin.yml > /dev/null

echo -ne 'Creating is all done (8/8 done)'
echo -ne '\n'

minikube dashboard & > /dev/null
