# **Criação do ambiente de desenvolvimento**

### **Requisitos**

- Docker e Docker Compose instalados e em execução no ambiente
- Faixas de IP disponíveis no Docker:
  - 172.18.xxx.xxx para rede do ambiente developer
  - 172.19.xxx.xxx para rede do ambiente testing
  - 172.20.xxx.xxx para rede do ambiente stagging
  - 172.21.xxx.xxx para rede do ambiente production
  
- Faixa de Portas disponíveis no Docker:
  - 6xxx para os mapeamentos do ambiente developer
  - 7xxx para os mapeamentos do ambiente testing
  - 8xxx para os mapeamentos do ambiente stagging
  - 9xxx para os mapeamentos do ambiente production

### **Ambientes**

Existem 4 ambientes que são criados. Os ambientes são:

| Ambiente | Descrição |
|---|---|
| **development** | ambiente de desenvolvimento |
| **testing** | ambiente de testes |
| **stagging** | ambiente de pré-produção |
| **production** | ambiente de produção |

### **Criação dos ambientes**

Para criação de cada ambiente, é necessário executar o comando <code>docker-compose.exe up -d</code> nos diretórios correspondentes a cada ambiente que possuí seus respectivos arquivos .env e docker-compose.yml, conforme lista abaixo, porém, é necessário que as networks e diretórios estejam criados conforma a documentação.

| Ambiente | Local |
|---|---|
| **development** | docker\generated\environments\development |
| **testing** | docker\generated\environments\testing |
| **stagging** | docker\generated\environments\stagging |
| **production** | docker\generated\environments\production |

o conteúdo do diretório docker\generated foi criado por meio de scripts Powershell que fazem todo o preparativo e mapeamento dos volumes, docker networks, variáveis de ambiente do docker compose e criação dos containers por meio do docker compose. Os scripts para criação encontram-se em:

| Ambiente | Local |
|---|---|
| **development** | docker\scripts\creation\create-env-development.ps1 |
| **testing** | docker\scripts\creation\create-env-testing.ps1 |
| **stagging** | docker\scripts\creation\create-env-stagging.ps1 |
| **production** | docker\scripts\creation\create-env-production.ps1 |
| **all** | docker\scripts\creation\create-env-all.ps1 |

Para executar o script de criação automático de todos os ambientes (ou de um ambiente específico que, para isso, troque para o script correspondente de acordo com a tabela acima), a partir do diretório raiz do projeto, execute os seguintes comnados:

1. <code>cd docker\scripts\creation</code>
2. <code>.\create-env-all.ps1</code>

## **Links**

###  Development

1. Database and Caches Web Interfaces
- pgAdmin (<a href="http://localhost:6500" target="_blank">link</a>)
- MongoClient (<a href="http://localhost:6502" target="_blank">link</a>)
- RavenDB (<a href="http://localhost:6503" target="_blank">link</a>)
- Prometheus (<a href="http://localhost:6504" target="_blank">link</a>)
- Grafana (<a href="http://localhost:6505" target="_blank">link</a>)

2. Queues
- RabbitMQ (<a href="http://localhost:6506" target="_blank">link</a>)

3. Other Apps
- SonarQUBE (<a href="http://localhost:6507" target="_blank">link</a>)

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
| Name | xxx-postgresql |
| Hostname | xxx-postgresql |
| Username | admin |
| Password | admin |
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

### **RavenDB**

We will create the container with config:

| Name | Value |
|---|---|
| Image | ravendb/ravendb |
| Name | xxx-ravendb |
| Hostname | xxx-ravendb |
| IP | 172.yyyy.0.4 |
| Port binding | z002:38888 |
| Port binding | z503:8080 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

### **Prometheus**

We will create the container with config:

| Name | Value |
|---|---|
| Image | prom/prometheus |
| Name | xxx-prometheus |
| Hostname | xxx-prometheus |
| IP | 172.yyyy.0.5 |
| Port binding | z504:9090 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

## **Queues**

This section constains all queues. The following table shows all queues config:

| Description | IP | Port |
|---|---|---|
| RabbitMQ | 172.xxx.2.2 | y100 |

**where**:
- **xxx**: {ip_second_octect}
- **y**: {environment_port_prefix}

### **RabbitMQ**

We will create the container with config:

| Name | Value |
|---|---|
| Image | rabbitmq |
| Name | xxx-rabbitmq |
| Hostname | xxx-rabbitmq |
| Username | guest |
| Password | guest |
| IP | 172.yyyy.2.2 |
| Port binding | z100:5672 |
| Port binding | z506:15672 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

### **PostgreSQL**

We will create the container with config:

| Name | Value |
|---|---|
| Image | postgres |
| Name | xxx-postgresql |
| Hostname | xxx-postgresql |
| Username | admin |
| Password | admin |
| IP | 172.yyyy.0.2 |
| Port binding | z000:5432 |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}



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

### **MongoClient**

We will create the container with config:

| Name | Value |
|---|---|
| Image | mongoclient/mongoclient |
| Name | xxx-mongoclient |
| Hostname | xxx-mongoclient |
| IP | 172.yyyy.10.3 |
| Port binding | z502:3000  |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}


### **RavenDB**

RavenDB have our own management web interface. The web interface port **x503** are exposed by RavenDB container.

**where**:
- **x**: {environment_port_prefix}

### **Prometheus**

RavenDB have our own management web interface. The web interface port **x504** are exposed by RavenDB container.

**where**:
- **x**: {environment_port_prefix}

### **Grafana**

We will create the container with config:

| Name | Value |
|---|---|
| Image | grafana/grafana |
| Name | xxx-grafana |
| Username | admin |
| Password | admin |
| Hostname | xxx-grafana |
| IP | 172.yyyy.10.4 |
| Port binding | z505:3000  |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}

### **RabbitMQ**

RabbitMQ have our own management web interface. The web interface port **x506** are exposed by RabbitMQ container.

### **SonarQUBE**

We will create the container with config:

| Name | Value |
|---|---|
| Image | sonarqube:8.2-community |
| Name | xxx-sonarqube |
| Username | admin |
| Password | admin |
| Hostname | xxx-sonarqube |
| IP | 172.yyyy.10.5 |
| Port binding | z507:3000  |

**where**:
- **xxx**: {environment_name}
- **yyy**: {ip_second_octect}
- **z**: {environment_port_prefix}