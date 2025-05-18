import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('job_applications')

def lambda_handler(event, context):
    try:
        response = table.scan()
        applications = response.get('Items', [])

        return {
            'statusCode': 200,
            'body': json.dumps({'applications': applications})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

