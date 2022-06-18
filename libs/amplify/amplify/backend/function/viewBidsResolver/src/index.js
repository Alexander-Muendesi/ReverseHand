const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const ReverseHandTable = process.env.REVERSEHAND;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event, context) => {
    // console.log(event.arguments.advert_id);
    // console.log(context);

    try {
        let params = {
            TableName: ReverseHandTable,
            KeyConditionExpression: "part_key = :p and begins_with(sort_key, :b)",
            ExpressionAttributeValues: {
                ":p": event.arguments.ad_id,
                ":b": "b#",
            }
        };
        const data = await docClient.query(params).promise();
        // console.log(data);
        let items = data["Items"];
        
        console.log(items);
        
        let bids = [];
        for (let item of items) {
            bids.push({
                id: item['sort_key'],
                advert_id: event.arguments.ad_id, // since this is the advert we searched for
                user_id: item['bid_details']['tradesman_id'],
                name: item['bid_details']['name'],
                price_lower: item['bid_details']['price_lower'],
                price_upper: item['bid_details']['price_upper'],
                quote: item['bid_details']['quote'],
                date_created: item['bid_details']['date_created'],
                date_closed: item['bid_details']['date_closed']
            });
        }

        return bids;
    } catch(e) {
        console.log(e)
        return e;
    }
};
