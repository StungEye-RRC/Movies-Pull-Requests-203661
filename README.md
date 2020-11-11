# Rails at the Movies

Building a web app around [the IMDB Movie dataset](https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset).

After cloning repo:

```
cd Movies-Pull-Requests-203661
bundle install
yarn install
rails db:migrate
rails db:seed
```
You can also have a startup script run these commands for you, if you are feeling lazy by running
```
ruby startup.rb
```
From the root directory of this project
## Models

Production Company

- name (string, present, unique)

Movie

- title (string, present, unique)
- year (integer, present)
- duration (integer, present)
- description (text, present)
- average_vote (decimal, present)
- production_company_id (FK)

## Routes

```
GET /                         (Home Page)
GET /movies                   (Show all Movies)
GET /movies/:id               (Show a Movie by ID)
GET /production_companies     (Show all Production Companies)
GET /production_companies/:id (Show a Production Company by ID)
```

## Controllers

HomeController - index
MoviesController - index, show
ProductionCompaniesController - index, show
