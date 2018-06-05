from pymongo import MongoClient

if __name__ == "__main__":
    client = MongoClient()
    client.drop_database('tbda')