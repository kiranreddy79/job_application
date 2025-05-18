import json
import boto3
import uuid
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('job_applications')

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])

        application = {
            'application_id': str(uuid.uuid4()),
            'job_id': body.get('job_id'),
            'name': body.get('name'),
            'email': body.get('email'),
            'resume_url': body.get('resume_url'),
            'submitted_at': datetime.utcnow().isoformat()
        }

        table.put_item(Item=application)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Application submitted', 'application_id': application['application_id']})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

