#!/bin/bash
id=0
job_id="jobId_$id"
success_string="Hello"
JSON_STRING=$( jq -n --arg jbid "$job_id" --arg idd "$id" --arg s_str "$success_string" '{job_id: $jbid, retry: "3", job_success_string: $s_str, ssm_document: "AWS-RunShellScript", commands: ["#!/bin/bash \n echo Hello Job successfully completed"]}')

while [ $id -le $1 ]
do
    echo "Submitting Job_$id"
    aws sqs send-message --queue-url https://sqs.us-east-2.amazonaws.com/215728104527/serverless-scheduler-app-job-queue --message-body "$JSON_STRING" --profile A4L-DEV --region us-east-2
    id=$(( $id + 1 ))
done