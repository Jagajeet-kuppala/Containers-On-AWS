#!/bin/sh

export accountID="428630729476"
export awsRegion="ap-south-1"
export repoUri="$accountID.dkr.ecr.$awsRegion.amazonaws.com"
export repoName="server"
export imageTag="v15"

echo "ECR login through Docker login"
aws ecr get-login-password --region $awsRegion | docker login --username AWS --password-stdin $repoUri

echo "Build image"
docker build -t $repoName .

echo "Tag image"
docker tag $repoName $repoUri/$repoName:$imageTag

echo "Push image"
docker push $repoUri/$repoName:$imageTag

echo "sleeping for 7 seconds"
sleep 7
echo "Vulnerability status"
aws ecr describe-image-scan-findings --repository-name $repoName --image-id imageTag=$imageTag --region ap-south-1 | jq ".imageScanFindings.findingSeverityCounts"
echo "DONE"
