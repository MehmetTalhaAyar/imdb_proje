import firebase_admin
from imdb_Veri import ScrapingData
from firebase_admin import credentials
from firebase_admin import firestore



class FirebaseVeritabani:
  def __init__(self):

    cred = credentials.Certificate('C:/Users/mehme/Desktop/Mehmet/Mehmet/Flutter/imdb_proje/lib/permisson/serviceAccount.json')
    firebase_admin.initialize_app(cred)
    self.db = firestore.client()

    self.writeMovie()

  def writeMovie(self):
    batch = self.db.batch()
    
    myData = ScrapingData()

    print("yazdirma islemi basliyor.")

    for i in range(0,299):
      myDictionary = myData.movieDictList[i]
      
      documentRef = self.db.collection(u"movies").document(myDictionary["movieName"])
      print(i+1)
      batch.set(documentRef,myDictionary)

    batch.commit()



    # nyc_ref = db.collection(u'cities').document(u'NYC')
    # batch.set(nyc_ref, {u'name': u'New York City'})
    # _batch.set(_yeniDocId, {"counter": ++i, "id": _yeniDocId.id});

FirebaseVeritabani()