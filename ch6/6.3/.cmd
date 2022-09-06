# 1.vagrantup for new harbor VM 
cd ~/_Lecture_prom_learning.kit/ch6/6.4/harbor-vagrantup
vagrant up

# 2.harbor install ON NEW harbor VM (192.168.1.64)
ssh 192.168.1.64 / password is 'vagrant' 
# generate certificate 
~/_Lecture_prom_learning.kit/ch6/6.3/harbor-certificate/create-certificate.sh
# install harbor docker-compose 
~/_Lecture_prom_learning.kit/ch6/6.3/harbor-app/install.sh

# 3.harbor status check 
# check harbor status thru web browse (192.168.1.64)

# check exposed metrics by harbor app   
cat ~/_Lecture_prom_learning.kit/ch6/6.3/harbor-app/harbor.yml | grep metric: -A 4
# double-check exposed metrics by web browse 
http://192.168.1.64:9090/metrics

# 4.add exposed metrics to the prometheus(SD/service discovery)
# run ON m-k8s 
# confirm & add static address app 
cat ~/_Lecture_prom_learning.kit/ch6/6.3/add-harbor-to-the-prometheus.yaml | grep harbor -A 5
kubectl patch configmap prometheus-server -n monitoring --patch-file ~/_Lecture_prom_learning.kit/ch6/6.3/add-harbor-to-the-prometheus.yaml 
# check register on prometheus web ui's target 

# 5.validation for metrics value on harbor 
docker pull nginx
docker tag nginx 192.168.1.64/library/nginx
# ID/Password: admin/admin 
docker login 192.168.1.64 
docker push 192.168.1.64/library/nginx
