#!/bin/bash
echo "#############################"
echo "#    create project         #"
echo "#############################"
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento

echo "#############################"
echo "#    setting linux rights   #"
echo "#############################"

cd magento || exit
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R :www-data . # Ubuntu
chmod u+x bin/magento

echo "#############################"
echo "#    magento install        #"
echo "#############################"

bin/magento setup:install  \
    --base-url=http://dev.addeos/ --backend-frontname=admin  --language=fr_FR --timezone=Europe/Paris \
    --currency=EUR  --db-host=mysql --db-name=addeos --db-user=root --db-password=addeos \
    --use-secure=0 --base-url-secure=0 --use-secure-admin=0  --admin-firstname=Julien --admin-lastname=Lemaire \
    --admin-email=Juilen.lemaire@example.fr  --admin-user=admin --admin-password=admin@addeos1 \
    --elasticsearch-host=elasticsearch \
    --session-save=redis --session-save-redis-host=redis --session-save-redis-db=2 \
    --amqp-host="rabbitmq" --amqp-port="5672" --amqp-user="guest" --amqp-password="guest" --amqp-virtualhost="/" \
    -vvv

bin/magento module:disable Magento_TwoFactorAuth

echo "################################################################################"
echo "#                               end install                                    #"
echo "#  access admin with : http://dev.addeos/  [ user=admin password=admin@addeos1]  #"
echo "# access db : [user=localhost login=root password=addeos db=addeos]              #"
echo "################################################################################"
