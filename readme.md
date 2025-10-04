### Explaination for

```
- aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI
```

[GitHub Repo]
|
v (merge / commit triggers)
[CodePipeline / CodeBuild]
|
v
+----------------------------+
| CodeBuild Container |
|----------------------------|
| 1️⃣ aws ecr get-login-password --region $AWS_REGION
|       -> AWS ECR returns temporary auth token
|
|  2️⃣ docker login --username AWS --password-stdin $ECR_URI
|       -> Docker uses token to authenticate to ECR
|
|  3️⃣ docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .
| -> Build Docker image locally in container
|
| 4️⃣ docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $ECR_URI/$IMAGE_REPO_NAME:$IMAGE_TAG
|       -> Tag image for ECR
|
|  5️⃣ docker push $ECR_URI/$IMAGE_REPO_NAME:$IMAGE_TAG
| -> Push image to ECR repository
+----------------------------+
|
v
[Amazon ECR]
|
v
[ECS / Other Deployment Targets]

- get-login-password → temporary token (expires in 12 hours)
- docker login → authenticates Docker using that token
- After login, any Docker commands can interact with ECR (build, tag, push)
- This pattern is what CI/CD pipelines like CodeBuild always use to push Docker images to AWS ECR.
