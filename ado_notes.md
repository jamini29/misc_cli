### auth
export AZURE_DEVOPS_EXT_PAT=xxxAZURExPATxxx

### trigger pipeline run example:
```
az pipelines run --org https://dev.azure.com/hyperspace-pipelines-2/ --project=aminich-org --name ado_maven_jacoco_sonar --output json
```

