# importing modules

import numpy as np
import re
import joblib
from sklearn.metrics.pairwise import cosine_similarity

from configparser import ConfigParser
from mysql.connector import MySQLConnection, Error

import json


def read_memory():
    vectorizer = joblib.load("../TFIDF/Memory/vectorizer_uni.pkl")
    tfidf = joblib.load("../TFIDF/Memory/tfidf_matrix_uni.pkl")
    return vectorizer,tfidf

# fetch credentials from config file
def read(filename='config.ini', section='mysql'):
    parser = ConfigParser()
    parser.read(filename)

    db = {}

    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception(f'{section} not found in file {filename}')
    return db


# Connect with MySQL or MariaDB database
def connect(creds):
    con = None
    cus = None
    try:
        print('Connecting to MySQL database...')
        con = MySQLConnection(**creds)

        if con.is_connected():
            print('Connection established')
            cus = con.cursor(buffered=True)
        else:
            print('Connection failed')

    except Error as e:
        print(e)
    finally:
        return con, cus

# search engine
# returns indices
def search(query, vectorizer, tfidf_matrix):
    processed = re.sub("\s+", " ", re.sub("[^a-zA-Z0-9 ]", "", query.lower()))

    query_vec = vectorizer.transform([processed])
    similarity = cosine_similarity(query_vec, tfidf_matrix)
    similarity = similarity.flatten().round(5)

    indices = np.argsort(similarity)[-30:]
    indices = np.array(list(reversed(indices)))

    top_similarities = similarity[indices]
    SIMILARITY_THRESHOLD = 0.50000
    sims_above_threshold = np.where(top_similarities >= SIMILARITY_THRESHOLD)

    if (len(sims_above_threshold[0]) < 1):
        return "Noting Relevant Found"
    else:
        max_index = (np.array(sims_above_threshold).max())
        indices = indices[:max_index+1]

    return indices

# converting indices into string format


def indices_to_str(indices):
    indices_str = ""

    for index in indices:
        indices_str = indices_str + f"{str(index + 1)},"

    # the indices string will end with , => 1,2,3,
    # so, truncating the last comma
    indices_str = indices_str[:-1]

    return indices_str


# get records from database
def get_all_recommendation(indices, cs, table="book"):
    columns_string = """
    book_id,
    gr_book_id,
    title,
    mod_title,
    ratings_count,
    average_rating,
    link,
    url,
    image_url,
    publication_day,
    publication_month,
    publication_year,
    num_pages,
    isbn,
    isbn13,
    description,
    publisher"""

    # getting the indices as string
    indices_str = indices_to_str(indices)

    # SQL query to get all records by id
    # maintain the arrangement of id as it is without re-arranging them by ascending or descending order
    sql_query = f"""
    SELECT {columns_string} FROM {table}
    WHERE book_id IN ({indices_str})
    ORDER BY FIELD(book_id, {indices_str});
    """

    # trying to execute the query
    try:
        cs.execute(sql_query)
    # throwing error in case of unsuccessful attempt
    except Error as e:
        raise Exception(f"{e}")


def tuplelist_to_json(data):
    # Convert list of tuples into a list of dictionaries with specific keys
    list_of_dicts = [
        {
            'book_id': book_id,
            'gr_book_id': gr_book_id,
            'title': title,
            'mod_title': mod_title,
            'ratings_count': ratings_count,
            'average_rating': float(average_rating),
            'link': link,
            'url': url,
            'image_url': image_url,
            'publication_day': publication_day,
            'publication_month': publication_month,
            'publication_year': publication_year,
            'num_pages': num_pages,
            'isbn': isbn,
            'isbn13': isbn13,
            'description': description,
            'publisher': publisher,
        } for book_id,
        gr_book_id,
        title,
        mod_title,
        ratings_count,
        average_rating,
        link,
        url,
        image_url,
        publication_day,
        publication_month,
        publication_year,
        num_pages,
        isbn,
        isbn13,
        description,
        publisher in data]

    # Convert list of dictionaries to JSON
    json_data = json.dumps(list_of_dicts, indent=2)

    return json_data

if __name__ == "__main__":
    cn,cs=connect(creds=read(filename="config.ini",section="mysql"))
    vectorizer,tfidf = read_memory()
    indices = search("goblet of fire",vectorizer,tfidf)
    print(indices)
    get_all_recommendation(indices,cs)
    json_data = tuplelist_to_json(cs.fetchall())
    with open("demo.json","w") as f: 
        f.write(json_data)
