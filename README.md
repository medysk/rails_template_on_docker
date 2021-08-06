# README

Rrails + MariaDB の開発環境をDockerで構築  
Git templateでの使用を想定  

## 事前準備

以下を準備しておく  

- docker
- docker-compose
- direnv

## 環境

**ruby 3.0.2**  
変更する場合、Dockerfileで任意のイメージを指定  

**rails 6.1.4**  
変更する場合、Gemfileを修正  

## 構築手順

### direnv

**.envrc.sample** を編集し **.envrc** にリネーム  

### rails

rails作成  

```sh
# rails作成
# 下記コマンドでGemfileとREADME.md(当ファイル)が強制的に上書きされる
# 上書きしたくない場合は、'-f'オプションを外して'rails new'する
docker-compose run --rm web rails new . -TBGf --database=mysql

docker imageをビルドする  
`docker-compose build`  

# webpackerのインストール
docker-compose run --rm web rails webpacker:install
```

DB接続設定  

'config/database.yml'を編集する  

```yml:config/database.yml
username: <%= ENV['DB_USER'] %>
password: <%= ENV['DB_PASSWORD'] %>
host: <%= ENV['DB_HOST'] %>
```

## dockerコンテナとrailsの起動

すべてのコンテナを起動(バックグラウンドで実行する場合`-d`オプションを使用する)  
`docker-compose up`  

Database作成  
`docker-compose run --rm web rails db:create`  
