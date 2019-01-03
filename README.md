# Bitmark Node Documentation

[ [English](#introduction) | [中文](#簡介) ]

## Introduction

The [Bitmark](https://bitmark.com) node software enables any computer on the Internet to join the Bitmark network as a fully-validating peer. Unlike conventional property systems that rely on a handful of trusted government officials to act as centralized gatekeepers, the Bitmark blockchain is an open and transparent property system that is strengthened through the active participation of anyone on the Internet. The integrity of Bitmark’s open-source blockchain is ensured by a peer-to-peer network of voluntary participants running the Bitmark node software. These participants are incentivized to participate in verifying Bitmark property transactions through the possibility of winning monetary and property rewards.

The Bitmark blockchain is an independent chain, optimized for storing property titles, or *bitmarks*, and does not have its own internal currency (transaction fees are in bitcoin or litecoin). The peer-to-peer network is written in [Go](https://golang.org) and uses the [ZeroMQ distributed messaging library](http://zeromq.org). The consensus is secured using the [Argon2](https://github.com/P-H-C/phc-winner-argon2) hashing algorithm as proof-of-work.


## Supported Platforms

The Bitmark node software is distributed as a standalone [Docker container](https://www.docker.com/what-container), which supports easy installation on all major platforms including:

- **Desktop devices**, such as [Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac) and [Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)
- **Linux servers**, such as [CentOS](https://store.docker.com/editions/community/docker-ce-server-centos), [Debian](https://store.docker.com/editions/community/docker-ce-server-debian), [Fedora](https://store.docker.com/editions/community/docker-ce-server-fedora), and [Ubuntu](https://store.docker.com/editions/community/docker-ce-server-ubuntu)
- **Cloud providers**, such as [AWS](https://store.docker.com/editions/community/docker-ce-aws) and [Azure](https://store.docker.com/editions/community/docker-ce-azure)


## Contents

The Bitmark node consists of the following software programs:

 - **bitmarkd** — the main program for verifying and recording transactions in the Bitmark blockchain [(view source code on GitHub)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/bitmarkd)
 - **recorderd** — an auxillary application for computing the Bitmark proof-of-work algorithm that allows nodes to compete to win blocks on the Bitmark blockchain [(view source code on GitHub)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/recorderd)
 - **bitmark-wallet** — an integrated cryptocurrency wallet for receiving Bitcoin and Litecoin payments for won blocks [(view source code on GitHub)](https://github.com/bitmark-inc/bitmark-wallet)
 - **bitmark-cli** — a command line interface to `bitmarkd` [(view source code on GitHub)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/bitmark-cli)
 - **bitmark-webui** — a web-based user interface to monitor and configure the Bitmark node via a web browser

## Installation

**To install the Bitmark node software, please complete the following 4 steps:**

### 1. Install Docker

The Bitmark node software is distributed as a standalone [Docker container](https://www.docker.com/what-container) which requires you to first install Docker for your operating system:


- [Get Docker CE for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)
- [Get Docker Toolbox for Windows 10 Home and Windows 8](https://docs.docker.com/toolbox/toolbox_install_windows)
- [Get Docker CE for Windows 10 Pro, Education, and Enterprise](https://store.docker.com/editions/community/docker-ce-desktop-windows)
- [Get Docker CE for CentOS](https://store.docker.com/editions/community/docker-ce-server-centos)
- [Get Docker CE for Debian](https://store.docker.com/editions/community/docker-ce-server-debian)
- [Get Docker CE for Fedora](https://store.docker.com/editions/community/docker-ce-server-fedora)
- [Get Docker CE for Ubuntu](https://store.docker.com/editions/community/docker-ce-server-ubuntu)
- [Get Docker CE for AWS](https://store.docker.com/editions/community/docker-ce-aws)
- [Get Docker CE for Azure](https://store.docker.com/editions/community/docker-ce-azure)

### 2. Download the Bitmark Node

After successfully installing Docker, you can download the Bitmark node software. To do so, first open a command-line terminal or shell application, such as Terminal on the MacOS or Linux, or `cmd.exe` on Windows. Then enter the following command to download the Bitmark node software:

```
docker pull bitmark/bitmark-node
```


After entering the pull command, the download sequence should begin in the terminal. You will receive the following message after the download is completed successfully:

```
Status: Downloaded newer image for bitmark/bitmark-node:latest
```


### 3. Run the Bitmark Node

#### Prepare Public IP

Public IP is the IP which people in Internet can reach your bitmark-node. Our script will automatically find your public IP for you. However, network setting are various, we can not guarentee that auto-generate IP is acurate or correct. To get your accurate public IP, please consult your ISP. 

#### Prepare Network Environment

- The following ports must be accessible from Internet.

    | PORT  | DESCRIPTION  |
    |:---|:---|
    | `9980` | Web server port for web UI |
    | `2136` | Port for connecting to other peer bitmarkd nodes |
    | `2135` | Port for publishing blockchain events |
    | `2130` | Port for Bitmark node [RPC](https://en.wikipedia.org/wiki/Remote_procedure_call) server |

    After running bitmark-node, you can check by the following commands to make sure ports are opened. 

    ```netcat -v [Your Public IP] 2136```

    ```netcat -v [Your Public IP] 2135```

    ```netcat -v [Your Public IP] 2130```


- WebUI is an interface to control bitmark-node. You should be able to access it through local network and due to security reason, you should not make port public.

    | PORT  | DESCRIPTION  |
    |:---|:---|
    | `9980` | Web server port for web UI |

#### Auto Update

Each script contains an option to check for updates every time the script is run. This is enabled by default and can be turned off by opening the script in a text editor and replacing the ```true``` text in ```AUTO_UPDATE=true``` with ```false```. This can be founded in a section at the top of the script titled ```User Defined Variables```. Be sure to keep quotation as it is currently in the script.

#### Setup Scripts

- Linux Users
    * Download the setup script   [bitmarkNode-Linux-MacOS.sh](https://s3-ap-northeast-1.amazonaws.com/bitmark-node-docker-scripts/bitmarkNode-Linux-MacOS.sh) and run it. This can be accomplished by right-clicking on it, selecting open ```Open With Terminal```.
  
    * execute  ```bash bitmarkNode-Linux-MacOS.sh [Your Public IP]```
        
        ie. ```bash bitmarkNode-Linux-MacOS.sh 117.166.111.123```
    
    * If the script does not run, right-click on it, select properties, go to the permissions tab, and click on the box to "Allow this file to run as a program".

- Windows Users Running Docker in Hyper-V (Windows 10 Pro and Enterprise)
     * [Ensure that Hyper-V is turned on](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)
     * Download the setup script and run it by right-clicking on it, and selecting ```Run as administrator```.
     [bitmarkNode-HyperV.bat](https://s3-ap-northeast-1.amazonaws.com/bitmark-node-docker-scripts/bitmarkNode-HyperV.bat)
    
- MacOS Users
  * Download the setup script  [bitmarkNode-Linux-MacOS.sh](https://s3-ap-northeast-1.amazonaws.com/bitmark-node-docker-scripts/bitmarkNode-Linux-MacOS.sh) and run it. You can run the script by opening a ```Terminal```, moving to your download directory within the terminal (if your download directory is Downloads, this can be accomplished by typing ```cd Downloads```) 
    
  * execute  ```bash bitmarkNode-Linux-MacOS.sh [Your Public IP]```   
     ie. ```bash bitmarkNode-Linux-MacOS.sh 117.166.111.123```


#### Future Setup

The Docker container must be restarted after everytime the computer is turned off. To restart the container, simply re-run the setup script as you did the first time. You can also manually restart the container as described below. Note, if you do have auto-update enabled in the script, manually starting the container will not check for updates.


#### Manual Setup

All of the following commands will be run in the appropriate command-line interface described [below](#Terminals). Before running the bitmark-node container, you should check container status:

1. Run ```docker ps -a``` to check if bitmarkNode container exist.

2. Check "Status"
    * Status: Up to [time] : 
    bitmarkNode is running. You may either leave this container running or you can stop it using ```docker stop bitmarkNode```. You may then delete the container using ```docker rm bitmarkNode```.
    * Status: Exit: 
    bitmarkNode is not running but the container exists. In this case, you can start the container by using ``` docker start bitmarkNode ```, or you can use ``` docker rm bitmarkNode``` to delete the container. To start the container again, you must re-run the first time setup script for your operating system.

---

#### General Information

Once the Bitmark node has successfully started, it will return a 64-character hexadecimal string that represents the Bitmark node's Docker container ID, such as:

```
dc78231837f2d320f24ed70c9f8c431abf52e7556bbdec257546f3acdbda5cd2
```

When the Bitmark node software is started up for the first time, it will generate a Bitmark account for you, including your public and private key pairs.

#### Docker Run Command Options

Various Bitmark node environmental settings, such as ports and IP addresses, can be configured using the Docker `run` command when running the Bitmark node from the command-line terminal:

```
docker run -d --name bitmarkNode -p 9980:9980 \
-p 2136:2136 -p 2130:2130 \
-e PUBLIC_IP=[YOUR_PUBLIC_IP] \
-e NETWORK=[YOUR_NETWORK] \
-v $HOME/bitmark-node-data/db:/.config/bitmark-node/db \
-v $HOME/bitmark-node-data/data:/.config/bitmark-node/bitmarkd/bitmark/data \
-v $HOME/bitmark-node-data/data-test:/.config/bitmark-node/bitmarkd/testing/data \
bitmark/bitmark-node
```

##### Note that ```YOUR_PUBLIC_IP``` should be replaced with your own public IP address and ```[YOUR_NETWORK] should be replaced with a network as described [here](#Current-Blockchain).

The following table describes the various configuration options for the Bitmark node `run` command:


| OPTION  | DEFAULT  | DESCRIPTION  |
|:---|:---|:---|
| `-name`  | `bitmarkNode` | Assigns a name to the Bitmark node Docker container. |
| `-p`  | `9980` | Web server port for web UI |
| `-p`  | `2136` | Port for connecting to other peer bitmarkd nodes |
| `-p`  | `2135` | Port for publishing blockchain events |
| `-p`  | `2130` | Port for Bitmark node [RPC](https://en.wikipedia.org/wiki/Remote_procedure_call) server |
| `-e`  | `PUBLIC_IP=[YOUR_PUBLIC_IP]` | Environment variable for register your public IP address.  |
| `-e`  | `NETWORK=[YOUR_NETWORK]` | Either ```bitmark``` or ```testing```. Learn more about the two networks [here](#Current-Blockchain)  |

For an explanation of each of the `run` command options, please enter the following command into the terminal:

```
docker run --help
```


#### Terminals

Each version of Docker will use a different command-line interpreter (CLI) depending on the Operating System. See below to find the correct one for your Operating System and Docker pairing:

| Operating System (Docker Version)                 | CLI                       |
| ------------------------------------------------- | ------------------------- |
| Linux (Docker for Linux)                          | Terminal                  |
| Windows 8 or 10 Home (Docker Toolbox)             | Docker Quickstart Toolbox |
| Windows 10 Pro or Enterprise (Docker for Windows) | ```cmd.exe```             |
| MacOS (Docker for Mac)                            | Terminal                  |



### 4. Start Services in Web Interface

The Bitmark node includes a web-based user interface to monitor and control the Bitmark node within a web browser. After running the Bitmark node in step 3, you should launch the web UI to start the `bitmarkd` and optional `recorderd` programs.

On most computer systems, the web UI can be accessed on port `9980` of the `localhost` address (`127.0.0.1`) by clicking the following link:

> [http://127.0.0.1:9980](http://127.0.0.1:9980).

After loading the web UI, you should use it to start the two main Bitmark node software programs:

1. `bitmarkd` — responsible for verifying Bitmark transactions and recording them in the Bitmark blockchain (required for all Bitmark nodes)
2. `recorderd` — required for solving the Bitmark blockchain's proof-of-work algorithm, which qualifies nodes to win blocks and receive monetary compensation (optional)

After starting the `bitmarkd` node for the first time, the node will go through an initial `Resynchronizing` phase in which a copy of the current Bitmark blockchain will be downloaded to your Bitmark node. Once the blockchain resynchronization has completed, your Bitmark node will begin verifying and recording transactions for the current block.

## User Interface Walkthrough

### 1. Login Screen
![](https://i.imgur.com/rVLzYj1.png)

On the login screen, you can either enter your 24-word recovery phrase to log in to an existing account or you're able to create a new account. When you create a new account, you will be assigned a 24-word recovery phrase that will allow you to login to the same account after restarting the Docker container. You will also be prompted to enter a Bitcoin and Litecoin wallet address to allow you to receive any monetary awards for verifying Bitmark property transactions (these address can be changed at any time). If you do not have a bitcoin or litecoin wallet, see [here](#Payment-Addresses) for more information.

### 2. Startup Screen
![](https://i.imgur.com/g0OXQwH.png)

On this screen, you can start up the two parts of the Bitmark Node software, ```bitmarkd``` and ```recorderd```. By clicking on the person icon on the top of the screen you can: view your blocks won, write down your recovery phrase, and copy down your account address. By clicking on the three bar drop-down menu you can change your language, and view the Bitmark Node documentation. You can also change your cryptocurrency wallet addresses in the ```Bitmark Wallet``` section.

### 3. Running Screen
![](https://i.imgur.com/nS0lrJO.png)
This full-sized menu appears once you start the ```bitmarkd``` software.

* Bitmark Node (bitmarkd):
  * ```Status```: Either ```Stopped``` or ```Running```. Describes the state of the ```bitmarkd``` software.
  * ```Connection```: When starting up, it displays ```Checking connection…```. After connecting to the network, it will show the number of nodes that it is connected to. A connection of three nodes is required to successfully run the Bitmark Node software.
* Recorder Node (recorderd)
  * ```Status```: Either ```Stopped``` or ```Running```. Describes the state of the ```recorderd``` software.
* Network ID
  * This is your bitmark-node public key
* Current Block
  * This displays what the current block your system is on. This can either be the latest block, or the block that it is currently downloading.
* Transaction Counter
  * ```Pending```: The pending transcations count
  * ```Verified```: The verified transcations count
* Uptime
  * This describes the total time that the Docker container has been active for.
* Your Blocks
  * Each block in this section is for a block that your account has solved, including the date and time it was solved on, the block number, and the hash, the "solution" for that block. 

## Configuration Options

### Current Blockchain

The Bitmark node allows participants to verify and record transactions on two different Bitmark blockchains:

- `bitmark` — the official version of the Bitmark blockchain
- `testing` — a `testnet` version of the blockchain used solely for development testing

Node participants can select which blockchain they are currently working on via the web UI. Note that switching to a different blockchain will require you to restart the Docker container, selecting the new network.

The Bitmark system offers monetary rewards to block winners for both the `bitmark` and `testing` blockchains.

### Payment Addresses

[comment]: <> (TODO: Update description to describe how people actually get paid.)

Bitmark node participants running both `bitmarkd` and `recorderd` are awarded monetary payments for winning blocks on both the `bitmark` and `testing` blockchains. These payments are delivered as either bitcoin or litecoin payments (depending on current cryptocurrency prices and confirmation times) and are delivered to a node's designated bitcoin and litecoin payment addresses.

When the Bitmark node software is first started up, it requires the user to provide a bitcoin and litecoin account address. If you do not have a bitcoin or litecoin wallet, there are many ways to easily get one online. A simple, online solution is [coinbase](https://coinbase.com), though any wallet will work.


## Updates

**If you turned off automatic updates in your setup script, you can update the Bitmark node software with the following 3 steps:**

### 1. Download Latest Node Version

To update your version of the Bitmark node software, open a command-line terminal or shell application, such as Terminal on the Mac or Linux, `cmd.exe` on Windows 10 Pro or Enterprise, or ```Docker Quickstart Terminal``` on Windows 8 or 10 Home, then enter the following command to download the software update:

```
docker pull bitmark/bitmark-node
```

After entering the pull command, the download sequence should begin in the terminal. You will receive the following message after the download is completed successfully:

```
Status: Downloaded newer image for bitmark/bitmark-node:latest
```

### 2. Run Bitmark Node

After the software update has successfully downloaded, you need to remove the previous container and start a new one via command-line terminal:

```
docker rm -f bitmarkNode
docker run -d --name bitmarkNode -p 9980:9980 \
-p 2136:2136 -p 2130:2130 \
-e PUBLIC_IP=[YOUR_PUBLIC_IP] \
-e NETWORK=[YOUR_NETWORK]
-v $HOME/bitmark-node-data/db:/.config/bitmark-node/db \
-v $HOME/bitmark-node-data/data:/.config/bitmark-node/bitmarkd/bitmark/data \
-v $HOME/bitmark-node-data/data-test:/.config/bitmark-node/bitmarkd/testing/data \
bitmark/bitmark-node
```
Please remember to replace `[YOUR_PUBLIC_IP]` to your node public ip and ```[YOUR_NETWORK``` with ```bitmark``` or ```testing```.


### 3. Restart Services in Web Interface

Finally, restart the `bitmarkd` and optional `recorderd` programs via the web UI. On most computer systems, the web UI can be accessed on port `9980` of the `localhost` address (`127.0.0.1`) by clicking the following link:

> [http://127.0.0.1:9980](http://127.0.0.1:9980).

After loading web UI, you should use it to start the two main Bitmark node software programs:

1. `bitmarkd` — responsible for verifying Bitmark transactions and recording them in the Bitmark blockchain (required for all Bitmark nodes)
2. `recorderd` — required for solving the Bitmark blockchain's proof-of-work algorithm, which qualifies nodes to win blocks and receive monetary compensation (optional)

After restarting the `bitmarkd` node for the first time, the node will go through an initial `Resynchronizing` phase in which a copy of the current Bitmark blockchain will be downloaded to your Bitmark node. Once the blockchain resynchronization has completed, your Bitmark node will begin verifying and recording transactions for the current block.

## Troubleshooting

#### Listening port (2136) is not accessible.
*  If you did not provide your IP address correctly, or your IP address has changed since setup, this issue can arise. You must stop the node through Terminal (MacOS/Linux), ```cmd.exe``` (Windows 10 Pro and Enterprise), or through the ```Docker Quickstart Terminal``` (Windows 8 or 10 Home) by typing ```docker stop bitmarkNode```. Then you must remove the container by typing ```docker rm bitmarkNode```. Now re-run the setup script (for users using the Docker Toolbox setup script, you must find your public IP address again by visiting [ipinfo.io/ip](ipinfo.io/ip) and re-entering your IP address in the setup script).
* This can also be caused by your router's NAT (Network Address Translation) not allowing you to access port 2136, the port used to connect to other bitmarkd nodes. To allow the node software to access this port, you must enable port forwarding on your router and forward port 2136. A good guide on how to do this is linked [here](https://www.howtogeek.com/66214/how-to-forward-ports-on-your-router).


#### Using Docker Toolbox in Windows
- Docker Toolbox in Windows is NOT officially supported, but you can try the steps below
- Windows Users Running Docker in Toolbox (Windows 8 and 10 Home)
  * Docker in Toolbox is not official supported but 
  * Setup port forwarding in Docker VirtualMachine:
      * Open Oracle VM VirtualBox and navigate to the docker virtual machine titled ```default```. Right-click on the virtual machine and navigate to ```Settings```. 
      * Go to ```Network``` and select an adapter that is not currently enabled. Click on the checkbox that says ```Enable Network Adapter``` and select the drop-down box called '''Attached To:''' and select ```NAT```. Enable ```Advanced``` settings by clicking the arrow to the left of the text and click on the box that says ```Port Forwarding```.
      * You're able to add a new rule by selecting the + sign on the right. Add the following 4 ports:
      
        | Name       | Protocol | Host IP  | Host Port | Guest IP | Guest Port |
        | ---------- | -------- | -------- | --------- | -------- | ---------- |
        |  Docker #1 | TCP      |          | 9980      |          | 9980
        |  Docker #2 | TCP      |          | 2136      |          | 2136	
        |  Docker #3 | TCP      |          | 2135      |          | 2135
        |  Docker #4 | TCP      |          | 2130      |          | 2130

  * Prepare the setup script:
      * Begin by downloading the script.
      [bitmarkNode-Toolbox.bat](https://s3-ap-northeast-1.amazonaws.com/bitmark-node-docker-scripts/bitmarkNode-Toolbox.sh)
      * Open the script in a text editor by right-clicking on the script and selection ```Open With...``` and then select notepad or your preferred text editor. 
      * Add your public IP Address to ```line 25``` by replacing the text ```XXX.XX.XX.XX```. This can be found on the website [ipinfo.io/ip](http://ipinfo.io/ip).
      * If you would like to change the directory in which the Bitmark node stores its data, do so on ```line 26```. By default, it is ```/c/```. During setup, it will create a folder ```bitmark-node-data``` in this directory. Do not include user directories if the path is changed (i.e. do not use /c/Users/yourname).
      * Save the script and move it to the Docker Toolbox file path (by default this is C:\Program Files\Docker Toolbox). Note that this is not the same path as the one you were given the option to change in the last step, instead it is something chosen during Docker setup.
      * Open ```Docker Quickstart Terminal``` and run the setup script by typing ```sh bitmarkNode-Toolbox.sh```.

#### Current Block Stuck at 1/1
* Once the Bitmark Node software successfully starts, it will remain at 1/1 blocks for a short period of time. If the node is successfully connected to at least 3 other nodes and remains stuck at 1/1 for a long period of time, restart the Docker container. If the issue persists, remove the container by typing ```docker rm bitmarkNode``` and re-run the setup script. 

#### HTTP: TLS Handshake Error
* To solve this error, restart the docker container. 

#### Storage Initialise Error
* To solve this error, restart the docker container. 

#### Windows Login failed
* You need to login docker hub at first time to pull images. If you login but still get the below message, the possible cause is that you use email to login but not your username.

  ```Error response from daemon: Get https://registry-1.docker.io/v2/bitmark/bitmark-node/manifests/latest: unauthorized: incorrect username or password```



# Bitmark節點說明

## 簡介

[Bitmark](https://bitmark.com) 節點是一個讓一台連網的電腦可以加入 Bitmark 網路並且參與驗證的軟體。Bitmark 區塊鏈與傳統的資產系統不同的地方在於，傳統的資產系統是一種由一群被信任的官方人員所運作的集中式管理系統，而 Bitmark 區塊鏈是一個任何人都可以透過網路積極參與驗證強化的開放透明資產系統。Bitmark 開源區塊鏈的健全性是由一群自願參與運行 Bitmark 節點軟體的人們所構成的P2P網路來維繫，而自願參與驗證 Bitmark 資產交易的誘因為可能贏得以金錢或是資產形式的獎勵。

Bitmark 區塊鏈是專門為了資產所有權（稱為 *bitmark* ）所優化的一條獨立的鏈，其本身並不是一種貨幣（交易手續費是用 bitcoin 或 litecoin 支付）。P2P 網路是用 [Go](https://golang.org) 語言寫成，並且使用 [ZeroMQ 分散式訊息庫](http://zeromq.org)。共識是使用 [Argon2](https://github.com/P-H-C/phc-winner-argon2) 的雜湊演算法來作為工作量證明。


## 支援平台

Bitmark節點軟體是透過獨立運作的 [Docker container](https://www.docker.com/what-container) 來發布。Docker container 可支援各主要平台的簡易安裝：

- **桌上型電腦**，如 [Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)或[Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)
- **Linux伺服器**，如 [CentOS](https://store.docker.com/editions/community/docker-ce-server-centos)、 [Debian](https://store.docker.com/editions/community/docker-ce-server-debian)、 [Fedora](https://store.docker.com/editions/community/docker-ce-server-fedora)及[Ubuntu](https://store.docker.com/editions/community/docker-ce-server-ubuntu)
- **雲端服務**，如 [AWS](https://store.docker.com/editions/community/docker-ce-aws) 及 [Azure](https://store.docker.com/editions/community/docker-ce-azure)

## 內容

Bitmark 節點由以下軟體程式所組成：

- **bitmarkd** - 用於 Bitmark 區塊鏈驗證以及紀錄交易的主程式。[(在 GitHub 上檢視原始碼)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/bitmarkd)
- **recorderd** - 用於計算 Bitmark 工作量證明演算法的附屬程式，使一個節點可以在 Bitmark 區塊鏈上爭取贏得區塊。[(在 GitHub 上檢視原始碼)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/recorderd)
- **bitmark-wallet** - 一個加密貨幣錢包，用來收取贏得區塊後以 bitcoin 或 litecoin 形式支付的獎勵。[(在 GitHub 上檢視原始碼)](https://github.com/bitmark-inc/bitmark-wallet)
- **bitmark-cli** - `bitmarkd`的命令列介面。[(在 GitHub上 檢視原始碼)](https://github.com/bitmark-inc/bitmarkd/tree/master/command/bitmark-cli)
- **bitmark-webui** - 透過網頁瀏覽器來檢視及控制 Bitmark 節點的使用者介面網頁。

## 安裝

**請依照以下四個步驟來完成安裝 Bitmark 節點軟體：**

### 一、安裝 Docker

Bitmark 節點軟體是透過獨立運作的 [Docker container](https://www.docker.com/what-container) 來發布。首先請在您的作業系統上安裝 Docker：


- [取得 Docker for MacOS](https://store.docker.com/editions/community/docker-ce-desktop-mac)
- [取得 Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)
- [取得 Docker for CentOS](https://store.docker.com/editions/community/docker-ce-server-centos)
- [取得 Docker for Debian](https://store.docker.com/editions/community/docker-ce-server-debian)
- [取得 Docker for Fedora](https://store.docker.com/editions/community/docker-ce-server-fedora)
- [取得 Docker for Ubuntu](https://store.docker.com/editions/community/docker-ce-server-ubuntu)
- [取得 Docker for AWS](https://store.docker.com/editions/community/docker-ce-aws)
- [取得 Docker for Azure](https://store.docker.com/editions/community/docker-ce-azure)

### 二、下載 Bitmark 節點

成功安裝 Docker 之後，您就可以下載 Bitmark 節點了。請先開啟命令列終端機或是命令提示字元，例如在 Mac 上的 Terminal 或是在 Windows 上的`cmd.exe`。然後輸入以下的指令來下載 Bitmark 節點軟體：

```
docker pull bitmark/bitmark-node
```

輸入 pull 的指令之後，下載應該就會開始執行。成功下載完成後，您會收到以下訊息：

```
Status: Downloaded newer image for bitmark/bitmark-node:latest
```

### 三、執行 Bitmark 節點

成功下載 Bitmark 節點之後，複製並貼上以下的指令於在命令列終端機上以執行 Bitmark 節點：

```
docker run -d --name bitmarkNode -p 9980:9980 \
-p 2136:2136 -p 2130:2130 \
-e PUBLIC_IP=[YOUR_PUBLIC_IP] \
-v $HOME/bitmark-node-data/db:/.config/bitmark-node/db \
-v $HOME/bitmark-node-data/data:/.config/bitmark-node/bitmarkd/bitmark/data \
-v $HOME/bitmark-node-data/data-test:/.config/bitmark-node/bitmarkd/testing/data \
bitmark/bitmark-node
```

請注意將`[YOUR_PUBLIC_IP]`置換成節點的對外IP。一旦 Bitmark 節點成功的開始執行，它會回傳一個代表 Bitmark 節點的 Docker container ID 的64字的16進位字串，如：

```
dc78231837f2d320f24ed70c9f8c431abf52e7556bbdec257546f3acdbda5cd2
```


當 Bitmark 節點軟體第一次運行的時候，它會為您產生一個 Bitmark 帳號，其中包含您的公鑰與密鑰組。

如欲了解`run`指令的各種選項，請於命令列終端機上輸入以下的指令：

```
docker run --help
 ```

### 四、在網頁使用者介面上開啟服務

Bitmark節點包含了一個用於檢視及控制的網頁使用者介面。執行了第三步驟並且運行了Bitmark節點之後，您可以開啟網頁使用者介面來啟動`bitmarkd`及`recorderd`選項程式。

在多數的電腦系統中，網頁使用者介面可以用`localhost`位址(`127.0.0.1`)上的`9980`連接埠來存取，如下面的鏈結：

> [http://127.0.0.1:9980](http://127.0.0.1:9980)

載入網頁使用者介面之後，您可以在上面啟動兩個主要的 Bitmark 節點程式：

1. `bitmarkd` - 負責驗證 Bitmark 交易並記錄於 Bitmark 區塊鏈上（所有 Bitmark 節點都必須執行此程式）
2. `recorderd` - 負責運算 Bitmark 區塊鏈的工作量證明演算法，該演算法決定一個節點是否贏得某區塊並獲得獎金（此為選項程式）

第一次開始執行`bitmarkd`之後，節點會經過一個`Resynchronizing`的同步階段。此階段會下載目前 Bitmark 區塊鏈上的資訊至您的節點。一旦同步階段完成之後，您的 Bitmark 節點會開始為最新的區塊做驗證並且記錄交易。


## 設定選項

### 目前的區塊鏈

Bitmark 節點有兩種 Bitmark 區塊鏈讓參與者選擇：

- `bitmark` - 正式的 Bitmark 區塊鏈
- `testing` - 一個專門給開發用的`testnet`版本區塊鏈

參與節點的使用者可以在網頁使用者介面上面選擇其中一種來作為目前的區塊鏈。要注意的是轉換至不同的鏈時會需要在網頁使用者介面上重啟新鏈的`bitmarkd`及`recorderd`程式。

無論是`bitmark`或`testing`區塊鏈，Bitmark 系統都會給予贏得區塊的人獎金。

## 付款地址

Bitmark 節點的參與者在`bitmark`或`testing`上運行`bitmarkd`及`recorderd`並且贏得區塊之後，會得到獎金作為獎勵。獎金會（依照當時的加密貨幣價格及確認時間）以 bitcoin 或 litecoin 的形式支付至指定的 bitcoin 或 litecoin 付款位址。

當第一次執行 Bitmark 節點軟體時，安裝程式會自動產生一組預設的 bitcoin 及 litecoin 付款地址。這些地址可以從 Bitmark 節點網頁使用者介面上檢視及設定。


### Docker執行命令選項

運行 Bitmark 節點時，在命令列終端機中使用 Docker `run` 指令可以做許多不同的環境設定，如連接埠及 IP 位址：

```
docker run -d --name bitmarkNode -p 9980:9980 \
-p 2136:2136 -p 2130:2130 \
-e PUBLIC_IP=[YOUR_PUBLIC_IP] \
-v $HOME/bitmark-node-data/db:/.config/bitmark-node/db \
-v $HOME/bitmark-node-data/data:/.config/bitmark-node/bitmarkd/bitmark/data \
-v $HOME/bitmark-node-data/data-test:/.config/bitmark-node/bitmarkd/testing/data \
bitmark/bitmark-node
```

下表列出了許多`run`指令可執行的設定選項：

| 選項  | 預設值  | 說明  |
|:---|:---|:---|
| `-name`  | `bitmarkNode` | 為 Bitmark 節點所在的 Docker container 命名 |
| `-p`  | `9980` | 網頁使用者介面的網頁伺服器連接埠 |
| `-p`  | `2136` | 連接至其他節點的 bitmarkd 的連接埠 |
| `-p`  | `2135` | 連接至其他節點的 bitmarkd 的連接埠 |
| `-p`  | `2130` | Bitmark 節點 [RPC](https://en.wikipedia.org/wiki/Remote_procedure_call) 伺服器的連接埠 |
| `-e`  | `PUBLIC_IP=[YOUR_PUBLIC_IP]` | 註冊節點公有 IP 位址的環境參數 |

### Docker Compose 設定

熟悉 [Docker Compose](https://docs.docker.com/compose/) 的參與者可以使用內附的 `docker-compose.yml` 檔案做為設定 Bitmark 節點服務的範例。

可設定的選項有：

  - 環境：
    - PUBLIC_IP: 您的公開 IP 位址
  - 連接埠:
    - 2130: RPC 伺服器連接埠
    - 2135 & 2136: Peering 連接埠
    - 9980: 網頁伺服器連接埠
    _(提示：請確認使用 TCP 設定您的網路的 port forwarding 以確保公共網路可以存取您的節點)_
  - Volumes:
    - /.config/bitmark-node/bitmarkd/bitmark/data - 用於儲存`bitmark`的資料
    - /.config/bitmark-node/bitmarkd/testing/data - 用於儲存`testing`的資料


## 更新

**欲更新 Bitmark 節點軟體，請完成以下三個步驟：**

### ㄧ、下載最新版本的節點

欲更新 Bitmark 節點軟體至最新版本，開啟命令列終端機或命令提示字元，例如在 Mac 上的 Terminal 或是在 Windows 上的`cmd.exe`。然後輸入以下的指令來下載 Bitmark 節點軟體更新：

```
docker pull bitmark/bitmark-node
```

輸入 pull 指令之後，下載應該就會開始執行。成功下載完成後，您會收到以下訊息：

```
Status: Downloaded newer image for bitmark/bitmark-node:latest
```


### 二、執行 Bitmark 節點

成功下載軟體更新之後，請在命令列終端機利用下列指令，移除舊版節點並重新運行節點：

```
docker rm -f bitmarkNode
docker run -d --name bitmarkNode -p 9980:9980 \
-p 2136:2136 -p 2130:2130 \
-e PUBLIC_IP=[YOUR_PUBLIC_IP] \
-v $HOME/bitmark-node-data/db:/.config/bitmark-node/db \
-v $HOME/bitmark-node-data/data:/.config/bitmark-node/bitmarkd/bitmark/data \
-v $HOME/bitmark-node-data/data-test:/.config/bitmark-node/bitmarkd/testing/data \
bitmark/bitmark-node
```


### 三、在網頁使用者介面重新啟動服務

最後，在網頁使用者介面上重啟`bitmarkd`及選擇性重啟`recorderd`程式。在多數的電腦系統中，網頁使用者介面可以用`localhost`位址(`127.0.0.1`)上的`9980`連接埠來存取，如下面的鏈結：

> [http://127.0.0.1:9980](http://127.0.0.1:9980)

載入網頁使用者介面之後，您可以在上面啟動兩個主要的 Bitmark 節點程式：

1. `bitmarkd` - 負責驗證 Bitmark 交易並記錄於 Bitmark 區塊鏈上（所有 Bitmark 節點都必須執行此程式）
2. `recorderd` - 負責運算 Bitmark 區塊鏈的工作量證明演算法，該演算法決定一個節點是否贏得某區塊並獲得獎金（此為選項程式）

重新執行`bitmarkd`之後，節點會經過一個`Resynchronizing`的同步階段。此階段會下載目前 Bitmark 區塊鏈上的資訊至您的節點。一旦同步階段完成之後，您的 Bitmark 節點會開始為最新的區塊做驗證並且記錄交易。
