FROM alpine as build
# install build tools
RUN apk add go git ca-certificates
# cache dependencies
ADD go.mod go.sum ./
RUN go mod download # GOPROXY=direct
# build
ADD . .
RUN go build -o /main

# copy artifacts to a clean image
FROM alpine as test
COPY --from=build /main /main
# (Optional) Add Lambda Runtime Interface Emulator and use a script in the ENTRYPOINT for simpler local runs
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /usr/bin/aws-lambda-rie
RUN apk add ca-certificates
RUN chmod 755 /usr/bin/aws-lambda-rie
COPY entry.sh /
RUN chmod 755 /entry.sh
ENTRYPOINT [ "/entry.sh" ]

FROM alpine as prod
COPY --from=build /main /main
RUN apk add ca-certificates
ENTRYPOINT ["/main"]

