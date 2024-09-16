#!/bin/bash
SERVICE_NAME=$1
RELEASE_VERSION=$2
protoc --go_out=./golang \
       --go_opt=paths=source_relative \
       --go-grpc_out=./golang \
       --go-grpc_opt=paths=source_relative \
       ./${SERVICE_NAME}/*.proto
cd golang/${SERVICE_NAME}
go mod init \
       github.com/MarcusXia/microservices-proto/golang/${SERVICE_NAME} ||true
go mod tidy
cd ../../
git config --global user.email "xia2000_cn@sina.com"
git config --global user.name "MarcusXia"
git add . && git commit -am "proto update" || true
git tag -fa golang/${SERVICE_NAME}/${RELEASE_VERSION} \
        -m "golang/${SERVICE_NAME}/${RELEASE_VERSION}"
git push origin refs/tags/golang/${SERVICE_NAME}/${RELEASE_VERSION}