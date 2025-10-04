### Explaination for

```
- aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI
```

```
flowchart TD
    A[GitHub Repo] -->|Merge / Commit| B[CodePipeline / CodeBuild]
    B --> C[CodeBuild Container]

    subgraph "CodeBuild Steps"
        C1[1️⃣ aws ecr get-login-password --region $AWS_REGION] --> C2[2️⃣ docker login --username AWS --password-stdin $ECR_URI]
        C2 --> C3[3️⃣ docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .]
        C3 --> C4[4️⃣ docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $ECR_URI/$IMAGE_REPO_NAME:$IMAGE_TAG]
        C4 --> C5[5️⃣ docker push $ECR_URI/$IMAGE_REPO_NAME:$IMAGE_TAG]
    end

    C --> C1
    C5 --> D[Amazon ECR]
    D --> E[ECS / Lambda / Other Deployment Targets]
```

- get-login-password → temporary token (expires in 12 hours)
- docker login → authenticates Docker using that token
- After login, any Docker commands can interact with ECR (build, tag, push)
- This pattern is what CI/CD pipelines like CodeBuild always use to push Docker images to AWS ECR.
