import re
import tweepy
import requests
import pandas as pd
import numpy as np

# credentials to access Twitter API
API_KEY = os.environ.get("API_KEY")
API_KEY_SECRET = os.environ.get("API_KEY_SECRET")
BEARER_TOKEN = os.environ.get("BEARER_TOKEN")
ACCESS_TOKEN = os.environ.get("ACCESS_TOKEN")
ACCESS_TOKEN_SECRET = os.environ.get("ACCESS_TOKEN_SECRET")


# create an OAuthHandler instance
client = tweepy.Client(
    BEARER_TOKEN,
    API_KEY,
    API_KEY_SECRET,
    ACCESS_TOKEN,
    ACCESS_TOKEN_SECRET, 
)

zdat = pd.read_csv('URLs.csv')
i = np.random.randint(0,len(zdat),size=1)
z = zdat.iloc[i-1]
fish_pic = z.iloc[0,1]
img_data = requests.get(fish_pic).content
with open("fishpic.jpg", "wb") as handler:
    handler.write(img_data)

tweepy_auth = tweepy.OAuth1UserHandler(
    "{}".format(API_KEY),
    "{}".format(API_KEY_SECRET),
    "{}".format(ACCESS_TOKEN),
    "{}".format(ACCESS_TOKEN_SECRET),
)
tweepy_api = tweepy.API(tweepy_auth)
post = tweepy_api.simple_upload("fishpic.jpg")
text = str(post)
media_id = re.search("media_id=(.+?),", text).group(1)
payload = {"text":z.iloc[0,0], "media": {"media_ids": ["{}".format(media_id)]}}

poast_text = str(z.iloc[0,0])
info = (poast_text[:278] + '..') if len(poast_text) > 278 else poast_text

# create a tweet
def poast():
    client.create_tweet(text=info,
                        media_ids=["{}".format(media_id)])

# main function
def main():
    poast()

# call main function
if __name__ == "__main__":
    main()