const { MongoClient } = require("mongodb");

exports.handler = async function (event) {
  const uri = "mongodb://mongo-service:27017"; // Update with actual MongoDB URI
  const client = new MongoClient(uri);

  try {
    await client.connect();
    const database = client.db("testdb");
    const collection = database.collection("test");
    const result = await collection.findOne({});

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "MongoDB Connected", data: result }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  } finally {
    await client.close();
  }
};
