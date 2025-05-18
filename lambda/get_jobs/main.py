import json

def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, OPTIONS",
            "Access-Control-Allow-Headers": "*"
        },
        "body": json.dumps({
            "jobs": ["Developer", "Designer"]
        })
    }
