import requests
from bs4 import BeautifulSoup
import os

class ScrapingData:

    def __init__(self):

        self.sayac = 0
        
        self.myMovieNamesList = []
        self.myMovieGenresList = []
        self.myMovieDescriptionsList = []
        self.myMovieRatesList = []
        self.myMovieDirectorsList = []
        self.myMovieStarsList = []
        self.myMovieSmallImageURL = []
        self.movieDictList = []
        self.movieDict = {}

        for i in range(1,4):
            r = requests.get("https://www.imdb.com/list/ls004610270/?sort=list_order,asc&st_dt=&mode=detail&page="+str(i)+"&ref_=ttls_vm_dtl")
            self.soup = BeautifulSoup(r.content,"html.parser")

            self.getMovieName()
            self.getMovieGenre()
            self.getMovieDescription()
            self.getMovieRate()
            self.getMovieDirector()
            self.getMovieStar()
            self.getMovieImage()

        for i in range(0,299):
            self.movieDict = {
                "movieName" :self.myMovieNamesList[i],
                "movieStars":self.myMovieStarsList[i],
                "movieRate": float((self.myMovieRatesList[i])),
                "movieDirector" : self.myMovieDirectorsList[i],
                "movieImageUrl" : self.myMovieSmallImageURL[i],
                "movieDescription" : self.myMovieDescriptionsList[i],
                "movieGenre" : self.myMovieGenresList[i]
            }
            self.movieDictList.append(self.movieDict)
    
        # print(self.movieDictList)
        
        # print(len(self.myMovieNamesList),len(self.myMovieSmallImageURL))



    def getMovieImage(self):
        mylist = self.soup.find_all("div",{"class":"lister-item mode-detail"})
        

        for x in mylist:
            image = x.find("img",{"class":"loadlate"})
            image = image.get("loadlate")
            self.myMovieSmallImageURL.append(image)

            # imgurl = requests.get(image)
            # name = self.myMovieNamesList[self.sayac].replace(":","_").replace("é","e")
            # picturePath = "C:\\Users\\mehme\\Desktop\\Mehmet\\Mehmet\\Flutter\\imdb_proje\\assets\\images\\"+name+"_Image.jpg"
            # # print(picturePath)

            # if not(os.path.exists(picturePath)):
            #     with open(picturePath,"wb") as file:
            #             file.write(requests.get(image).content)
            #     self.sayac = self.sayac + 1

            # print(self.sayac)

    def getMovieStar(self):
        mylist = self.soup.find_all("p",{"class":"text-muted text-small"})
        for x in range(1,len(mylist),3):
            data = mylist[x].text.strip().replace("\n","")
            start = data.find("Stars:") + 6
            stars = data[start:]
            self.myMovieStarsList.append(stars)

        
    def getMovieDirector(self):
        mylist = self.soup.find_all("p",{"class":"text-muted text-small"})
        for x in range(1,len(mylist),3):
            director = mylist[x].find("a").text
            self.myMovieDirectorsList.append(director)


    def getMovieRate(self):
        mylist = self.soup.find_all("div",{"class":"ipl-rating-star small"})
        for x in mylist:
            rate = x.find("span",{"ipl-rating-star__rating"}).text.strip()
            self.myMovieRatesList.append(rate)
            


    def getMovieDescription(self):
        mylist = self.soup.find_all("div",{"class":"lister-item-content"})

        for x in mylist:
            description = x.find("p",{"class":""}).text.strip()
            self.myMovieDescriptionsList.append(description)
            

    def getMovieGenre(self):
        mylist = self.soup.find_all("div",{"class":"lister-item-content"})
        
        for x in mylist:
            genre = x.find("span",{"class":"genre"}).text.strip()
            self.myMovieGenresList.append(genre)

  
    def getMovieName(self):

        mylist = self.soup.find_all("h3",{"class":"lister-item-header"})

        for x in mylist:
            movieName = x.find("a").text
            self.myMovieNamesList.append(movieName)

