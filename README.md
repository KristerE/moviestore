# README

Ett API för en filmbutik.
Den innehåller inget grafiskt gränssnitt utan alla funktioner är kollade med "Postman" (https://www.postman.com/).

Man kan skapa, ta bort, ändra kategori och ändra pris på artiklar.
Man kan skapa/ ta bort kunder eller ändra deras poäng och address.

Vid försäljning genereras ett verifikationsnummer som kan användas till att få fram en order/faktura med information om de artiklar som köptes och kunden om denne är registrerad.

URL (localhost)

GET:

http://127.0.0.1:3000/api/v1/categories En lista på kategorier

http://127.0.0.1:3000/api/v1/customers/ En lista på kunder
http://127.0.0.1:3000/api/v1/customers/1 Visar info om kund med id=1

http://127.0.0.1:3000/api/v1/articles/1 Visar information om artikel 
http://127.0.0.1:3000/api/v1/articles/find/ Söker artikel. Fungerar på artikelnummer och namn.

http://127.0.0.1:3000/api/v1/orders/12d4970b-ecf9-4dd5-b2c1-2408eed052a4 Visar order med verifikationsnummer =12d4970b-ecf9-4dd5-b2c1-2408eed052a4


PUT:

http://127.0.0.1:3000/api/v1/customers/1 Uppdaterar kund med id 1
Parametrar: (valfria) name:, address:, points:

http://127.0.0.1:3000/api/v1/articles/2 Uppdaterar artikel med artikelnummer 2
Parametrar price:, category:


POST:

http://127.0.0.1:3000/api/v1/articles Skapar en ny artikel. 
Parametrar name: och category: (name=titel på filmen, category=kategori [1-3])
http://127.0.0.1:3000/api/v1/customers/ Skapar en ny kund.
Parametrar: name:, address: points:(valfri)

http://127.0.0.1:3000/api/v1/orders/  Lagrar data från försäljningen och information om kunden (om denne är registrerad)
Parametrar: 
Nödvändig: data:[] (en array av json objekt. Minst ett objekt)
Nödvändiga om kunden finns: customer_id:, used_points (de poäng kunden vill utnyttja. Kontroll görs så kunden redan har dessa poäng)
JSON object. ex:
{
   "article_number": 1,
   "name": "Kasta loss! Sommaren är här",
   "category": 3,
   "price": "200.0",
   "points": 20
}


DELETE:

http://127.0.0.1:3000/api/v1/articles/1 Tar bort artikel med artikelnummer 1

http://127.0.0.1:3000/api/v1/customers/5 Tar bort kund med id 5






