const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const UserTable = process.env.USER;

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    try {
        let args = [];
        let expressionAttributeNames = {};

        if(event.arguments.cellNo !== undefined){
            args.push('#cellNo = :cellNo');
            expressionAttributeNames['#cellNo'] = 'cellNo';
        }
        if(event.arguments.domains !== undefined){
            args.push('#domains = :domains');
            expressionAttributeNames['#domains'] = 'domains';
        }

        if(event.arguments.location.address.city !== undefined){
            args.push('#location.address.city = :city');
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.location.address.street !== undefined){
            args.push('#location.address.street = :street');
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.location.address.streetNumber !== undefined)
        {
            args.push('#location.address.streetNumber = :streetNumber');
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.location.address.zipCode !== undefined)
        {
            args.push("#location.address.zipCode = :zipCode");
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.location.coordinates.lat !== undefined)
        {
            args.push('#location.coordinates.lat = :lat');
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.location.coordinates.lng !== undefined)
        {
            args.push("#location.coordinates.lng = :lng");
            expressionAttributeNames['#location'] = 'location';
        }

        if(event.arguments.name !== undefined){
            args.push('#name = :name');
            expressionAttributeNames['#name'] = 'name';
        }

        let updateExpression = 'set ';

        for (let i = 0; i < args.length - 1; i++)
            updateExpression += args[i] + ', ';
        updateExpression += args[args.length - 1];
        
        let expressionAttributeValues = {};

        expressionAttributeValues[':cellNo'] = event.arguments.cellNo;
        expressionAttributeValues[':domains'] = event.arguments.domains;
        expressionAttributeValues[':city'] = event.arguments.location.address.city;
        expressionAttributeValues[':street'] = event.arguments.location.address.street;
        expressionAttributeValues[':streetNumber'] = event.arguments.location.address.streetNumber;
        expressionAttributeValues[':zipCode'] = event.arguments.location.address.zipCode;
        expressionAttributeValues[':lat'] = event.arguments.location.coordinates.lat;
        expressionAttributeValues[':lng'] = event.arguments.location.coordinates.lng;
        expressionAttributeValues[':name'] = event.arguments.name;

        let params = {
            TableName: UserTable,
            Key: {
                user_id: event.arguments.user_id,
            },
            UpdateExpression: updateExpression,
            ExpressionAttributeValues: expressionAttributeValues,
            ExpressionAttributeNames: expressionAttributeNames,
        };

        await docClient.update(params).promise();

        // getting item to be returned
        params = {
            TableName: UserTable,
            Key: {
                user_id: event.arguments.user_id,
            }
        };

        const data = await docClient.get(params).promise();

        return data;
        
    } catch (error) {
        console.log(error);
    }
};
