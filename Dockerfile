FROM debian
RUN apt update -y && apt install mariadb-server -y
RUN sed -i 's/bind-address/bind-address =  0.0.0.0 #/i' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir /mysql_scripts
COPY mySqlScript.sql /mysql_scripts/
COPY esp_ble.sql /mysql_scripts/
RUN /etc/init.d/mysql start && mysql -u root --password="" -e "source /mysql_scripts/mySqlScript.sql"

RUN /etc/init.d/mysql start && mysql -u root --password="" -e "source /mysql_scripts/esp_ble.sql"


CMD /etc/init.d/mysql start && tail -f /dev/null
