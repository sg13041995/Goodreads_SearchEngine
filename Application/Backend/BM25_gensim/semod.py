import numpy as np
import re
import pickle
import json
from nltk.tokenize import word_tokenize
from gensim.models import TfidfModel
from gensim.corpora import Dictionary
from gensim.models import OkapiBM25Model
from gensim.similarities import SparseMatrixSimilarity

from configparser import ConfigParser
from mysql.connector import MySQLConnection, Error
from datetime import datetime


def get_pkl_file(path, mode="rb"):
    with open(path, mode) as file:
        data = pickle.load(file)
        return data


def get_trained_bm25(path='./Resources/bm25_index.pkl', mode='rb'):
    with open(path, mode) as file:
        bm25_index = pickle.load(file)
        return bm25_index


def retrain_gensim_bm25(tokenized_documents):
    dictionary = Dictionary(tokenized_documents)
    bm25_model = OkapiBM25Model(dictionary=dictionary)
    bm25_corpus = bm25_model[list(
        map(dictionary.doc2bow, tokenized_documents))]
    bm25_index = SparseMatrixSimilarity(bm25_corpus, num_docs=len(tokenized_documents), num_terms=len(dictionary),
                                        normalize_queries=False, normalize_documents=False)

    return dictionary, bm25_index


def bm25_top_hits(query, dictionary, bm25_index, n=50):
    processed = re.sub("\s+", " ", re.sub("[^a-zA-Z0-9 ]", "", query.lower()))
    tokenized_query = word_tokenize(processed)

    # Enforce binary weighting of queries
    tfidf_model = TfidfModel(dictionary=dictionary, smartirs='bnn')
    tfidf_query = tfidf_model[dictionary.doc2bow(tokenized_query)]
    similarities = bm25_index[tfidf_query]

    # getting document indices based on BM25 top scores in descending order
    top_n = np.argsort(similarities, axis=0)[::-1]

    top_n = top_n[:n]

    # increasing all indices values by 1 and then return that list
    return top_n + 1


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


def connect(creds):
    con = None
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


def list_to_str(data):
    return str(data).lstrip("[").rstrip("]")


def get_data_by_index(
        indices,
        cs,
        proc_name="sp_get_books_by_index",
        proc_args_initial=[0]
):

    indices_as_str = list_to_str(list(indices))

    procs_args_complete = []
    procs_args_complete.extend(proc_args_initial)
    procs_args_complete.extend([indices_as_str])

    cs.callproc(proc_name, procs_args_complete)

    books = [r.fetchall() for r in cs.stored_results()]

    return books


def to_json(data):
    mapping_function = lambda x: {
        "book_id" : x[0],
        "gr_book_id" : x[1],
        "title_without_series" : x[2],
        "mod_title" : x[3],
        "title" : x[4],
        "mod_title_without_series" : x[5],
        "description" : x[6],
        "ratings_count" : x[7],
        "average_rating" : x[8],
        "num_pages" : x[9],
        "publication_day" : x[10],
        "publication_month" : x[11],
        "publication_year" : x[12],
        "isbn" : x[13],
        "isbn13" : x[14],
        "publisher" : x[15],
        "country_code" : x[16],
        "language_code" : x[17],
        "url" : x[18],
        "image_url" : x[19],
        "link" :x[20]
    }

    # Use map to apply the mapping function to each tuple
    list_of_dicts = list(map(mapping_function, data))

    json_data = json.dumps(list_of_dicts,indent=4)

    return json_data
