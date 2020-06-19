# **Environment Setup**

This project are divided in four environments. Wen call environment name of **{environment_name}**

| Description | {environment_name} |
|---|---|
| Development | development |
| Testing | testing |
| Stagging | stagging |
| Production | production |

Each environment have your own network, ports and ip address range.

## **Links**

### Development

1. Database and Caches
- pgAdmin4 (<a href="http://localhost:6500" target="_blank">link</a>)

## **Networks**

Each environment have your own network with the pattern: 172.xx.0.2 to 172.xx.255.255 where we call xx of **{ip_second_octect}**.

| Network Name | {ip_second_octect} | Address Range Start | Address Range End |
|---|---|---|---|
| development | 18 | 172.18.0.2/16 | 172.18.255.255/16 |
| testing | 19 | 172.19.0.2/16 | 172.19.255.255/16 |
| stagging | 20 | 172.20.0.2/16 | 172.20.255.255/16 |
| production | 21 | 172.21.0.2/16 | 172.21.255.255/16 |

## **Ports**

Each container have a port mapping with docker daemon host machine.

### **Environments**

Each environment have your own ports convention with pattern: x000 to x999 where we call x of **{environment_port_prefix}**

| Environment Name | {environment_port_prefix} | Port Range Start | Port Range End |
|---|---|---|---|
| development | 6 | 6000 | 6999 |
| testing | 7 | 7000 | 7999 |
| stagging | 8 | 8000 | 8999 |
| production | 9 | 9000 | 9999 |

### **IPs**

| IP Range | Port Range | Description |
|---|---|---|
| 172.xxx.0.2 to 172.xxx.1.255 | y000 to y099 | Databases and Caches |
| 172.xxx.2.2 to 172.xxx.3.255 | y100 to y199 | Queues |
| 172.xxx.4.2 to 172.xxx.5.255 | y200 to y299 | WebAPIs |
| 172.xxx.6.2 to 172.xxx.7.255 | y300 to y399 | Consumers |
| 172.xxx.8.2 to 172.xxx.9.255 | y400 to y499 | Gateways |
| 172.xxx.10.2 to 172.xxx.11.255 | y500 to y599 | Other Apps |

**where**:
- **xxx**: {ip_second_octect}
- **y**: {environment_port_prefix}

## **Databases and Caches**

This section constains all databases and caches parameters. The following table shows all databases and caches:

| Description | IP | Port |
|---|---|---|
| PostgreSQL | 172.xxx.0.2 | y000 |
| MongoDB | 172.xxx.0.3 | y001 |
| RavenDB | 172.xxx.0.4 | y002 |
| Redis | 172.xxx.0.5 | y003 |
| Prometheus | 172.xxx.0.6 | y004 |

**where**:
- **xxx**: {ip_second_octect}
- **y**: {environment_port_prefix}

### **PostgreSQL**

We will create the container with config:

| Name | Value |
|---|---|
| Image | postgres |
| Name | xxx-postgres |
| Hostname | xxx-postgres |
| Username | postgres |
| Password | postgres |
| IP | 172.yyyy.0.2 |
| Port binding | z000:5432 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

### **MongoDB**

We will create the container with config:

| Name | Value |
|---|---|
| Image | mongo |
| Name | xxx-mongodb |
| Hostname | xxx-mongodb |
| Username | admin |
| Password | admin |
| IP | 172.yyyy.0.3 |
| Port binding | z001:27017 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

## **Queues**



## **WebAPIs**



## **Consumers**



## **Gateways**



## **Other Apps**

### **pgAdmin**

We will create the container with config:

| Name | Value |
|---|---|
| Image | dpage/pgadmin4 |
| Name | xxx-pgadmin4 |
| Hostname | xxx-pgadmin4 |
| Username | postgres |
| Password | postgres |
| IP | 172.yyyy.10.2 |
| Port binding | z500:80 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}