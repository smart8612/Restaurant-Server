# 🍴 Restaurant Server

## ⭐️ Overview

* 레스토랑 서버에 카테고리, 음식 메뉴를 확인하고 주문을 넣을 수 있습니다.
* [OrderClient](https://github.com/smart8612/OrderClient)에 http API를 제공합니다.

## 📰 Related Articles

Restaurant Server 개발과정 및 의도는 다음의 블로그 게시물에서 확인하실 수 있습니다.

### 1️⃣ iOS 앱 설계 퓨전 레시피 연재

* [6부 - 모델링](https://singularis7.tistory.com/92)

* [7부 - 네트워크 코드 모델링](https://singularis7.tistory.com/93)

### 2️⃣ 기술 참조 자료

* [singularis7's Life Note](https://singularis7.tistory.com)

* [Swift Vapor docs](https://docs.vapor.codes/)

* [WWDC22 - Use Xcode for server-side development](https://developer.apple.com/wwdc22/110360)

## 🛠️ Used Technology

#### 패키지 의존성

* [Vapor](https://vapor.codes): Non-blocking, event-driven architecture built on top of Apple's [SwiftNIO](https://github.com/apple/swift-nio).
* [Fluent](https://github.com/vapor/fluent): Vapor ORM (queries, models, and relations) for NoSQL and SQL databases

#### 도구

`#Docker` `#Xcode` `#Swift`

## ⚙️ Installation

1. 소스 코드를 컴퓨터에 클론 받습니다.

2. Docker를 설치합니다.

3. 프로젝트 디렉토리에서 다음의 명령어 수행합니다

   ```shell
   // 독커 가상환경에 서버 및 데이터베이스 이미지를 설치합니다.
   > docker-compose build
   
   // 독커 가상환경에 설치된 서버 및 데이터베이스 이미지를 구동합니다.
   > docker-compose up --detached app
   
   // 독커 가상환경에 설치된 서버 프로그램이 데이터베이스를 구성하도록 명령합니다.
   > docker-compose run migrate
   
   // 독커 가상환경에 설치된 서버 및 데이터베이스를 종료하고 싶은 경우 다음의 명령어를 실행합니다.
   > docker-compose down
   
   // 독커 가상환경에 설치된 서버 및 데이터베이스의 사용자 설정 내역을 지우고 싶은 경우 "-v" 옵션을 추가합니다.
   > docker-compose down -v
   ```


## 🤼 연관 프로젝트

Restaurant Server 연관된 샘플 프로젝트를 다음의 Repository에서 확인하실 수 있습니다.

* 📱 Restaurant Order Application : [OrderApp Toy Project](https://github.com/smart8612/OrderApp-Toy-Project)
