# Sharp docker image

## 1. Docker image registry

Create the ECR repository to host the handler Docker image.

```shell
aws ecr create-repository --repository-name common/sharp-base --tags Key=application,Value=common/sharp-base
aws ecr put-lifecycle-policy --repository-name common/sharp-base --lifecycle-policy-text "file://ecr-lifecycle-policy.json"
```

### 2. Build image

```shell
make build
```

### 3. Push image

```shell
make push
```
