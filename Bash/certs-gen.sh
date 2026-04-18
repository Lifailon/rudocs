# Выпускаем корневой сертификат (CA) и ключ
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
  -subj '/CN=ca.k8s.local' \
  -out ca.crt \
  -keyout ca.key

# Выпускаем сертификат для домена (получаем csr - запрос на подпись и приватный ключ)
openssl req -newkey rsa:2048 -nodes \
  -subj "/CN=httpbin.k8s.local" \
  -out httpbin.csr \
  -keyout httpbin.key

# Подписываем сертификат домена в CA и получаем подписанный сертификат
openssl x509 -req -sha256 -days 365 -set_serial 0 \
  -CA ca.crt -CAkey ca.key \
  -in httpbin.csr -out httpbin.crt

# Создаем секрет в кластере с содержимым сертификатов и ключа
kubectl create secret generic httpbin-certs \
  --namespace default \
  --from-file=cert=httpbin.crt \
  --from-file=key=httpbin.key \
  --from-file=cacert=ca.crt