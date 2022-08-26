<<<<<<< HEAD
const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

// Creates a new user
// Requires
/*
    id:from AWS Cognito, passed in to avoid working with layers
    location: {lat, long}
*/
// Optional
/*
    tradetypes: []
    domains:
*/
exports.handler = async (event) => {
    try {
        let item = {
            TableName: UserTable,
            Item: {
                user_id: event.arguments.user_id,
                name: event.arguments.name,
                email: event.arguments.email,
                cellNo: event.arguments.cellNo,
                notifications: [],
                reviews: [],
                location: event.arguments.location,
                sum: 0,
                adverts_won: []
            }
        };
        
        if (event.arguments.domains !== undefined) {
            item.Item.domains = event.arguments.domains;
        }
        
        if (event.arguments.tradetypes !== undefined) {
            item.Item.tradetypes = event.arguments.tradetypes;
        }
        
        await docClient.put(item).promise();
        
        item.Item.id = item.Item.user_id;
        delete item.Item.user_id;
        return item.Item;
    } catch(e) {
        console.log(e);
    }
};
>>>>>>> 998e713cd6b197805ac4eee5adf686e0436dd616
