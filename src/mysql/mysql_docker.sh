docker pull mysql:5.7.24

docker run --name mysql_5_7  -p3306:3306 -e MYSQL_ROOT_PASSWORD=admin -e TZ=Asia/Shanghai  --restart=always -d mysql:5.7.24

cat >> docker-compose.yaml <<EOF
version: '3'
services:
  mysql:
    image: mysql:5.7.19
    ports:
    - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: 'admin'
      TZ: 'Asia/Shanghai'
    restart: always
  redis:
    image: redis:4
    ports:
    - "6379:6379"
    restart: always
  influxdb:
    image: influxdb:1.2.4
    ports:
    - "8083:8083"
    - "8086:8086"
    environment:
      INFLUXDB_ADMIN_ENABLED: 'true'
    restart: always
EOF
