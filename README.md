# magento-env

This contains everything you need to set up a development environment running magento 2 in its latest version.

## Description
After cloning the project, you will have to execute two commands.

The first one should be executed from your local machine and will allow you to build the necessary docker containers which are described in the docker-compose.yml file.

6 docker containers will be needed: 
- php
- nginx
- mysql
- redis
- rabbitmq
- elasticsearch

The second command must be executed from the php container.
It will create the magento project using composer. The latest version of magento (aka Adobe commerce) will be installed. At this time the latest version is 2.4.
As the magento source code is downloaded from the repository https://repo.magento.com/, you will be asked for access keys. To obtain these keys, you must have a magento developper account and access the magento marketplace at this page https://marketplace.magento.com/customer/accessKeys/.
Once the magento project is created, the script will continue with the magento installation itself.

Once this is finished, you will be able to access your new magento instance.

## Step by step guide
- clone the git projet
```
git clone git@github.com:berliozd/magento-env.git .
```
- run pre.sh from your local machine et the root of the git project
```
docker/pre.sh
```
- run bash inside the PHP container
```
docker-compose -f docker-compose.mac.yml run php bash
```
- run init.sh from the PHP container
```
docker/php/init.sh
```

That's all.

- The frontend will be accessible on : http://dev.addeos.
- The backoffice will be accessible on http://dev/addeos/admin. (user: admin, password: admin@addeos1)
