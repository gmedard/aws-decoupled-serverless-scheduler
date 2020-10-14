#!/bin/bash
id=15
job_id="jobId_$id"
success_string="Job"
JSON_STRING=$( jq -n --arg jbid "$job_id" --arg idd "$id" --arg s_str "$success_string" '{job_id: $jbid, retry: "3", job_success_string: $s_str, ssm_document: "AWS-RunShellScript", commands: ["#!/bin/bash \n echo Job successfully completed"]}')

while [ $id -le $1 ]
do
    echo "Submitting Job_$id"
    aws sqs send-message --queue-url https://sqs.us-east-2.amazonaws.com/719013286345/linuxresourcemanagement1979-job-queue --message-body "$JSON_STRING"
    id=$(( $id + 1 ))
done